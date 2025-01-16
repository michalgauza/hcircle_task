import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/injectable/injectable.dart';
import '../../../../../utils/ui/router/app_router.gr.dart';
import 'cubit/popular_movies_cubit.dart';
import 'widgets/popular_movies_body.dart';

@RoutePage()
class PopularMoviesPage extends StatelessWidget {
  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.search),
            onPressed: () => context.router.push(const SearchMoviesRoute()),
          ),
          body: BlocProvider<PopularMoviesCubit>(
            create: (context) => getIt()..init(),
            child: const PopularMoviesBody(),
          ),
        ),
      );
}
