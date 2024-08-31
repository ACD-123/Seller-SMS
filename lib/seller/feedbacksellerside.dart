import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class SellerFeedback extends StatefulWidget {
  const SellerFeedback({super.key});

  @override
  State<SellerFeedback> createState() => _SellerFeedbackState();
}

class _SellerFeedbackState extends State<SellerFeedback> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  ScrollController scrollcontroller = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void fetchFeedbackAndInitialize() async {
    await storecontroller.getSellerShopFeedback();
    // storecontroller.iseditreplylist();
    storecontroller.reasonfeedbackcontroller();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storecontroller.sellershopfeedbackspage.value = 1;
    fetchFeedbackAndInitialize();
    scrollcontroller.addListener(() {
      if (scrollcontroller.offset >=
              scrollcontroller.position.maxScrollExtent &&
          !scrollcontroller.position.outOfRange) {
        storecontroller.getSellerShopFeedback();
         storecontroller.reasonfeedbackcontroller();
      }
    });
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller:   scrollcontroller,
        child: Obx(
      () => storecontroller.getsellersideshopfeedbackloading.value
          ? Padding(
              padding: EdgeInsets.only(top: 18.h),
              child: Center(
                child: customcircularprogress(),
              ),
            )
          : storecontroller.getsellersideshoppfeedback.value == null
              ? Padding(
                  padding: EdgeInsets.only(top: 18.h),
                  child: Center(
                    child: nodatatext("No Feedback Data"),
                  ),
                )
              : Form(
                  key: formKey,
                  child: Column(
                    
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Customer Feedback Stats',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 10.0),
                        //   child: Row(
                        //     children: [
                        //       Text('Last 12 months',
                        //           style: TextStyle(
                        //             fontSize: 14,
                        //           )),
                        //     ],
                        //   ),
                        // ),
                        feedbackreview(
                            context: context,
                            tittle: 'Five Star',
                            counts: storecontroller.getsellersideshoppfeedback
                                    .value?.data?.sellerdata?.fivestar
                                    .toString() ??
                                "",
                            review: 1),
                        feedbackreview(
                            context: context,
                            tittle: 'Four Star',
                            counts: storecontroller.getsellersideshoppfeedback
                                    .value?.data?.sellerdata?.fourstar
                                    .toString() ??
                                "",
                            review: 0.8),
                        feedbackreview(
                            context: context,
                            tittle: 'Three Star',
                            counts: storecontroller.getsellersideshoppfeedback
                                    .value?.data?.sellerdata?.threestar
                                    .toString() ??
                                "",
                            review: 0.6),
                        feedbackreview(
                            context: context,
                            tittle: 'Two Star',
                            counts: storecontroller.getsellersideshoppfeedback
                                    .value?.data?.sellerdata?.twostar
                                    .toString() ??
                                "",
                            review: 0.3),
                        feedbackreview(
                            context: context,
                            tittle: 'One Star',
                            counts: storecontroller.getsellersideshoppfeedback
                                    .value?.data?.sellerdata?.onestar
                                    .toString() ??
                                "",
                            review: 0.1),

                        storecontroller.getsellersideshoppfeedback.value?.data
                                    ?.feedback?.isEmpty ??
                                false
                            ? Center(
                                child: nodatatext("No Feedbacks"),
                              )
                            : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: storecontroller
                                    .getsellersideshoppfeedback
                                    .value
                                    ?.data
                                    ?.feedback
                                    ?.length,
                                itemBuilder: (context, index) {
                                  final sellerfeedback = storecontroller
                                      .getsellersideshoppfeedback
                                      .value
                                      ?.data
                                      ?.feedback?[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Column(
                                      children: [
                                        Card(
                                          color: Colors.white,
                                          child: SizedBox(
                                            child: Padding(
                                              padding: EdgeInsets.all(1.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage: NetworkImage(
                                                            sellerfeedback
                                                                        ?.user
                                                                        ?.media
                                                                        ?.isEmpty ??
                                                                    false
                                                                ? AppConstants
                                                                    .noimage
                                                                : sellerfeedback
                                                                        ?.user
                                                                        ?.media
                                                                        ?.first
                                                                        .originalUrl ??
                                                                    AppConstants
                                                                        .noimage),
                                                        radius: 20.sp,
                                                      ),
                                                      SizedBox(
                                                        width: 1.w,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: 17.w,
                                                                child: Text(
                                                                  sellerfeedback
                                                                          ?.user
                                                                          ?.name ??
                                                                      "",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.sp),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                               SizedBox(
                                                                width: 19.w,
                                                                child: Text(
                                                                  "> ${
                                                                    sellerfeedback
                                                                          ?.product
                                                                          ?.name ??
                                                                      ""
                                                                  }",
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                      fontSize:
                                                                          15.sp),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.1,
                                                              ),
                                                              Text(
                                                                sellerfeedback
                                                                        ?.date ??
                                                                    "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.sp),
                                                              )
                                                            ],
                                                          ),
                                                          RatingBarIndicator(
                                                            rating: sellerfeedback
                                                                    ?.ratingAsDouble ??
                                                                0.0,
                                                            itemBuilder:
                                                                (context,
                                                                        index) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color: Color(
                                                                  0xffFFAD33),
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 16.sp,
                                                            direction:
                                                                Axis.horizontal,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text(
                                                    sellerfeedback?.comment ??
                                                        "",
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                  ),
                                                  const Divider(),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  // sellerfeedback
                                                  //             ?.sellerComment !=
                                                  //         null
                                                  //     ? GestureDetector(
                                                  //         onTap: () {
                                                  //           storecontroller.iseditreplyfeedbacktrue(index);
                                                  //         },
                                                  //         child: Align(
                                                  //           alignment: Alignment
                                                  //               .bottomRight,
                                                  //           child: Text("Edit",
                                                  //               style:
                                                  //                   TextStyle(
                                                  //                 fontSize:
                                                  //                     14.sp,
                                                  //                 fontWeight:
                                                  //                     FontWeight
                                                  //                         .bold,
                                                  //               )),
                                                  //         ),
                                                  //       )
                                                  //     : const SizedBox(),
                                                  sellerfeedback
                                                              ?.sellerComment ==
                                                          null
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5),
                                                          child: TextFormField(
                                                            controller:
                                                                storecontroller
                                                                        .replyfeedbackControllers[
                                                                    index],
                                                            style: TextStyle(
                                                              fontSize: 15.sp,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              fillColor:
                                                                  const Color(
                                                                      0XFFFFFFFF),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFDBDBDB),
                                                                    width: 2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xFFDBDBDB),
                                                                    width: 2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      15.0),
                                                              suffixIcon:
                                                                  InkWell(
                                                                onTap: () {
                                                                  if (storecontroller
                                                                          .replyfeedbackControllers[
                                                                              index]
                                                                          ?.value
                                                                          .text
                                                                          .isNotEmpty ??
                                                                      false) {
                                                                    storecontroller.replySellerFeeback(
                                                                        id: sellerfeedback?.id ??
                                                                            0,
                                                                        reply: storecontroller.replyfeedbackControllers[index]?.value.text.toString() ??
                                                                            "");
                                                                  } else {
                                                                    showErrrorSnackbar(
                                                                        message:
                                                                            "Please Enter Your Comment");
                                                                  }
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/chatmessagefieldicon.png',
                                                                  scale: 1.6,
                                                                ),
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              hintText:
                                                                  'Reply.....',
                                                              hintStyle: TextStyle(
                                                                  color: Color(
                                                                          0xFF404040)
                                                                      .withOpacity(
                                                                          0.5)),
                                                            ),
                                                          ),
                                                        ):
                                                      // : storecontroller
                                                      //             .iseditreplyfeedback[
                                                      //                 index]
                                                      //             ?.value ==
                                                      //         true
                                                      //     ? Padding(
                                                      //         padding:
                                                      //             const EdgeInsets
                                                      //                 .symmetric(
                                                      //                 vertical:
                                                      //                     5),
                                                      //         child:
                                                      //             TextFormField(
                                                      //           controller:
                                                      //               storecontroller
                                                      //                       .replyfeedbackControllers[
                                                      //                   index],
                                                      //           style:
                                                      //               TextStyle(
                                                      //             fontSize:
                                                      //                 15.sp,
                                                      //             color: Colors
                                                      //                 .black,
                                                      //           ),
                                                      //           decoration:
                                                      //               InputDecoration(
                                                      //             fillColor:
                                                      //                 const Color(
                                                      //                     0XFFFFFFFF),
                                                      //             enabledBorder:
                                                      //                 OutlineInputBorder(
                                                      //               borderSide: const BorderSide(
                                                      //                   color: Color(
                                                      //                       0xFFDBDBDB),
                                                      //                   width:
                                                      //                       2),
                                                      //               borderRadius:
                                                      //                   BorderRadius.circular(
                                                      //                       10),
                                                      //             ),
                                                      //             focusedBorder:
                                                      //                 OutlineInputBorder(
                                                      //               borderSide: const BorderSide(
                                                      //                   color: Color(
                                                      //                       0xFFDBDBDB),
                                                      //                   width:
                                                      //                       2),
                                                      //               borderRadius:
                                                      //                   BorderRadius.circular(
                                                      //                       10),
                                                      //             ),
                                                      //             contentPadding:
                                                      //                 const EdgeInsets
                                                      //                     .all(
                                                      //                     15.0),
                                                      //             suffixIcon:
                                                      //                 InkWell(
                                                      //               onTap: () {
                                                      //                 if (storecontroller
                                                      //                         .replyfeedbackControllers[index]
                                                      //                         ?.value
                                                      //                         .text
                                                      //                         .isNotEmpty ??
                                                      //                     false) {
                                                      //                   storecontroller.replySellerFeeback(
                                                      //                       id: sellerfeedback?.id ??
                                                      //                           0,
                                                      //                       reply:
                                                      //                           storecontroller.replyfeedbackControllers[index]?.value.text.toString() ?? "");
                                                      //                 } else {
                                                      //                   showErrrorSnackbar(
                                                      //                       message:
                                                      //                           "Please Enter Your Comment");
                                                      //                 }
                                                      //               },
                                                      //               child: Image
                                                      //                   .asset(
                                                      //                 'assets/images/chatmessagefieldicon.png',
                                                      //                 scale:
                                                      //                     1.6,
                                                      //               ),
                                                      //             ),
                                                      //             border:
                                                      //                 OutlineInputBorder(
                                                      //               borderRadius:
                                                      //                   BorderRadius.circular(
                                                      //                       10),
                                                      //             ),
                                                      //             hintText: sellerfeedback
                                                      //                     ?.sellerComment ??
                                                      //                 'Reply.....',
                                                      //             hintStyle: TextStyle(
                                                      //                 color: Color(
                                                      //                         0xFF404040)
                                                      //                     .withOpacity(
                                                      //                         0.5)),
                                                      //           ),
                                                      //         ),
                                                      //       )
                                                      //     : 
                                                          Align(
                                                              alignment: Alignment
                                                                  .bottomLeft,
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      children: [
                                                                    TextSpan(
                                                                      text:
                                                                          'Replied: ',
                                                                      style: TextStyle(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              const Color(0xff2E3192)),
                                                                    ),
                                                                    TextSpan(
                                                                      text: sellerfeedback
                                                                          ?.sellerComment,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color:
                                                                              const Color(0xff000000)),
                                                                    ),
                                                                  ]))),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),

                        storecontroller.getsellersideshopfeedbackreloading.value
                            ? Center(
                                child: customcircularprogress(),
                              )
                            : const SizedBox()
                            ,
                            SizedBox(height: 5.h,)
                      ]),
                ),
    ));
  }

  Padding feedbackreview(
      {required BuildContext context,
      required String tittle,
      required String counts,
      required double review}) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tittle,
            style: TextStyle(fontSize: 15.sp),
          ),
          SizedBox(
            width: 60.w,
            // height:,
            child: LinearProgressIndicator(
              value: review,
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xff2E3192)), // Optional: Customize progress color
            ),
          ),
          Container(
            child: Card(
              // margin: EdgeInsets.all(10),
              shape: CircleBorder(),
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  counts,
                  style: TextStyle(color: Color(0xffFFA149), fontSize: 12.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
