class PagingDto {
  int totalItems;
  int totalPages;
  int pageNumber;
  int maxPerPage;

  PagingDto({
    required this.totalItems,
    required this.totalPages,
    required this.maxPerPage,
    required this.pageNumber
  });

  factory PagingDto.fromJson(Map<String, dynamic> json){
    return PagingDto(
      totalItems: json['totalItem'],
      totalPages: json['totalPage'],
      maxPerPage: json['maxPerPage'],
      pageNumber: json['pageNumber']);
  }
}