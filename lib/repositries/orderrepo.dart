
import 'package:get/get.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/models/sellersalesreportgraph_model.dart';
import 'package:smsseller/services/apiservices.dart';

class OrderRepo extends GetxService {
  HttpApiClient apiClient;
  OrderRepo({required this.apiClient});


////////get sales report graph data api
  Future<SellerSalesReportGraphModel?> getSellerSalesReportGraph() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getsalesreportgraph,
      );
      if (res.statusCode == 200) {
        final listofsellersalesgraph = sellerOrderGraphModelFromJson(res.body);
        return listofsellersalesgraph;
      } else {
        throw Exception("No data field found in the GetSellerSalesReportGraphData");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
