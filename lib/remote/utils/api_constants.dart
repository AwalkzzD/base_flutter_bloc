import 'package:base_flutter_bloc/env/environment.dart';

class ApiConstants {
  static String carDetailsBaseUrl = "https://vpic.nhtsa.dot.gov/api/vehicles";
  static String getPublicIpBaseUrl = "https://api.ipify.org";

  static int connectTimeout = 10000; //milli-seconds
  static int receiveTimeout = 10000; //milli-seconds
  static int writeTimeout = 10000; //milli-seconds

  static String getBaseUrl() {
    return "${Environment().config?.apiHost}";
  }
}
