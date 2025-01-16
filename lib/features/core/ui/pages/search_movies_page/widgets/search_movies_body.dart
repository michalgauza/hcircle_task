import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../utils/ui/extension/context_extension.dart';
import '../../../../../../utils/ui/pagination/pagination_listener.dart';
import '../../../common_widgets/app_error_widget.dart';
import '../../../common_widgets/app_loader.dart';
import '../../../common_widgets/movie_tile.dart';
import '../../../common_widgets/pagination_loader.dart';
import '../cubit/search_movies_cubit.dart';

class SearchMoviesBody extends HookWidget with PaginationListener {
  const SearchMoviesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              hintText: context.translation.movieTitle,
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: context.read<SearchMoviesCubit>().searchMovies,
          ),
        ),
        Expanded(
          child: BlocConsumer<SearchMoviesCubit, SearchMoviesState>(
            listener: (_, state) {
              state.mapOrNull(
                idle: (idle) {
                  paginationListener(
                    context: context,
                    paginationState: idle.paginationState,
                    scrollController: scrollController,
                    paginationHelper: context.read<SearchMoviesCubit>(),
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
              error: (error) => AppErrorWidget(failure: error.failure),
              initial: (_) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.translation.searchForMovies,
                        style: GoogleFonts.poppins(fontSize: 24),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.search,
                        size: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
