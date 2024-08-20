import 'package:get/get.dart';
import 'package:smsseller/repositries/authenication_repo.dart';
import 'package:smsseller/repositries/homeguest_repo.dart';
import 'package:smsseller/repositries/productrepo.dart';
import 'package:smsseller/repositries/storerepo.dart';
import 'package:smsseller/services/apiservices.dart';

Future<void> init() async {
  Get.lazyPut(() => HttpApiClient());
  Get.lazyPut(() => AuthRepo(apiClient: Get.find()));
  Get.lazyPut(() => HomeGuestRepo(apiClient: Get.find()));
  Get.lazyPut(() => StoreRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
}
