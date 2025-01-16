import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/injectable/injectable.dart';
import 'cubit/popular_movies_cubit.dart';
import 'widgets/popular_movies_body.dart';

@RoutePage()
class PopularMoviesPage extends StatelessWidget {
  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocProvider<PopularMoviesCubit>(
            create: (context) => getIt()..init(),
            child: const PopularMoviesBody(),
          ),
        ),
      );
}
