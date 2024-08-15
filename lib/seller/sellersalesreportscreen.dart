import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/customcomponents/customappbar.dart';
// import 'package:sms/customcomponents/customeleveted_button.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/customeleveted_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SellerSalesReportScreen extends StatelessWidget {
  const SellerSalesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: "Sales Report"),
      body: SingleChildScrollView(
        child: Column(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total Sales",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                                color: Color(0xff000000)),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "1,227",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                                color: Color(0xff2E3192)),
                          ),
                        ],
                      ),
                      Divider(
                        color: Color(0xff949BAB).withOpacity(0.35),
                      ),
                      SizedBox(
                        height: 16.h,
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0,

                          // X and Y axes configurations
                          primaryXAxis: CategoryAxis(
                            labelStyle:
                                const TextStyle(color: Color(0xff838383)),
                          ),
                          primaryYAxis: NumericAxis(
                            labelStyle:
                                const TextStyle(color: Color(0xff838383)),
                            numberFormat: NumberFormat.compact(),
                          ),
                          // Tooltip configuration
                          tooltipBehavior: TooltipBehavior(enable: true),
                          // Series configuration
                          series: <ChartSeries>[
                            LineSeries<ChartData, String>(
                              dataSource: [
                                ChartData('Jan', 0),
                                ChartData('Feb', 100000),
                                ChartData('Mar', 50000),
                                ChartData('Apr', 10000),
                                ChartData('May', 15000),
                                ChartData('Jun', 400000),
                                ChartData('July', 100000),
                                ChartData('Aug', 200000),
                                ChartData('Sep', 50000),
                                ChartData('Oct', 40000),
                                ChartData('Nov', 70000),
                                ChartData('Dec', 19000),
                              ],
                              xValueMapper: (ChartData sales, _) => sales.month,
                              yValueMapper: (ChartData sales, _) => sales.sales,
                              name: 'Total Sales',
                              markerSettings:
                                  const MarkerSettings(isVisible: false),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                title: "60% Delivered",
                                color: Color(0xff2E3192)),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            customcolorrow(
                                title: "13% In process",
                                color: Color(0xff8286F6)),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            customcolorrow(
                                title: "13% Disputed",
                                color: Color(0xffFFC120)),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            customcolorrow(
                                title: "14% Cancelled",
                                color: Color(0xffFE3A30)),
                          ],
                        ),
                        Container(
                          height: 40.h,
                          width: 35.w,
                          child: SfCircularChart(
                            annotations: <CircularChartAnnotation>[],
                            series: <CircularSeries>[
                              DoughnutSeries<ChartData, String>(
                                dataSource: [
                                  ChartData('Jan', 1200000),
                                  ChartData('Feb', 300000),
                                  ChartData('Mar', 400000),
                                  ChartData('Apr', 100000),
                                ],
                                xValueMapper: (ChartData data, _) => data.month,
                                yValueMapper: (ChartData data, _) => data.sales,
                                pointColorMapper: (ChartData data, _) {
                                  switch (data.month) {
                                    case 'Jan':
                                      return Color(0xff2E3192);
                                    case 'Feb':
                                      return Color(0xff8286F6);
                                    case 'Mar':
                                      return Color(0xffFFC120);
                                    case 'Apr':
                                      return Color(0xffFE3A30);

                                    default:
                                      return Color(0xffFFC120);
                                  }
                                },
                                strokeColor: Colors.white,
                                strokeWidth: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  title: "60% Earnings",
                                  color: Color(0xff2E3192)),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              customcolorrow(
                                  title: "40% Refund",
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
                                  ChartData('Earnings', 500000),
                                  ChartData('Refund', 300000),
                                ],
                                xValueMapper: (ChartData data, _) => data.month,
                                yValueMapper: (ChartData data, _) => data.sales,
                                pointColorMapper: (ChartData data, _) {
                                  switch (data.month) {
                                    case 'Earnings':
                                      return Color(0xff2E3192);
                                    case 'Refund':
                                      return Color.fromARGB(255, 213, 127, 123)
                                          .withOpacity(0.6);

                                    default:
                                      return Color.fromARGB(255, 213, 127, 123)
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
                    color: Color(0xff101010)),
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: sellerrefundorderslist.length,
                itemBuilder: (context, index) {
                  final sellerordersdata = sellerrefundorderslist[index];
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 17, left: 17),
                        child: customproductcontainer(
                            orderid: sellerordersdata['orderid'],
                            productname: sellerordersdata['productname'],
                            productimage: sellerordersdata['image'],
                            status: sellerordersdata['orderstatus'],
                            viewdetailsontap: () {
                              Get.toNamed(RouteConstants
                                  .selleractiveorderdetailsscreen);
                            }),
                      ),
                      Divider()
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}

/////////seller dashboard today sales graph data
class ChartData {
  ChartData(this.month, this.sales);

  final String month;
  final double sales;
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

//////////seller sales report recent orders
List<Map<String, dynamic>> sellerrefundorderslist = [
  {
    "orderid": "Order #: 15s5d8e1",
    "image": "assets/images/orderhistoryproductimage1.png",
    "productname": 'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
    "orderstatus": 'Pending'
  },
  {
    "orderid": "Order #: 15s5d8e1",
    "image": "assets/images/orderhistoryproductimage2.png",
    "productname": 'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
    "orderstatus": 'Pending'
  },
  {
    "orderid": "Order #: 15s5d8e1",
    "image": "assets/images/orderhistoryproductimage3.png",
    "productname": 'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
    "orderstatus": 'Pending'
  },
  {
    "orderid": "Order #: 15s5d8e1",
    "image": "assets/images/orderhistoryproductimage1.png",
    "productname": 'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
    "orderstatus": 'Pending'
  },
];

///////seller productcontainer
Container customproductcontainer({
  required String orderid,
  required String productname,
  required String productimage,
  required String status,
  required VoidCallback viewdetailsontap,
}) {
  return Container(
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
                  child: Image.asset(
                    productimage,
                    height: 12.h,
                    width: 20.w,
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
                    SizedBox(
                      height: 4.2.h,
                      width: 48.w,
                      child: Text(
                        productname,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
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
