class PaginationData {
  int currentPage;
  int totalPages;
  int pageSize;
  int totalCount;

  PaginationData({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      currentPage: json['currentPage'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      totalCount: json['totalCount'] ?? 0,
    );
  }

  bool isLastPage(){
    return currentPage==totalPages || totalPages==0;
  }
}