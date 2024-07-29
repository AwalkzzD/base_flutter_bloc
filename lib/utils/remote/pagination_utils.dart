import 'dart:convert';

import 'package:base_flutter_bloc/utils/remote/pagination_data.dart';
import 'package:dio/dio.dart';

PaginationData getPaginationHeader(Response? response) {
  if (response != null) {
    List<String>? paginationHeaders = response.headers.map['x-pagination'];
    if (paginationHeaders != null && paginationHeaders.isNotEmpty) {
      Map<String, dynamic> jsonMap = json.decode(paginationHeaders.first);
      return PaginationData.fromJson(jsonMap);
    } else {
      // If header_widgets is not present or empty, return default values
      return PaginationData(
          currentPage: 0, totalPages: 0, pageSize: 0, totalCount: 0);
    }
  } else {
    return PaginationData(
        currentPage: 0, totalPages: 0, pageSize: 0, totalCount: 0);
  }
}
