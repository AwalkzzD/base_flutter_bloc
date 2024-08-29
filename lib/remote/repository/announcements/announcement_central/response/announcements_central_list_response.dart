import 'dart:convert';

import 'detail/announcement_detail_response.dart';

List<AnnouncementDetailResponse> announcementCentralResponseFromJson(
        String str) =>
    List<AnnouncementDetailResponse>.from(
        json.decode(str).map((x) => AnnouncementDetailResponse.fromJson(x)));

String announcementCentralListResponseToJson(
        List<AnnouncementDetailResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
