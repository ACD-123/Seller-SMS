import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrdersNotifications extends StatelessWidget {
  const OrdersNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 18),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
                SizedBox(height: 0.5.h,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context,index){
            
                    final ordersnotificationsdata = ordersnotificationdatalist[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 19.sp,
                            backgroundImage: AssetImage(ordersnotificationsdata["profileimage"])),
                        title: Text(
                          ordersnotificationsdata["title"],
                          style: TextStyle(fontSize: 12.sp,color: Color(0xff777777)),
                        ),
                        subtitle: Text(
                          ordersnotificationsdata["subtitle"],
                          style: TextStyle(fontSize: 12.sp,color: Color(0xff777777)),
                        ),
                        trailing: Text(ordersnotificationsdata["time"],style: TextStyle(fontSize: 13.sp,color: Color(0xff000000).withOpacity(0.3)),)),
                    
                    Divider()
                    ],
                  );
                }),
               
              
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context,index){
            
                    final ordersnotificationsdata = ordersnotificationdatalist[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 19.sp,
                            backgroundImage: AssetImage(ordersnotificationsdata["profileimage"])),
                        title: Text(
                          ordersnotificationsdata["title"],
                          style: TextStyle(fontSize: 12.sp,color: Color(0xff777777)),
                        ),
                        subtitle: Text(
                          ordersnotificationsdata["subtitle"],
                          style: TextStyle(fontSize: 12.sp,color: Color(0xff777777)),
                        ),
                        trailing: Text(ordersnotificationsdata["time"],style: TextStyle(fontSize: 13.sp,color: Color(0xff000000).withOpacity(0.3)),)),
                    
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



//////orders notification data list 
List<Map<String,dynamic>> ordersnotificationdatalist = [
  {
    "profileimage" : "assets/images/notificationsuserprofileimage1.png",
    "title" : "Congrats! You Have Won the Bid",
    "subtitle" : "Check the product and buy it before the time goes out",
    "time" : "9:35 am",
  },
   {
    "profileimage" : "assets/images/notificationsuserprofileimage2.png",
    "title" : "Congrats! You Have Won the Bid",
    "subtitle" : "Check the product and buy it before the time goes out",
    "time" : "9:35 am",
  }, {
    "profileimage" : "assets/images/notificationsuserprofileimage1.png",
    "title" : "Congrats! You Have Won the Bid",
    "subtitle" : "Check the product and buy it before the time goes out",
    "time" : "9:35 am",
  },
   {
    "profileimage" : "assets/images/notificationsuserprofileimage2.png",
    "title" : "Congrats! You Have Won the Bid",
    "subtitle" : "Check the product and buy it before the time goes out",
    "time" : "9:35 am",
  }, 
];