import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllNotifications extends StatelessWidget {
  const AllNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notificationdatalist.length,
                  itemBuilder: (context, index) {
                    final notificationsdata = notificationdatalist[index];
                    return Column(
                      children: [
                        ListTile(
                            leading: CircleAvatar(
                                radius: 19.sp,
                                backgroundImage: AssetImage(
                                    notificationsdata["profileimage"])),
                            title: Text(
                              notificationsdata["title"],
                              style: TextStyle(
                                  fontSize: 12.sp, color: Color(0xff777777)),
                            ),
                            subtitle: Text(
                              notificationsdata["subtitle"],
                              style: TextStyle(
                                  fontSize: 12.sp, color: Color(0xff777777)),
                            ),
                            trailing: Text(
                              notificationsdata["time"],
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Color(0xff000000).withOpacity(0.3)),
                            )),
                        const Divider()
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

//////notification data list
List<Map<String, dynamic>> notificationdatalist = [
  {
    "profileimage": "assets/images/notificationsuserprofileimage1.png",
    "title": "Congrats! You Have Won the Bid",
    "subtitle": "Check the product and buy it before the time goes out",
    "time": "9:35 am",
  },
  {
    "profileimage": "assets/images/notificationsuserprofileimage2.png",
    "title": "Congrats! You Have Won the Bid",
    "subtitle": "Check the product and buy it before the time goes out",
    "time": "9:35 am",
  },
];
///////notification image containers
Container imagecardnotificaions(
    {required String icon,
    required String title,
    required String time,
    required String backgorundimage}) {
  return Container(
    height: 20.h,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon,
                    height: 5.h,
                    width: 5.w,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff777777)),
                  ),
                ],
              ),
              Text(
                time,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000).withOpacity(0.3)),
              ),
            ],
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                backgorundimage,
                height: 15.h,
                fit: BoxFit.fill,
              ))
        ],
      ),
    ),
  );
}
