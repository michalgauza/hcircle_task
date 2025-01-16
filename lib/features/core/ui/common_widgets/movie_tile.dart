import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/ui/router/app_router.gr.dart';
import '../../domain/entity/movie.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    required this.movie,
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () => context.pushRoute(MovieDetailsRoute(movie: movie)),
        title: Row(
          children: [
            Image.network(
              width: 80,
              fit: BoxFit.fitWidth,
              movie.smallPoster,
              errorBuilder: (_, __, ___) => const SizedBox(
                width: 80,
                child: Center(
                  child: Icon(Icons.error_outline_sharp),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    movie.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    movie.releaseDate,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star),
            Text(
              movie.rating.toStringAsFixed(1),
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
      );
}
