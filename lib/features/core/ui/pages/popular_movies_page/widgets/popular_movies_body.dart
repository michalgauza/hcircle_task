import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/app_error_widget.dart';
import '../cubit/popular_movies_cubit.dart';

class PopularMoviesBody extends StatelessWidget {
  const PopularMoviesBody({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<PopularMoviesCubit, PopularMoviesState>(
        listener: (_, state) {},
        builder: (_, state) => state.map(
          idle: (idle) {
            final movies = idle.movies;
            return ListView.separated(
              itemBuilder: (_, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text('Title ${movie.title}'),
                  subtitle: Text('Subtitle ${movie.id}'),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: movies.length + 1,
            );
          },
          //TODO app page loader
          loading: (_) => Center(child: CircularProgressIndicator()),
          error: (error) => AppErrorWidget(
            failure: error.failure,
            retry: context.read<PopularMoviesCubit>().retry,
          ),
        ),
      );
}
