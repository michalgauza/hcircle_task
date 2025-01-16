import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../domain/entity/movie.dart';
import '../../../common_widgets/app_error_widget.dart';
import '../../../common_widgets/app_loader.dart';
import '../cubit/movie_details_cubit.dart';

class MovieDetailsBody extends StatelessWidget {
  const MovieDetailsBody({
    required this.movie,
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              SizedBox(
                height: 500,
                child: Image.network(
                  movie.bigPoster,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.error_outline_sharp),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                movie.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
                builder: (_, state) => state.map(
                  error: (error) => AppErrorWidget(
                    failure: error.failure,
                    retry: context.read<MovieDetailsCubit>().retry,
                  ),
                  loading: (_) => const AppLoader(),
                  loaded: (loaded) {
                    final details = loaded.movieDetails;
                    return Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_month_sharp),
                            const SizedBox(width: 4),
                            Text(details.releaseDate),
                            const Spacer(),
                            const Icon(Icons.star),
                            const SizedBox(width: 4),
                            Text(details.rating.toStringAsFixed(1)),
                            const Spacer(),
                            const Icon(Icons.timer_outlined),
                            const SizedBox(width: 4),
                            Text(_getTimeString(details.runtime)),
                            const Spacer(),
                            const Icon(Icons.language),
                            const SizedBox(width: 4),
                            Text(details.originalLanguage.toUpperCase()),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          details.overview,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          children: details.genres
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );

  String _getTimeString(int value) {
    final hour = value ~/ 60;
    if (hour == 0) return '${value}m';
    final minutes = value % 60;
    if (minutes == 0) return '${hour}h';

    return '${hour}h and ${minutes.toString().padLeft(2, "0")}m';
  }
}
