
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/models/acceptedorder_model.dart';
import 'package:smsseller/models/completedordersmodel.dart';
import 'package:smsseller/models/orderdetails_model.dart';
import 'package:smsseller/models/orderhistorycount_mode.dart';
import 'package:smsseller/models/pendingorder_model.dart';
import 'package:smsseller/models/recentorders_model.dart';
import 'package:smsseller/models/refundorderdetails_model.dart';
import 'package:smsseller/models/refundorders_model.dart';
import 'package:smsseller/models/rejectedorders_model.dart';
import 'package:smsseller/models/salesreportearningrefund_model.dart';
import 'package:smsseller/models/salesreportorderpercentage_model.dart';
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

////////get sales report order percentage
  Future<SalesReportOrderPercentage?> getSalesReportOrderPercentage() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getsalesreportorderpercentage,
      );
      if (res.statusCode == 200) {
        final listofsalesreportorderpercentage = salesReportOrderPercentageFromJson(res.body);
        return listofsalesreportorderpercentage;
      } else {
        throw Exception("No data field found in the GetSalesReportOrderPercentage");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

////////get sales report earning refund
  Future<SalesReportEarningRefundModel?> getSalesReportEarningRefund() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getsalesreportearningrefund,
      );
      if (res.statusCode == 200) {
        final listofsalesreportearningrefund = salesReportEarningRefundFromJson(res.body);
        return listofsalesreportearningrefund;
      } else {
        throw Exception("No data field found in the GetSalesReportEarningRefund");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

////////get sales reportrecent orders
  Future<RecentOrdersModel?> getSalesReportRecentOrders(int page) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getsalesreportrecentorders}?page=$page",
      );
      if (res.statusCode == 200) {
        final listofrecentorders = recentOrdersModelFromJson(res.body);
        return listofrecentorders;
      } else {
        throw Exception("No data field found in the GetSalesReportRecentOrders");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ////////get orderdetails by id
  Future<OrderDetailsModel?> getOrderDetailsById(int id,int status) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getorderdetailsbyid}$id?status=1&order_status=$status",
      );
      if (res.statusCode == 200) {
        final listoforderdetails = orderDetailsModelFromJson(res.body);
        return listoforderdetails;
      } else {
        throw Exception("No data field found in the GetOrderDetailsById");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ////////get orderhistory count
  Future<OrderHistoryCountsModel?> getOrderHistoryCount() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getorderhistorycount,
      );
      if (res.statusCode == 200) {
        final listofordercount = orderHistoryCountsFromJson(res.body);
        return listofordercount;
      } else {
        throw Exception("No data field found in the GetOrderHistoryCount");
      }
    } catch (e) {
      throw Exception(e);
    }
  }


  //////update Order Status
  Future updateOrderStatus({
    required String id,
    required String status,
  }) async {
    final mapData = {
      "status": status,
    };

    print(mapData);
    try {
      final res = await apiClient.postToServer(
          endPoint: "${AppConstants.updateorderstatus}$id", data: mapData);
      if (res.statusCode == 200) {
        Get.offAllNamed(RouteConstants.sellerdashboard);
        final message = jsonDecode(res.body)['message'];
        showSuccessSnackbar(message: message);
      } else {
        final message = jsonDecode(res.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } on SocketException {
      return showErrrorSnackbar(message: 'No Internet Connection');
    } catch (e) {
      showErrrorSnackbar(message: e.toString());
    }
  }


    ////////get pending orders
  Future<PendingOrdersModel?> getPendingOrders(int page) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getpendingorders}?page=$page",
      );
      if (res.statusCode == 200) {
        final listofpendingorders = pendingOrdersModelFromJson(res.body);
        return listofpendingorders;
      } else {
        throw Exception("No data field found in the GetPendingOrders");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
 ////////get active orders
  Future<ActiveOrdersModel?> getActiveOrders(int page) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getactiveorders}?page=$page",
      );
      if (res.statusCode == 200) {
        final listofactiveorders = activeOrdersModelFromJson(res.body);
        return listofactiveorders;
      } else {
        throw Exception("No data field found in the GetActiveOrders");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

   ////////get completed orders
  Future<CompletedOrdersModel?> getCompletedOrders(int page) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getcompletedorders}?page=$page",
      );
      if (res.statusCode == 200) {
        final listofcompletedorders = completedOrdersModelFromJson(res.body);
        return listofcompletedorders;
      } else {
        throw Exception("No data field found in the GetCompletedOrders");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ////////get refunded orders
  Future<RefundedOrdersModel?> getRefundedOrders(int page) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getrefundedorders}?page=$page",
      );
      if (res.statusCode == 200) {
        final listofrefundedorders = refundedOrdersModelFromJson(res.body);
        return listofrefundedorders;
      } else {
        throw Exception("No data field found in the GetRefundedOrders");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

    ////////get rejected orders
  Future<RejectedOrdersModel?> getRejectedOrders(int page) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getrejectedorders}?page=$page",
      );
      if (res.statusCode == 200) {
        final listofrejectedorders = rejectedOrdersModelFromJson(res.body);
        return listofrejectedorders;
      } else {
        throw Exception("No data field found in the GetRejectedOrders");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

    ////////get refund orderdetails by id
  Future<RefundOrderDetailsModel?> getRefundOrderDetailsById(int id) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getrefundorderdetailsbyid}$id?status=1&order_status=4",
      );
      if (res.statusCode == 200) {
        final listofrefundorderdetails = refundOrderDetailsFromJson(res.body);
        return listofrefundorderdetails;
      } else {
        throw Exception("No data field found in the GetRefundOrderDetailsById");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //////update refund Order Status
  Future updateRefundOrderStatus({
    required String id,
    required String status,
  }) async {
    final mapData = {
     "id":id,
    "status":status.toString()
    };

    print(mapData);
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.updaterefundorderstatus, data: mapData);
      if (res.statusCode == 200) {
        Get.offAllNamed(RouteConstants.sellerdashboard);
        final message = jsonDecode(res.body)['message'];
        showSuccessSnackbar(message: message);
      } else {
        final message = jsonDecode(res.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } on SocketException {
      return showErrrorSnackbar(message: 'No Internet Connection');
    } catch (e) {
       showErrrorSnackbar(
        message: 'An unexpected error occurred. Please try again later.',
      );
    }
  }
}
