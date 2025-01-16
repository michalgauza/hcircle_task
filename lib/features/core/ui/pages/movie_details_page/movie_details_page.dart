import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/injectable/injectable.dart';
import '../../../../../utils/ui/extension/context_extension.dart';
import '../../../domain/entity/movie.dart';
import 'cubit/movie_details_cubit.dart';
import 'widgets/movie_details_body.dart';

@RoutePage()
class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({
    required this.movie,
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              context.translation.details,
              style: GoogleFonts.poppins(),
            ),
          ),
          body: BlocProvider<MovieDetailsCubit>(
            create: (_) => getIt(param1: movie.id)..init(),
            child: MovieDetailsBody(movie: movie),
          ),
        ),
      );
}
