import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/ordercontroller.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/customeleveted_button.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SellerSalesReportScreen extends StatefulWidget {
  const SellerSalesReportScreen({super.key});

  @override
  State<SellerSalesReportScreen> createState() =>
      _SellerSalesReportScreenState();
}

class _SellerSalesReportScreenState extends State<SellerSalesReportScreen> {
  final ordercontroller = Get.put(OrderController(orderRepo: Get.find()));
  ScrollController scrollcontroller = ScrollController();
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
Future<void> refreshdata()async{
   ordercontroller.recentorderspage.value = 1;
   ordercontroller.getsellerSalesReportGraph();
    ordercontroller.getSalesReportOrderPercentage();
    ordercontroller.getSalesReportEarningRefund();
    ordercontroller.getRecentOrders();
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ordercontroller.recentorderspage.value = 1;
    ordercontroller.getsellerSalesReportGraph();
    ordercontroller.getSalesReportOrderPercentage();
    ordercontroller.getSalesReportEarningRefund();
    ordercontroller.getRecentOrders();
    scrollcontroller.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollcontroller.offset >= scrollcontroller.position.maxScrollExtent &&
        !scrollcontroller.position.outOfRange) {
      ordercontroller.getRecentOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: "Sales Report"),
      body: RefreshIndicator(
        onRefresh: refreshdata,
        child: SingleChildScrollView(
          controller: scrollcontroller,
          child:  Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  height: 24.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2.7, 3.09),
                          blurRadius: 5.79,
                          color: Color(0xff9EA4B4).withOpacity(0.25),
                        )
                      ],
                      borderRadius: BorderRadius.circular(1.54)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Obx(() => ordercontroller
                            .ggetsellersalesreportgraphloading.value
                        ? Center(
                            child: SizedBox(
                              height: 3.h,
                              width: 6.w,
                              child: customcircularprogress(),
                            ),
                          )
                        : ordercontroller.getsalesreportorderpercentage.value ==
                                null
                            ? Center(
                                child: nodatatext("No Orders Data"),
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Total Orders",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.sp,
                                              color: Color(0xff000000)),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          ordercontroller
                                                  .getsellersalesreportgraph
                                                  .value
                                                  ?.data
                                                  ?.totalOrders
                                                  .toString() ??
                                              "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17.sp,
                                              color: Color(0xff2E3192)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Divider(
                                      color: Color(0xff949BAB).withOpacity(0.35),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 16.h,
                                      child: Obx(() {
                                        List<ChartData> chartData = List.generate(
                                          months.length,
                                          (index) => ChartData(
                                            months[index],
                                            ordercontroller
                                                        .getsellersalesreportgraph
                                                        .value
                                                        ?.data
                                                        ?.ordersByMonthMobile?[
                                                    index] ??
                                                0,
                                          ),
                                        );
          
                                        return SfCartesianChart(
                                          plotAreaBorderWidth: 0,
          
                                          // X and Y axes configurations
                                          primaryXAxis: CategoryAxis(
                                            labelStyle: const TextStyle(
                                                color: Color(0xff838383)),
                                          ),
                                          primaryYAxis: NumericAxis(
                                            labelStyle: const TextStyle(
                                                color: Color(0xff838383)),
                                            numberFormat: NumberFormat.compact(),
                                          ),
                                          // Tooltip configuration
                                          tooltipBehavior:
                                              TooltipBehavior(enable: true),
                                          // Series configuration
                                          series: <ChartSeries>[
                                            LineSeries<ChartData, String>(
                                              dataSource: chartData,
                                              // [
                                              //   ChartData('Jan', 0),
                                              //   ChartData('Feb', 0),
                                              //   ChartData('Mar', 1),
                                              //   ChartData('Apr', 0),
                                              //   ChartData('May', 0),
                                              //   ChartData('Jun', 0),
                                              //   ChartData('July', 0),
                                              //   ChartData('Aug', 0),
                                              //   ChartData('Sep', 0),
                                              //   ChartData('Oct', 0),
                                              //   ChartData('Nov', 0),
                                              //   ChartData('Dec', 0),
                                              // ],
                                              xValueMapper:
                                                  (ChartData sales, _) =>
                                                      sales.month,
                                              yValueMapper:
                                                  (ChartData sales, _) =>
                                                      sales.sales,
                                              name: 'Total Sales',
                                              markerSettings:
                                                  const MarkerSettings(
                                                      isVisible: false),
                                            ),
                                          ],
                                        );
                                      }))
                                ],
                              )),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  height: 23.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2.7, 3.09),
                          blurRadius: 5.79,
                          color: Color(0xff9EA4B4).withOpacity(0.25),
                        )
                      ],
                      borderRadius: BorderRadius.circular(1.54)),
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 18, top: 15, bottom: 15),
                      child: Obx(() => ordercontroller
                              .getsalesreportorderpercentageloading.value
                          ? Center(
                              child: SizedBox(
                                height: 3.h,
                                width: 6.w,
                                child: customcircularprogress(),
                              ),
                            )
                          : ordercontroller.getsalesreportorderpercentage.value ==
                                  null
                              ? Center(
                                  child: nodatatext("No Order Status Data"),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order Status",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              color: Color(0xff4D4D4D)),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        customcolorrow(
                                            title:
                                                "${(ordercontroller.getsalesreportorderpercentage.value?.data?.pendingPercentage ?? 0).toStringAsFixed(2)}% Pending",
                                            color: Color(0xff2E3192)),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        customcolorrow(
                                            title:
                                                "${(ordercontroller.getsalesreportorderpercentage.value?.data?.acceptedPercentage ?? 0).toStringAsFixed(2)}% Active",
                                            color: Color(0xff8286F6)),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        customcolorrow(
                                            title:
                                                "${(ordercontroller.getsalesreportorderpercentage.value?.data?.completedPercentage ?? 0).toStringAsFixed(2)}% Completed",
                                            color: Color(0xffFFC120)),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        customcolorrow(
                                            title:
                                                "${(ordercontroller.getsalesreportorderpercentage.value?.data?.refundedPercentage ?? 0).toStringAsFixed(2)}% Refund",
                                            color: Color(0xffFE3A30)),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        customcolorrow(
                                            title:
                                                "${(ordercontroller.getsalesreportorderpercentage.value?.data?.rejectedPercentage ?? 0).toStringAsFixed(2)}% Rejected",
                                            color: Color(0xff71D177)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40.h,
                                      width: 35.w,
                                      child: SfCircularChart(
                                        annotations: <CircularChartAnnotation>[],
                                        series: <CircularSeries>[
                                          DoughnutSeries<ChartData, String>(
                                            dataSource: [
                                              ChartData(
                                                  'Pending',
                                                  ordercontroller
                                                          .getsalesreportorderpercentage
                                                          .value
                                                          ?.data
                                                          ?.pendingPercentage ??
                                                      0),
                                              ChartData(
                                                  'Active',
                                                  ordercontroller
                                                          .getsalesreportorderpercentage
                                                          .value
                                                          ?.data
                                                          ?.acceptedPercentage ??
                                                      0),
                                              ChartData(
                                                  'Completed',
                                                  ordercontroller
                                                          .getsalesreportorderpercentage
                                                          .value
                                                          ?.data
                                                          ?.completedPercentage ??
                                                      0),
                                              ChartData(
                                                  'Refund',
                                                  ordercontroller
                                                          .getsalesreportorderpercentage
                                                          .value
                                                          ?.data
                                                          ?.refundedPercentage ??
                                                      0),
                                              ChartData(
                                                  'Rejected',
                                                  ordercontroller
                                                          .getsalesreportorderpercentage
                                                          .value
                                                          ?.data
                                                          ?.rejectedPercentage ??
                                                      0),
                                            ],
                                            xValueMapper: (ChartData data, _) =>
                                                data.month,
                                            yValueMapper: (ChartData data, _) =>
                                                data.sales,
                                            pointColorMapper:
                                                (ChartData data, _) {
                                              switch (data.month) {
                                                case 'Pending':
                                                  return const Color(0xff2E3192);
                                                case 'Active':
                                                  return const Color(0xff8286F6);
                                                case 'Completed':
                                                  return const Color(0xffFFC120);
                                                case 'Refund':
                                                  return const Color(0xffFE3A30);
                                                case 'Rejected':
                                                  return const Color(0xff71D177);
          
                                                default:
                                                  return const Color(0xffFFC120);
                                              }
                                            },
                                            strokeColor: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ))),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  height: 20.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2.7, 3.09),
                          blurRadius: 5.79,
                          color: Color(0xff9EA4B4).withOpacity(0.25),
                        )
                      ],
                      borderRadius: BorderRadius.circular(1.54)),
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 18, top: 15, bottom: 15),
                      child: ordercontroller
                              .getsalesreportearningrefundloading.value
                          ? Center(
                              child: SizedBox(
                                height: 3.h,
                                width: 6.w,
                                child: customcircularprogress(),
                              ),
                            )
                          : ordercontroller.getsalesreportearningrefund.value ==
                                  null
                              ? Center(
                                  child: nodatatext("No Earning Refund Data"),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Earning and Refund",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp,
                                                color: Color(0xff4D4D4D)),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          customcolorrow(
                                              title:
                                                  "${(ordercontroller.getsalesreportearningrefund.value?.data?.earningPercentage ?? 0).toStringAsFixed(2)}% Earnings",
                                              color: Color(0xff2E3192)),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          customcolorrow(
                                              title:
                                                  "${(ordercontroller.getsalesreportearningrefund.value?.data?.refundPercentage ?? 0).toStringAsFixed(2)}% Refund",
                                              color: Color(0xffFE3A30)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40.h,
                                      width: 35.w,
                                      child: SfCircularChart(
                                        series: <CircularSeries>[
                                          PieSeries<ChartData, String>(
                                            dataSource: [
                                              ChartData(
                                                  'Earnings',
                                                  ordercontroller
                                                          .getsalesreportearningrefund
                                                          .value
                                                          ?.data
                                                          ?.earningPercentage ??
                                                      0),
                                              ChartData(
                                                  'Refund',
                                                  ordercontroller
                                                          .getsalesreportearningrefund
                                                          .value
                                                          ?.data
                                                          ?.refundPercentage ??
                                                      0),
                                            ],
                                            xValueMapper: (ChartData data, _) =>
                                                data.month,
                                            yValueMapper: (ChartData data, _) =>
                                                data.sales,
                                            pointColorMapper:
                                                (ChartData data, _) {
                                              switch (data.month) {
                                                case 'Earnings':
                                                  return Color(0xff2E3192);
                                                case 'Refund':
                                                  return Color.fromARGB(
                                                          255, 213, 127, 123)
                                                      .withOpacity(0.6);
          
                                                default:
                                                  return Color.fromARGB(
                                                          255, 213, 127, 123)
                                                      .withOpacity(0.6);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Recents Orders",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17.sp,
                      color: const Color(0xff101010)),
                ),
              ),
              Obx(() => ordercontroller.getrecentordersloading.value
                  ? Center(
                      child: customcircularprogress(),
                    )
                  : ordercontroller.getsalesreportrecentorders.value == null ||
                          ordercontroller.getsalesreportrecentorders.value!.data!
                              .orders!.isEmpty
                      ? Center(
                          child: nodatatext("No Recent Orders"),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ordercontroller.getsalesreportrecentorders
                              .value?.data?.orders?.length,
                          itemBuilder: (context, index) {
                            final recentordersdata = ordercontroller
                                .getsalesreportrecentorders
                                .value
                                ?.data
                                ?.orders?[index];
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 17, left: 17),
                                  child: customproductcontainer(
                                      orderid:
                                          "Order Id: ${recentordersdata?.orderid ?? ""}",
                                      productname: recentordersdata?.note ?? "",
                                      productimage: recentordersdata
                                                  ?.user
                                                  ?.media ==
                                              null
                                          ? AppConstants.noimage
                                          : recentordersdata
                                                  ?.user
                                                  ?.media
                                                  ?.first
                                                  .originalUrl ??
                                              AppConstants.noimage,
                                      status: recentordersdata?.orderStatus ?? "",
                                      viewdetailsontap: () {
                                  recentordersdata?.orderStatus == "Refunded" ? 
                                         ordercontroller.getRefundOrderDetailsById(
                                          recentordersdata?.id ?? 0) : 
                                        ordercontroller.getOrderDetailsbyId(
                                            recentordersdata?.id ?? 0,
                                            recentordersdata?.orderStatus ==
                                                    "Pending"
                                                ? 0
                                                : recentordersdata?.orderStatus ==
                                                        "Accepted"
                                                    ? 1
                                                    : recentordersdata
                                                                ?.orderStatus ==
                                                            "Rejected"
                                                        ? 2
                                                        : recentordersdata
                                                                    ?.orderStatus ==
                                                                "Completed"
                                                            ? 3
                                                            
                                                                : 0);
                                        recentordersdata?.orderStatus == "Pending"
                                            ? Get.toNamed(RouteConstants
                                                .sellerpendingdetailsscreen)
                                            : recentordersdata?.orderStatus ==
                                                    "Accepted"
                                                ? Get.toNamed(RouteConstants
                                                    .selleractiveorderdetailsscreen)
                                                : recentordersdata?.orderStatus ==
                                                        "Refunded"
                                                    ? Get.toNamed(RouteConstants
                                                        .sellerrefundorderdetailsscreen)
                                                    : Get.toNamed(RouteConstants
                                                        .sellerorderdetailsscreen);
                                      }),
                                ),
                                const Divider(),
                                 
                              ],
                            );
                          })),
                           ordercontroller.getrecentordersreloading.value
                                    ? Center(
                                        child: customcircularprogress(),
                                      )
                                    : const SizedBox()
                                    ,
                                    SizedBox(height: 4.h,)
            ],
          ),
         ) 
         
         ),
      ),
    );
  }
}

/////////seller dashboard today sales graph data
class ChartData {
  ChartData(this.month, this.sales);

  final String month;
  final dynamic sales;
}

////custom color row
Row customcolorrow({required String title, required Color color}) {
  return Row(
    children: [
      Container(
        height: 2.5.h,
        width: 5.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.14),
          color: color,
        ),
      ),
      SizedBox(
        width: 3.w,
      ),
      Text(
        title,
        style: TextStyle(
            // fontWeight: FontWeight.w500,
            fontSize: 15.sp,
            color: Color(0xff828D9E)),
      ),
    ],
  );
}

///////seller productcontainer
SizedBox customproductcontainer({
  required String orderid,
  required String productname,
  required String productimage,
  required String status,
  required VoidCallback viewdetailsontap,
}) {
  return SizedBox(
    height: 13.h,
    width: Get.width,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    productimage,
                    height: 10.h,
                    width: 20.w,
                    fit: BoxFit.fill,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderid,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 0.7.h,
                    ),
            productname.isEmpty ? const SizedBox() :        SizedBox(
                      height: 4.2.h,
                      width: 48.w,
                      child: Text(
                        productname,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    Text(
                      status,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff2E3192)),
                    ),
                  ],
                ),
              )
            ],
          ),
          CustomElevetedButton(
              ontap: viewdetailsontap,
              height: 3.h,
              width: 17.w,
              fontSize: 12.sp,
              borderradius: 9,
              color: Color(0xff2E3192),
              buttonName: 'View Details')
        ],
      ),
    ),
  );
}
