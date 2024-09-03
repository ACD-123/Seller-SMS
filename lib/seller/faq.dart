import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storecontroller.getFaq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "FAQs",
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(
              () => storecontroller.getsellerfaqloading.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 35.h),
                      child: Center(
                        child: customcircularprogress(),
                      ),
                    )
                  : storecontroller.getsellerfaq.value == null ||
                          storecontroller.getsellerfaq.value!.data!.isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 35.h),
                          child: Center(
                            child: nodatatext("No FAQ"),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: storecontroller
                                    .getsellerfaq.value?.data?.length,
                                itemBuilder: (context, index) {
                                  final faqdata = storecontroller
                                      .getsellerfaq.value?.data?[index];
                                  return ExpansionTile(
                                    title: Text(
                                      faqdata?.question.toString() ?? '',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: const Color(0xff474747),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 1.h,
                                            bottom: 1.h,
                                            left: 3.w,
                                            right: 1.w),
                                        child: Text(
                                          faqdata?.answer.toString() ?? '',
                                          style: TextStyle(
                                            color: const Color(0xff8D8D8D),
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                          ],
                        ),
            )),
      ),
    );
  }
}
