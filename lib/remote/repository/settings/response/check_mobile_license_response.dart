CheckMobileLicenseResponse checkMobileLicenseResponseFromRawResponse(
        String str) =>
    CheckMobileLicenseResponse.fromRawResponse(str);

class CheckMobileLicenseResponse {
  String? response;

  CheckMobileLicenseResponse({this.response});

  factory CheckMobileLicenseResponse.fromRawResponse(String response) =>
      CheckMobileLicenseResponse(response: response);
}
