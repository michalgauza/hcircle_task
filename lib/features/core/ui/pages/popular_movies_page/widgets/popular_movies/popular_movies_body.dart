import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../../utils/ui/pagination/pagination_listener.dart';
import '../../../../common_widgets/app_error_widget.dart';
import '../../../../common_widgets/app_loader.dart';
import '../../../../common_widgets/movie_tile.dart';
import '../../../../common_widgets/pagination_loader.dart';
import 'cubit/popular_movies_cubit.dart';

class PopularMoviesBody extends HookWidget with PaginationListener {
  const PopularMoviesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    return BlocConsumer<PopularMoviesCubit, PopularMoviesState>(
      listener: (_, state) {
        state.mapOrNull(
          idle: (idle) {
            paginationListener(
              context: context,
              paginationState: idle.paginationState,
              scrollController: scrollController,
              paginationHelper: context.read<PopularMoviesCubit>(),
            );
          },
        );
      },
      builder: (_, state) => state.map(
        idle: (idle) {
          final movies = idle.movies;
          return ListView.separated(
            // +1 for pagination loading indicator
            itemCount: movies.length + 1,
            separatorBuilder: (_, __) => const Divider(),
            controller: scrollController,
            itemBuilder: (_, index) {
              if (index < movies.length) {
                return MovieTile(movie: movies[index]);
              } else {
                return PaginationLoader(idle.paginationState);
              }
            },
          );
        },
        loading: (_) => const AppLoader(),
        error: (error) => AppErrorWidget(
          failure: error.failure,
          retry: context.read<PopularMoviesCubit>().retry,
        ),
      ),
    );
  }
}
