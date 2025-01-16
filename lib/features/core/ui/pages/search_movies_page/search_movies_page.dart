import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/injectable/injectable.dart';
import '../../../../../utils/ui/extension/context_extension.dart';
import 'cubit/search_movies_cubit.dart';
import 'widgets/search_movies_body.dart';

@RoutePage()
class SearchMoviesPage extends StatelessWidget {
  const SearchMoviesPage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.translation.searchMovies),
          ),
          body: BlocProvider<SearchMoviesCubit>(
            create: (context) => getIt(),
            child: const SearchMoviesBody(),
          ),
        ),
      );
}
