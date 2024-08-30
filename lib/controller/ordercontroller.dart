import 'package:get/get.dart';
import 'package:smsseller/models/acceptedorder_model.dart';
import 'package:smsseller/models/completedordersmodel.dart';
import 'package:smsseller/models/orderdetails_model.dart';
import 'package:smsseller/models/orderhistorycount_mode.dart';
import 'package:smsseller/models/pendingorder_model.dart';
import 'package:smsseller/models/recentorders_model.dart';
import 'package:smsseller/models/refundorders_model.dart';
import 'package:smsseller/models/rejectedorders_model.dart';
import 'package:smsseller/models/salesreportearningrefund_model.dart';
import 'package:smsseller/models/salesreportorderpercentage_model.dart';
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

//////////////get salesreport orderpercentage
  final Rx<SalesReportOrderPercentage?> getsalesreportorderpercentage =
      Rx<SalesReportOrderPercentage?>(null);
  final RxBool getsalesreportorderpercentageloading = false.obs;

  getSalesReportOrderPercentage() async {
    try {
      getsalesreportorderpercentageloading(true);
      await orderRepo.getSalesReportOrderPercentage().then((value) {
        getsalesreportorderpercentage.value = value;
        getsalesreportorderpercentageloading(false);
      });
    } catch (e) {
      getsalesreportorderpercentageloading(false);
    }
  }

  //////////////get salesreport earning refund
  final Rx<SalesReportEarningRefundModel?> getsalesreportearningrefund =
      Rx<SalesReportEarningRefundModel?>(null);
  final RxBool getsalesreportearningrefundloading = false.obs;

  getSalesReportEarningRefund() async {
    try {
      getsalesreportearningrefundloading(true);
      await orderRepo.getSalesReportEarningRefund().then((value) {
        getsalesreportearningrefund.value = value;
        getsalesreportearningrefundloading(false);
      });
    } catch (e) {
      getsalesreportearningrefundloading(false);
    }
  }

  //////////////get sales report recent orders
  final Rx<RecentOrdersModel?> getsalesreportrecentorders =
      Rx<RecentOrdersModel?>(null);
  final RxBool getrecentordersloading = false.obs;
  final RxBool getrecentordersreloading = false.obs;
  final RxInt recentorderspage = 1.obs;
  Future<void> getRecentOrders() async {
    if (getrecentordersreloading.value || getrecentordersloading.value) return;
    if (recentorderspage.value > 1 &&
        recentorderspage.value >
            (getsalesreportrecentorders.value?.data?.pagination?.totalPages ??
                0)) {
      return;
    }

    try {
      recentorderspage.value > 1
          ? getrecentordersreloading.value = true
          : getrecentordersloading.value = true;
      final value =
          await orderRepo.getSalesReportRecentOrders(recentorderspage.value);
      if (recentorderspage.value > 1) {
        getsalesreportrecentorders.value?.data?.orders
            ?.addAll(value?.data?.orders ?? []);
      } else {
        getsalesreportrecentorders.value = value;
      }
      recentorderspage.value++;
      getrecentordersreloading.value = false;
      getrecentordersloading.value = false;
    } catch (e) {
      getrecentordersreloading.value = false;
      getrecentordersloading.value = false;
    }
  }

  //////////////get order details by id
  final Rx<OrderDetailsModel?> getorderdetailsbyid =
      Rx<OrderDetailsModel?>(null);
  final RxBool getorderdetailsbyidloading = false.obs;

  getOrderDetailsbyId(int id, int status) async {
    try {
      getorderdetailsbyidloading(true);
      await orderRepo.getOrderDetailsById(id, status).then((value) {
        getorderdetailsbyid.value = value;
        getorderdetailsbyidloading(false);
      });
    } catch (e) {
      getorderdetailsbyidloading(false);
    }
  }

  //////////////get order history count
  final Rx<OrderHistoryCountsModel?> getorderhistorycount =
      Rx<OrderHistoryCountsModel?>(null);
  final RxBool getorderhistorycountloading = false.obs;

  getOrderHistoryCount() async {
    try {
      getorderhistorycountloading(true);
      await orderRepo.getOrderHistoryCount().then((value) {
        getorderhistorycount.value = value;
        getorderhistorycountloading(false);
      });
    } catch (e) {
      getorderhistorycountloading(false);
    }
  }

  ////////order status update
  RxBool updateorderstatusloading = false.obs;
  Future<void> updateOrderStatus({required int id, required String status}) async {
    try {
      updateorderstatusloading.value = true;
      await orderRepo.updateOrderStatus(
          id: id.toString(), status: status.toString());

      updateorderstatusloading.value = false;
    } finally {
      updateorderstatusloading.value = false;
    }
  }

  ////////////////seller order history container selection logic
  RxInt issellerselectedOrdercount = 1.obs;

  void setsellerSelectedOrdercount(int orderIndex) {
    issellerselectedOrdercount.value = orderIndex;
  }

  //////////////get pending orders 
     final Rx<PendingOrdersModel?> getpendingorders =
      Rx<PendingOrdersModel?>(null);
  final RxBool getpendingordersloading = false.obs;
final RxBool getpendingordersreloading = false.obs;
  final RxInt pendingorderspage = 1.obs;
  Future<void> getPendingOrders() async {
    if (getpendingordersreloading.value || getpendingordersloading.value) return;
    if (pendingorderspage.value > 1 &&
        pendingorderspage.value >
            (getpendingorders.value?.data?.pagination?.totalPages ??
                0)) {
      return;
    }

    try {
      pendingorderspage.value > 1
          ? getpendingordersreloading.value = true
          : getpendingordersloading.value = true;
      final value =
          await orderRepo.getPendingOrders(pendingorderspage.value);
      if (pendingorderspage.value > 1) {
        getpendingorders.value?.data?.orders
            ?.addAll(value?.data?.orders ?? []);
      } else {
        getpendingorders.value = value;
      }
      pendingorderspage.value++;
      getpendingordersreloading.value = false;
      getpendingordersloading.value = false;
    } catch (e) {
      getpendingordersreloading.value = false;
      getpendingordersloading.value = false;
    }
  }
  //////////////get active orders
     final Rx<ActiveOrdersModel?> getactiveorders =
      Rx<ActiveOrdersModel?>(null);
  final RxBool getactiveordersloading = false.obs;
final RxBool getactiveordersreloading = false.obs;
  final RxInt activeorderspage = 1.obs;
  Future<void> getActiveOrders() async {
    if (getactiveordersreloading.value || getactiveordersloading.value) return;
    if (activeorderspage.value > 1 &&
        activeorderspage.value >
            (getactiveorders.value?.data?.pagination?.totalPages ??
                0)) {
      return;
    }

    try {
      activeorderspage.value > 1
          ? getactiveordersreloading.value = true
          : getactiveordersloading.value = true;
      final value =
          await orderRepo.getActiveOrders(activeorderspage.value);
      if (activeorderspage.value > 1) {
        getactiveorders.value?.data?.orders
            ?.addAll(value?.data?.orders ?? []);
      } else {
        getactiveorders.value = value;
      }
      activeorderspage.value++;
      getactiveordersreloading.value = false;
      getactiveordersloading.value = false;
    } catch (e) {
      getactiveordersreloading.value = false;
      getactiveordersloading.value = false;
    }
  }

//////////////get completed orders
     final Rx<CompletedOrdersModel?> getcompletedorders =
      Rx<CompletedOrdersModel?>(null);
  final RxBool getcompletedordersloading = false.obs;
 final RxBool getcompletedordersreloading = false.obs;
  final RxInt completedorderspage = 1.obs;
  Future<void> getCompletedOrders() async {
    if (getcompletedordersreloading.value || getcompletedordersloading.value) return;
    if (completedorderspage.value > 1 &&
        completedorderspage.value >
            (getcompletedorders.value?.data?.pagination?.totalPages ??
                0)) {
      return;
    }

    try {
      completedorderspage.value > 1
          ? getcompletedordersreloading.value = true
          : getcompletedordersloading.value = true;
      final value =
          await orderRepo.getCompletedOrders(completedorderspage.value);
      if (completedorderspage.value > 1) {
        getcompletedorders.value?.data?.orders
            ?.addAll(value?.data?.orders ?? []);
      } else {
        getcompletedorders.value = value;
      }
      completedorderspage.value++;
      getcompletedordersreloading.value = false;
      getcompletedordersloading.value = false;
    } catch (e) {
      getcompletedordersreloading.value = false;
      getcompletedordersloading.value = false;
    }
  }

 //////////////get refunded orders
     final Rx<RefundedOrdersModel?> getrefundedorders =
      Rx<RefundedOrdersModel?>(null);
  final RxBool getrefundedordersloading = false.obs;
 final RxBool getrefundedordersreloading = false.obs;
  final RxInt refundedorderspage = 1.obs;
  Future<void> getRefundedOrders() async {
    if (getrefundedordersreloading.value || getrefundedordersloading.value) return;
    if (refundedorderspage.value > 1 &&
        refundedorderspage.value >
            (getrefundedorders.value?.data?.pagination?.totalPages ??
                0)) {
      return;
    }

    try {
      refundedorderspage.value > 1
          ? getrefundedordersreloading.value = true
          : getrefundedordersloading.value = true;
      final value =
          await orderRepo.getRefundedOrders(refundedorderspage.value);
      if (refundedorderspage.value > 1) {
        getrefundedorders.value?.data?.orders
            ?.addAll(value?.data?.orders ?? []);
      } else {
        getrefundedorders.value = value;
      }
      refundedorderspage.value++;
      getrefundedordersreloading.value = false;
      getrefundedordersloading.value = false;
    } catch (e) {
      getrefundedordersreloading.value = false;
      getrefundedordersloading.value = false;
    }
  }

   //////////////get rejected orders
     final Rx<RejectedOrdersModel?> getrejectedorders = Rx<RejectedOrdersModel?>(null);
  final RxBool getrejectedordersloading = false.obs;
final RxBool getrejectedordersreloading = false.obs;
  final RxInt rejectedorderspage = 1.obs;
  Future<void> getRejectedOrders() async {
    if (getrejectedordersreloading.value || getrejectedordersloading.value) return;
    if (rejectedorderspage.value > 1 &&
        rejectedorderspage.value >
            (getrejectedorders.value?.data?.pagination?.totalPages ??
                0)) {
      return;
    }

    try {
      rejectedorderspage.value > 1
          ? getrejectedordersreloading.value = true
          : getrejectedordersloading.value = true;
      final value =
          await orderRepo.getRejectedOrders(rejectedorderspage.value);
      if (rejectedorderspage.value > 1) {
        getrejectedorders.value?.data?.orders
            ?.addAll(value?.data?.orders ?? []);
      } else {
        getrejectedorders.value = value;
      }
      rejectedorderspage.value++;
      getrejectedordersreloading.value = false;
      getrejectedordersloading.value = false;
    } catch (e) {
      getrejectedordersreloading.value = false;
      getrejectedordersloading.value = false;
    }
  }

}
