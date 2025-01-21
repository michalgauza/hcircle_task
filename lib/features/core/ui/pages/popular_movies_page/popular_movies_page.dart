import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../utils/injectable/injectable.dart';
import '../../../../../utils/ui/router/app_router.gr.dart';
import 'widgets/popular_movies/cubit/popular_movies_cubit.dart';
import 'widgets/popular_movies/popular_movies_body.dart';
import 'widgets/top_rated_movies/cubit/top_rated_movies_cubit.dart';
import 'widgets/top_rated_movies/top_rated_movies_body.dart';

@RoutePage()
class PopularMoviesPage extends HookWidget {
  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: tabController,
            tabs: const [
              Tab(text: 'Popular'),
              Tab(text: 'Top Rated'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: () => context.router.push(const SearchMoviesRoute()),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<PopularMoviesCubit>(
                create: (context) => getIt()..init()),
            BlocProvider<TopRatedMoviesCubit>(
                create: (context) => getIt()..init()),
          ],
          child: TabBarView(
            controller: tabController,
            children: [
              const PopularMoviesBody(),
              const TopRatedMoviesBody(),
            ],
          ),
        ),
      ),
    );
  }
}
