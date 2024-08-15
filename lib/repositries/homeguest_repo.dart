import 'package:get/get.dart';
// import 'package:sms/services/apiservices.dart';
import 'package:smsseller/services/apiservices.dart';

class HomeGuestRepo extends GetxService {
  HttpApiClient apiClient;
  HomeGuestRepo({required this.apiClient});
}
