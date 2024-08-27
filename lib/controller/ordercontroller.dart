
import 'package:get/get.dart';
import 'package:smsseller/models/sellersalesreportgraph_model.dart';
import 'package:smsseller/repositries/orderrepo.dart';

class OrderController extends GetxController {
  OrderRepo orderRepo;

  OrderController({required this.orderRepo});


//////////////get salesreport graph Data api
  final Rx<SellerSalesReportGraphModel?> getsellersalesreportgraph =
      Rx<SellerSalesReportGraphModel?>(null);
  final RxBool ggetsellersalesreportgraphloading = false.obs;

  getsellerSalesReportGraph() async {
    try {
      ggetsellersalesreportgraphloading(true);
      await orderRepo.getSellerSalesReportGraph().then((value) {
        getsellersalesreportgraph.value = value;
        ggetsellersalesreportgraphloading(false);
      });
    } catch (e) {
      ggetsellersalesreportgraphloading(false);
    }
  }
}
