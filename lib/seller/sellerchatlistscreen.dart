import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/controller/storecontroller.dart';
// import 'package:sms/customcomponents/customappbar.dart';
// import 'package:sms/customcomponents/customeprofileinfo.dart';

class SellerChatsListScreen extends StatefulWidget {
  @override
  _SellerChatsListScreenState createState() => _SellerChatsListScreenState();
}

class _SellerChatsListScreenState extends State<SellerChatsListScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: "Chats"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(18),
                child: SizedBox(
                  height: 4.h,
                  child: TextFormField(
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        'assets/images/homesearchicon.png',
                        color: Colors.black,
                        scale: 1.4,
                      ),
                      contentPadding: EdgeInsets.only(top: 10, right: 12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1375EA),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1375EA),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: Color(0xffF5F5F5),
                      hintText: "Search",
                      hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xff000000).withOpacity(0.6)),
                    ),
                    onSaved: (value) {},
                  ),
                )),
            Obx(() => ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: storecontroller.sellerchatslist.length,
                  itemBuilder: (context, index) {
                    final chatslistdata =
                        storecontroller.sellerchatslist[index];
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff2E3192),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.delete_outline_rounded,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        storecontroller.sellerchatslistremove(index);
                      },
                      confirmDismiss: (direction) async {
                        return true;
                      },
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteConstants.sellerchatscreen);
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 1),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          AssetImage(chatslistdata.imageUrl),
                                    ),
                                    title: Text(
                                      chatslistdata.userName,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff1B1B1B),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      chatslistdata.userDescription,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff757474)),
                                    ),
                                    trailing: Text(
                                      chatslistdata.time,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xffC8BCBC)),
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xffD9D9D9),
                                    thickness: 2,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}

class ChatsList {
  final String userName;
  final String userDescription;
  final String time;
  final String imageUrl;

  ChatsList({
    required this.userName,
    required this.userDescription,
    required this.time,
    required this.imageUrl,
  });
}
