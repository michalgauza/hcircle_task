import '../../../features/core/domain/entity/response/pagination_response.dart';
import 'pagination_state.dart';

abstract class PaginationHelper {
  Future<void> fetchNext();
  Future<void> retryFetch();
}

mixin PaginationHelperMixin {
  int _page = 1;

  int get page => _page;
  int _totalPages = 2;

  int get totalPages => _totalPages;

  void updatePages<T>(PaginationResponse<T> response) {
    _totalPages = response.totalPages;
    _page++;
  }

  PaginationState get getPaginationState => _totalPages < _page
      ? const PaginationState.end()
      : const PaginationState.idle();
}
