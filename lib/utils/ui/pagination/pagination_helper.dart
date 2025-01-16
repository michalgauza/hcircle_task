import '../../../features/core/domain/entity/response/pagination_response.dart';
import 'pagination_state.dart';


abstract class PaginationHelper {
  Future<void> fetchNext();
}

mixin PaginationHelperMixin {
  int page = 1;
  int maxPage = 2;

  void updatePages(PaginationResponse response) {
    maxPage = response.totalPages;
    page++;
  }

  PaginationState get getPaginationState => maxPage < page
      ? const PaginationState.success()
      : const UpdateState.initial();
}