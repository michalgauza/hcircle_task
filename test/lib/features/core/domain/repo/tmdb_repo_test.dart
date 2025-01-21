import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hcircle_task/features/core/domain/entity/movie.dart';
import 'package:hcircle_task/features/core/domain/entity/movie_details.dart';
import 'package:hcircle_task/features/core/domain/entity/request/fetch_movie_details_request.dart';
import 'package:hcircle_task/features/core/domain/entity/request/fetch_popular_movies_request.dart';
import 'package:hcircle_task/features/core/domain/entity/request/search_movies_request.dart';
import 'package:hcircle_task/features/core/domain/entity/response/pagination_response.dart';
import 'package:hcircle_task/features/core/domain/repo/tmdb_repo.dart';
import 'package:hcircle_task/utils/failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tmdb_repo_test.mocks.dart';

@GenerateMocks([TmdbRepo])
void main() {
  late MockTmdbRepo mockTmdbRepo;

  setUp(() {
    mockTmdbRepo = MockTmdbRepo();
  });

  group('fetchPopularMovies', () {
    test('should return PaginationResponse<Movie> on success', () async {
      // Arrange
      const request = FetchPopularMoviesRequest(page: 1);
      const tMovie = Movie(
        id: 1,
        title: 'Movie Title',
        smallPoster: '/path/to/poster.jpg',
        bigPoster: '/path/to/poster.jpg',
        rating: 9.1,
        originalTitle: 'Movie Original Title',
        releaseDate: '2021-01-01',
      );
      const tPaginationResponse = PaginationResponse(
        page: 1,
        totalPages: 10,
        totalResults: 100,
        results: [tMovie],
      );
      when(mockTmdbRepo.fetchPopularMovies(request))
          .thenAnswer((_) async => const Right(tPaginationResponse));

      // Act
      final result = await mockTmdbRepo.fetchPopularMovies(request);

      // Assert
      expect(result, const Right(tPaginationResponse));
    });

    test('should return MainFailure on error', () async {
      // Arrange
      const request = FetchPopularMoviesRequest(page: 1);
      when(mockTmdbRepo.fetchPopularMovies(request))
          .thenAnswer((_) async => const Left(Failure.unknown()));

      // Act
      final result = await mockTmdbRepo.fetchPopularMovies(request);

      // Assert
      expect(result, const Left(Failure.unknown()));
    });
  });

  group('fetchMovieDetails', () {
    test('should return MovieDetails on success', () async {
      // Arrange
      const request = FetchMovieDetailsRequest(id: 1);
      const tMovieDetails = MovieDetails(
        id: 1,
        title: 'Movie Title',
        posterPath: '/path/to/poster.jpg',
        overview: 'Movie Overview',
        originalLanguage: 'en',
        rating: 8.5,
        releaseDate: '2021-01-01',
        runtime: 120,
        genres: [],
      );
      when(mockTmdbRepo.fetchMovieDetails(request))
          .thenAnswer((_) async => const Right(tMovieDetails));

      // Act
      final result = await mockTmdbRepo.fetchMovieDetails(request);

      // Assert
      expect(result, const Right(tMovieDetails));
    });

    test('should return MainFailure on error', () async {
      // Arrange
      const request = FetchMovieDetailsRequest(id: 1);
      when(mockTmdbRepo.fetchMovieDetails(request))
          .thenAnswer((_) async => const Left(Failure.unknown()));

      // Act
      final result = await mockTmdbRepo.fetchMovieDetails(request);

      // Assert
      expect(result, const Left(Failure.unknown()));
    });
  });

  group('searchMovies', () {
    test('should return PaginationResponse<Movie> on success', () async {
      // Arrange
      const request = SearchMoviesRequest(query: 'movie', page: 1);
      const tMovie = Movie(
        id: 1,
        title: 'Movie Title',
        smallPoster: '/path/to/poster.jpg',
        bigPoster: '/path/to/poster.jpg',
        originalTitle: 'Movie Original Title',
        rating: 8.5,
        releaseDate: '2021-01-01',
      );
      const tPaginationResponse = PaginationResponse(
        page: 1,
        totalPages: 10,
        totalResults: 100,
        results: [tMovie],
      );
      when(mockTmdbRepo.searchMovies(request))
          .thenAnswer((_) async => const Right(tPaginationResponse));

      // Act
      final result = await mockTmdbRepo.searchMovies(request);

      // Assert
      expect(result, const Right(tPaginationResponse));
    });

    test('should return MainFailure on error', () async {
      // Arrange
      const request = SearchMoviesRequest(query: 'movie', page: 1);
      when(mockTmdbRepo.searchMovies(request))
          .thenAnswer((_) async => const Left(Failure.unknown()));

      // Act
      final result = await mockTmdbRepo.searchMovies(request);

      // Assert
      expect(result, const Left(Failure.unknown()));
    });
  });
}
