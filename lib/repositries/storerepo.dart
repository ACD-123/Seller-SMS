import 'package:get/get.dart';
// import 'package:sms/services/apiservices.dart';
import 'package:smsseller/services/apiservices.dart';

class StoreRepo extends GetxService {
  HttpApiClient apiClient;
  StoreRepo({required this.apiClient});
}
