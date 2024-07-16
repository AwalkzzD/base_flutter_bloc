class ApiConstants {
  static String baseUrl = "https://vpic.nhtsa.dot.gov/api/vehicles";

  static int connectTimeout = 5; //seconds
  static int receiveTimeout = 5; //seconds
  static int writeTimeout = 5; //seconds

  static String getBaseUrl() {
    return baseUrl;
  }
}
