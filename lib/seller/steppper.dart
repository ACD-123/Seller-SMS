import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/types/gf_border_type.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/controller/productcontroller.dart';
import 'package:smsseller/customcomponents/capitalword.dart';
import 'package:smsseller/customcomponents/currencytext.dart';
import 'package:smsseller/customcomponents/customeleveted_button.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/customcomponents/pickimages.dart';

class MyStepperApp extends StatefulWidget {
  @override
  _MyStepperAppState createState() => _MyStepperAppState();
}

class _MyStepperAppState extends State<MyStepperApp> {
  final productcontroller = Get.put(ProductController(productRepo: Get.find()));
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  int currentStep = 0;
  bool isSwitchOn = false;
  bool isSwitchOn1 = false;
  // Color? selectedColor; // Initially, no color is selected
  int? selectedOption = 1;

  // bool _isObscure2 = true;
  String? selectedCountry;
  String? selectedCity;
  String? selectedZipCode;
  TextEditingController zipCodeController = TextEditingController();
  // File? _image;

  get activecolor => null;

  int selectedSizeIndex = -1; // Initially, no size is selected
  List<String> cities = ["City 1", "City 2", "City 3"];
  String? selectedSize;
  String? selectedColor;
  // String? selectedColor;
  String? selectedBrand;
  final List<String> comapines = [
    'Poland',
    'Argentina',
    'Brazil',
    'Botswana',
  ];
  final List<String> countries = [
    'Poland',
    'Argentina',
    'Brazil',
    'Botswana',
  ];
  final List<String> brand = [
    'brand1'
        'brand2',
    'brand3',
    'brand3',
  ];
  final List<String> duration = [
    'Poland',
    'Argentina',
    'Brazil',
    'Botswana',
  ];
  final List<String> returnduration = [
    'Poland',
    'Argentina',
    'Brazil',
    'Botswana',
  ];
  final List<String> returnshipping = [
    'Poland',
    'Argentina',
    'Brazil',
    'Botswana',
  ];
  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  final List<String> colors = ['Red', 'Green', 'Blue', 'Black'];
  final List<String> brands = ['Brand A', 'Brand B', 'Brand C'];
  @override
  void initState() {
    super.initState();
    productcontroller.createproductselectedcolor.clear();
    productcontroller.getsellersubcategorieslist.value = null;
    productcontroller.createproductselectedAttributes.clear();
    productcontroller.createselectedcategoryattributesList.clear();
    productcontroller.getcategoryattributes.value = null;
    productcontroller.createproductuploadimages.clear();
    productcontroller.createproductnamecontroller.value.clear();
    productcontroller.createproductstockcontroller.value.clear();
    productcontroller.createproductdescriptioncontroller.value.clear();
    productcontroller.createproductsetpricecontroller.value.clear();
    productcontroller.createproductsalepricecontroller.value.clear();
    productcontroller.createproductbrand.value = '';
    productcontroller.createproductcategory.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              Colors.transparent, // Set the background color to transparent
          elevation: 0.0, // Remove the shadow
          title: Padding(
            padding: EdgeInsets.only(top: 8.0), // Adjust the padding as needed
            child: Text(
              'Product Condition',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ), // Your app bar title
          leading: Padding(
            padding: EdgeInsets.only(top: 10.0, right: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/arrowback1.png',
              ),
            ),
          ),
        ),
        body: Stepper(
          connectorColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey; // Color when the step is disabled
            }
            return Color(0xff2E3192); // Color when the step is active
          }),
          // activeColor: Colors.blue, // Color for the active step
          type: StepperType.horizontal,
          currentStep: currentStep,
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Container(); // This will remove the default buttons
          },
          steps: <Step>[
            _customStep2(0, "Product Specifications"),
            _customStep3(1, "Product Pricings"),
          ],
        ));
  }

  Step _customStep(int index, String title) {
    return Step(
      isActive: currentStep == index,
      state: currentStep == index
          ? StepState.indexed
          : currentStep > index
              ? StepState.complete
              : StepState.indexed,
      title: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 6,
              color: currentStep == index ? Color(0xff2E3192) : Colors.black,
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Select Condition Of Your Item',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Brand New'),
              ],
            ),
            leading: Radio<int>(
              value: 1,
              groupValue: selectedOption,
              activeColor:
                  Colors.blue, // Change the active radio button color here
              fillColor: MaterialStateProperty.all(
                  Colors.blue), // Change the fill color when selected
              splashRadius: 20, // Change the splash radius when clicked
              onChanged: (int? value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Used'),
              ],
            ),
            leading: Radio<int>(
              value: 2,
              groupValue: selectedOption,
              activeColor:
                  Colors.blue, // Change the active radio button color here
              fillColor: MaterialStateProperty.all(
                  Colors.blue), // Change the fill color when selected
              splashRadius: 20, // Change the splash radius when clicked
              onChanged: (int? value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Refurbished'),
              ],
            ),
            leading: Radio<int>(
              value: 3,
              groupValue: selectedOption,
              activeColor:
                  Colors.blue, // Change the active radio button color here
              fillColor: MaterialStateProperty.all(
                  Colors.blue), // Change the fill color when selected
              splashRadius: 20, // Change the splash radius when clicked
              onChanged: (int? value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Vintage'),
              ],
            ),
            leading: Radio<int>(
              value: 4,
              groupValue: selectedOption,
              activeColor:
                  Colors.blue, // Change the active radio button color here
              fillColor: MaterialStateProperty.all(
                  Colors.blue), // Change the fill color when selected
              splashRadius: 20, // Change the splash radius when clicked
              onChanged: (int? value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            ),
          ),
          Text(
            'Describe In Your Terms',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    // hintText: 'Message',
                    hintStyle: TextStyle(fontSize: 16),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          CustomElevetedButton(
            height: 40,
            buttonName: 'Next',
            textColor: Colors.white,
            ontap: () {
              if (currentStep < 2) {
                setState(() {
                  currentStep += 1;
                });
              }

// Get.toNamed()
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => CompletedOrderDetails(),
              //   ),
              // );
            },
            fontSize: 10,
            width: MediaQuery.of(context).size.width * 0.92,
            color: Color(0xff2E3192),
            // gradientColors: [Color(0xFF8B2CA0), Color(0xFF00C3C9)],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdowns() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        SizedBox(
          width: double.infinity, // Set the width to match parent width
          child: DropdownButtonFormField<String>(
            value: selectedSize,
            hint: Text('Select Size'),
            items: sizes.map((String size) {
              return DropdownMenuItem<String>(
                value: size,
                child: Text(size),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedSize = newValue;
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffDBDBDB)),
                borderRadius: BorderRadius.circular(15.0),
              ),
              fillColor: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text('Available Colors'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        SizedBox(
          width: double.infinity, // Set the width to match parent width
          child: DropdownButtonFormField<String>(
            value: selectedColor,
            hint: Text('Select Color'),
            items: colors.map((String color) {
              return DropdownMenuItem<String>(
                value: color,
                child: Text(color),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedColor = newValue;
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffDBDBDB)),
                borderRadius: BorderRadius.circular(15.0),
              ),
              fillColor: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Step _customStep2(int index, String title) {
    return Step(
      isActive: currentStep == index,
      state: currentStep == index
          ? StepState.indexed
          : currentStep > index
              ? StepState.complete
              : StepState.indexed,
      title: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: currentStep == index ? Color(0xff2E3192) : Colors.black,
            ),
          ),
        ],
      ),
      content: Form(
        key: formKey1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Describe Your Item',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                productcontroller.uploadcreateproductimages(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 40.0, top: 30, right: 50),
                child: Container(
                  width: Get.width,
                  height: 90,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: GFBorder(
                      dashedLine: [3, 4],
                      type: GFBorderType.rect,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/uploadicon.png'),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Upload Images',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Obx(() => productcontroller.createproductuploadimages.isEmpty
                ? SizedBox()
                : SizedBox(
                    height: 10.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: productcontroller
                                  .createproductuploadimages.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final productimages = productcontroller
                                    .createproductuploadimages[index];
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.file(
                                            File(productimages?.path ?? ""),
                                            fit: BoxFit.fill,
                                            width: 25.w,
                                            height: 8.h,
                                          )),
                                      Positioned(
                                        right: -5,
                                        top: -0,
                                        child: GestureDetector(
                                          onTap: () {
                                            productcontroller
                                                .createproductremoveimages(
                                                    index);
                                          },
                                          child: CircleAvatar(
                                            radius: 13.sp,
                                            backgroundColor: Color(0xff2E3192),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    ))),
            SizedBox(
              height: 1.h,
            ),
            Row(children: [
              Image.asset('assets/images/abc.png'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Text(
                'Add Minimum 5 Images Covering All Angles.',
                style: TextStyle(fontSize: 9),
              ),
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text('Product Name'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextFormField(
              controller: productcontroller.createproductnamecontroller.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffDBDBDB)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                fillColor: Colors.white,
                // hintText: 'Street Address',
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Product Name can\'t be empty';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text('Category'),
            Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) {
                    if (v == null) {
                      return 'Category can\'t be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffDBDBDB)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    fillColor: Colors.white,
                    hintText: 'Select Category',
                  ),
                  value: productcontroller.createproductselectedcategory?.value,
                  items: productcontroller.getsellercategorieslist.value?.data
                      ?.map((categories) {
                    return DropdownMenuItem<String>(
                      value: categories.id.toString(),
                      child: Text(categories.name.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      productcontroller.createselectedcategoryattributesList
                          .clear();
                      productcontroller.createproductcategory.value = value!;
                      var selectedCategory = productcontroller
                          .getsellercategorieslist.value?.data
                          ?.firstWhere(
                              (category) => category.id.toString() == value);
                      productcontroller
                          .getCategoryAttributes(selectedCategory?.guid ?? "");
                      productcontroller.getsellerSubCategoriesList(value);
                    });
                  },
                ),
              ],
            ),

            Obx(
              () => productcontroller.getsellersubcategorieslist.value ==
                          null ||
                      productcontroller.getsellersubcategorieslist.value!.data!
                          .subCategories!.isEmpty
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text(
                          'Sub-Category (Optional)',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        SizedBox(height: 1.h),
                        DropdownButtonFormField<String>(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            // validator: (v) {
                            //   if (v == null) {
                            //     return 'Category can\'t be empty';
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(12),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffDBDBDB)),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              fillColor: Colors.white,
                              hintText: 'Select Sub-Category',
                            ),
                            value: productcontroller
                                .createproductselectedsubcategory?.value,
                            items: productcontroller.getsellersubcategorieslist
                                .value?.data?.subCategories
                                ?.map((subcategories) {
                              return DropdownMenuItem<String>(
                                value: subcategories.id.toString(),
                                child: Text(subcategories.name.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              productcontroller
                                  .createSelectedproductsubCategorydropdown(
                                      value!);
                              // setState(() {
                              //   productcontroller.createselectedcategoryattributesList.clear();
                              //   productcontroller.createproductcategory.value = value!;
                              //  var selectedsubCategory = productcontroller
                              //       .getsellersubcategorieslist.value?.data?.subCategories
                              //       ?.firstWhere(
                              //           (subcategory) => subcategory.id.toString() == value);
                              //   productcontroller
                              //       .getCategoryAttributes(selectedsubCategory?.guid.toString() ?? "");
                            }),
                      ],
                    ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Obx(
              () => productcontroller.productcolorImagesloading.value
                  ? Center(
                      child: SizedBox(
                      height: 4.h,
                      width: 8.w,
                      child: customcircularprogress(),
                    ))
                  : Wrap(
                      spacing: 8.0,
                      children: productcontroller
                          .createselectedcategoryattributesList
                          .map((attribute) {
                        final name = attribute['name'];
                        final attributeId = attribute['attribute_id'];
                        final String imageurl = attribute['image_url'];
                        return imageurl.isEmpty
                            ? Chip(
                                label: Text('$name'),
                                deleteIcon: CircleAvatar(
                                  radius: 13.sp,
                                  backgroundColor: const Color(0xff2E3192),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16.sp,
                                  ),
                                ),
                                onDeleted: () {
                                  if (name == null || attributeId == null)
                                    return;
                                  productcontroller
                                      .createselectedcategoryattributesList
                                      .removeWhere(
                                    (entry) =>
                                        entry['name'] == name &&
                                        entry['attribute_id'] == attributeId,
                                  );
                                },
                              )
                            : Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: Container(
                                  width: 25.w,
                                  margin: EdgeInsets.only(right: 2.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 13.w,
                                              child: Text(toCamelCase(name)),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (name == null ||
                                                    attributeId == null) return;
                                                productcontroller
                                                    .createselectedcategoryattributesList
                                                    .removeWhere(
                                                  (entry) =>
                                                      entry['name'] == name &&
                                                      entry['attribute_id'] ==
                                                          attributeId,
                                                );

                                                productcontroller
                                                    .createproductselectedcolor
                                                    .removeWhere(
                                                  (entry) =>
                                                      entry['name'] == name &&
                                                      entry['attribute_id'] ==
                                                          attributeId,
                                                );
                                              },
                                              child: CircleAvatar(
                                                radius: 13.sp,
                                                backgroundColor:
                                                    const Color(0xff2E3192),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 1.h),
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Image.network(
                                              imageurl.isNotEmpty
                                                  ? imageurl
                                                  : AppConstants.noimage,
                                              fit: BoxFit.fill,
                                              width: 25.w,
                                              height: 8.h,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      }).toList(),
                    ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     productcontroller.uploadcreateproductimages(context);
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 1.w),
            //     child: Container(
            //       width: Get.width,
            //       height: 10.h,
            //       decoration:
            //           BoxDecoration(borderRadius: BorderRadius.circular(20)),
            //       child: GFBorder(
            //           dashedLine: [3, 4],
            //           type: GFBorderType.rect,
            //           color: Colors.black,
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Image.asset('assets/images/uploadicon.png'),
            //               SizedBox(
            //                 height: 0.5.h,
            //               ),
            //               Text(
            //                 'Upload Images As Selected Color',
            //                 style:
            //                     TextStyle(color: Colors.grey, fontSize: 14.sp),
            //               )
            //             ],
            //           )),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 2.h,
            // ),

            Obx(() => productcontroller.getcategoryattributesloading.value
                ? Center(
                    child: SizedBox(
                    height: 3.h,
                    width: 5.w,
                    child: customcircularprogress(),
                  ))
                : productcontroller.getcategoryattributes.value == null
                    ? const SizedBox()
                    : productcontroller.getcategoryattributes.value!.data!
                            .attributes!.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: productcontroller.getcategoryattributes
                                .value?.data?.attributes?.length,
                            itemBuilder: (context, index) {
                              final categoryAttributeData = productcontroller
                                  .getcategoryattributes
                                  .value
                                  ?.data
                                  ?.attributes?[index];
                              final categoryname =
                                  categoryAttributeData?.name ?? "";

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(toCamelCase(
                                      categoryAttributeData?.name.toString() ??
                                          "")),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  categoryAttributeData?.name == 'Colors'
                                      ? SizedBox(
                                          height: 4.h,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                ...List.generate(
                                                  categoryAttributeData
                                                          ?.optionscode
                                                          ?.length ??
                                                      0,
                                                  (colorIndex) {
                                                    final colorCode =
                                                        categoryAttributeData
                                                                    ?.optionscode?[
                                                                colorIndex] ??
                                                            "#FFFFFF";
                                                    final colorOptionName =
                                                        categoryAttributeData
                                                                    ?.options?[
                                                                colorIndex] ??
                                                            "";

                                                    return GestureDetector(
                                                      onTap: () async {
                                                        final pickedImage =
                                                            await pickImage(
                                                                context);
                                                        if (pickedImage !=
                                                            null) {
                                                          productcontroller.createproductColorImages(
                                                              context: context,
                                                              attributesColorimages:
                                                                  pickedImage,
                                                              colorOptionName:
                                                                  colorOptionName,
                                                              categoryAttributeid:
                                                                  categoryAttributeData
                                                                          ?.id
                                                                          .toString() ??
                                                                      "",
                                                              colorCode:
                                                                  colorCode);
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 2),
                                                            shape: BoxShape
                                                                .circle),
                                                        margin: EdgeInsets.only(
                                                            right: 2.w),
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Color(int.parse(
                                                                  "0xff${colorCode.replaceFirst('#', '')}")),
                                                          radius: 18.sp,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : DropdownButtonFormField<String>(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (attribute) {
                                            if (attribute == null ||
                                                attribute.isEmpty) {
                                              return "Please Select ${categoryAttributeData.name ?? ""}";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            hintText:
                                                'Select ${categoryAttributeData?.name ?? ""}',
                                            fillColor: Colors.white,
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                            contentPadding: EdgeInsets.all(15),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xffDBDBDB)),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                          ),
                                          value: productcontroller
                                              .createproductselectedAttributes[
                                                  categoryname]
                                              ?.first,
                                          onChanged: (newValue) async {
                                            if (newValue == null) return;

                                            final categoryAttributeData =
                                                productcontroller
                                                    .getcategoryattributes
                                                    .value
                                                    ?.data
                                                    ?.attributes?[index];
                                            if (categoryAttributeData == null)
                                              return;

                                            final attributeId =
                                                categoryAttributeData.id;
                                            if (attributeId == null) return;

                                            final selectedOption =
                                                (categoryAttributeData
                                                            .options ??
                                                        [])
                                                    .firstWhere(
                                              (option) =>
                                                  '${categoryAttributeData.name}_$option' ==
                                                  newValue,
                                              orElse: () => '',
                                            );
                                            print(
                                                "Type: ${categoryname.toLowerCase()}");
                                            if (selectedOption.isEmpty) return;

                                            final entry = {
                                              'name': selectedOption,
                                              'attribute_id': attributeId,
                                              'color_code': '',
                                              'image_url': ''
                                            };

                                            final existingEntryIndex =
                                                productcontroller
                                                    .createselectedcategoryattributesList
                                                    .indexWhere(
                                              (entry) =>
                                                  entry['attribute_id'] ==
                                                      attributeId &&
                                                  entry['name'] ==
                                                      selectedOption,
                                            );

                                            if (existingEntryIndex != -1) {
                                              productcontroller
                                                      .createselectedcategoryattributesList[
                                                  existingEntryIndex] = entry;
                                            } else {
                                              productcontroller
                                                  .createselectedcategoryattributesList
                                                  .add(entry);
                                            }

                                            final currentAttributes =
                                                productcontroller
                                                    .createproductselectedAttributes
                                                    .putIfAbsent(
                                                        categoryname, () => []);

                                            if (!currentAttributes
                                                .contains(newValue)) {
                                              productcontroller
                                                      .createproductselectedAttributes[
                                                  categoryname] = [
                                                ...currentAttributes,
                                                newValue,
                                              ];
                                            }

                                            print(productcontroller
                                                .createselectedcategoryattributesList);
                                          },
                                          items: categoryAttributeData!.options!
                                              .map<DropdownMenuItem<String>>(
                                                  (option) {
                                            final categoryvalue =
                                                '${categoryAttributeData.name}_$option';
                                            return DropdownMenuItem<String>(
                                              value: categoryvalue,
                                              child: Text(option),
                                            );
                                          }).toList(),
                                        ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                ],
                              );
                            })),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text('Brands'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              width: double.infinity, // Set the width to match parent width
              child: DropdownButtonFormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) {
                  if (v == null) {
                    return 'Brands can\'t be empty';
                  }
                  return null;
                },
                value: productcontroller.createproductselectedbrand?.value,
                hint: Text('Select Brand'),
                items: productcontroller.getbrandslist.value?.data?.brands
                    ?.map((brand) {
                  return DropdownMenuItem<String>(
                    value: brand.id.toString(),
                    child: Text(brand.name.toString()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    productcontroller.createproductbrand.value = newValue!;
                    print(productcontroller.createproductbrand.value);
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffDBDBDB)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text('Stock Capacity'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextFormField(
              controller: productcontroller.createproductstockcontroller.value,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffDBDBDB)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                fillColor: Colors.white,
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Stock can\'t be empty';
                }
                return null;
              },
              onSaved: (value) {},
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text('Description'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextFormField(
              controller:
                  productcontroller.createproductdescriptioncontroller.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffDBDBDB)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                fillColor: Colors.white,
                // hintText: 'Street Address',
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Description can\'t be empty';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            // Text('Add TAGS'),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.01,
            // ),
            // TextFormField(
            //   decoration: InputDecoration(
            //     // errorBorder: Border.all(),
            //     contentPadding: EdgeInsets.all(15),
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide(color: Color(0xffDBDBDB)),
            //       borderRadius: BorderRadius.circular(15.0),
            //     ),
            //     fillColor: Colors.white,
            //     // hintText: 'Street Address',
            //   ),
            //   validator: null,
            //   onSaved: (value) {},
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            // Row(
            //   children: [
            //     Image.asset('assets/images/abc.png'),
            //     SizedBox(
            //       width: MediaQuery.of(context).size.width * 0.02,
            //     ),
            //     Text(
            //       'Add Tags as much as possible to make your more easily searchable',
            //       style: TextStyle(fontSize: 12.5.sp),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            CustomElevetedButton(
              height: 40,
              buttonName: 'Next',
              textColor: Colors.white,
              ontap: () {
                if (formKey1.currentState!.validate()) {
                  if (productcontroller.createproductuploadimages.isEmpty) {
                    showErrrorSnackbar(message: "Please Upload Product Images");
                  } else if (productcontroller
                          .getcategoryattributes.value?.data?.attributes
                          ?.any(
                        (attribute) => attribute.name == "Colors",
                      ) ??
                      false) {
                    if (productcontroller.createproductselectedcolor.isEmpty) {
                      showErrrorSnackbar(message: "Please Select Color");
                    } else {
                      if (currentStep < 2) {
                        setState(() {
                          currentStep += 1;
                        });
                      }
                    }
                  } else {
                    if (currentStep < 2) {
                      setState(() {
                        currentStep += 1;
                      });
                    }
                  }
                }
              },
              fontSize: 10,
              width: MediaQuery.of(context).size.width * 0.92,
              color: Color(0xff2E3192),
            ),
          ],
        ),
      ),
    );
  }

  Step _customStep3(int index, String title) {
    return Step(
      isActive: currentStep == index,
      state: currentStep == index
          ? StepState.indexed
          : currentStep > index
              ? StepState.complete
              : StepState.indexed,
      title: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: currentStep == index ? Color(0xff2E3192) : Colors.black,
            ),
          ),
        ],
      ),
      content: Form(
        key: formKey2,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Set Price'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          TextFormField(
            controller: productcontroller.createproductsetpricecontroller.value,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: '${currencytext()}65.00',

              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffDBDBDB)),
                borderRadius: BorderRadius.circular(15.0),
              ),
              fillColor: Colors.white,
              // hintText: 'Street Address',
            ),
            keyboardType: TextInputType.number,
            validator: (v) {
              if (v!.isEmpty) {
                return 'Set Price can\'t be empty';
              }
              return null;
            },
            onSaved: (value) {},
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text('Sale Price'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          TextFormField(
            controller:
                productcontroller.createproductsalepricecontroller.value,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: '${currencytext()}50.00',
              // errorBorder: Border.all(),
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffDBDBDB)),
                borderRadius: BorderRadius.circular(15.0),
              ),
              fillColor: Colors.white,
              // hintText: 'Street Address',
            ),
            keyboardType: TextInputType.number,
            validator: (v) {
              if (v!.isEmpty) {
                return 'Sale Price can\'t be empty';
              }
              return null;
            },
            onSaved: (value) {},
          ),
          Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Obx(
            () => productcontroller.createproductloading.value
                ? Center(
                    child: customcircularprogress(),
                  )
                : CustomElevetedButton(
                    height: 40,
                    buttonName: 'Create',
                    textColor: Colors.white,
                    ontap: () {
                      if (formKey1.currentState!.validate() &&
                          formKey2.currentState!.validate()) {
                        if (productcontroller
                            .createproductuploadimages.isEmpty) {
                          showErrrorSnackbar(
                              message: "Please Upload Product Images");
                        } else if (productcontroller
                                .getcategoryattributes.value?.data?.attributes
                                ?.any(
                              (attribute) => attribute.name == "Colors",
                            ) ??
                            false) {
                          if (productcontroller
                              .createproductselectedcolor.isEmpty) {
                            showErrrorSnackbar(message: "Please Select Color");
                          } else {
                            productcontroller.createProduct(context: context);
                          }
                        } else {
                          productcontroller.createProduct(context: context);
                        }
                      }
                    },
                    fontSize: 10,
                    color: Color(0xff2E3192),
                    width: MediaQuery.of(context).size.width * 0.92,
                  ),
          )
        ]),
      ),
    );
  }

//   Step _customStep4(int index, String title) {
//     return Step(
//       isActive: currentStep == index,
//       state: currentStep == index
//           ? StepState.indexed
//           : currentStep > index
//               ? StepState.complete
//               : StepState.indexed,
//       title: Row(
//         children: <Widget>[
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 6,
//               color: currentStep == index ? Color(0xff2E3192) : Colors.black,
//             ),
//           ),
//         ],
//       ),
//       content: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Divider(),
//           // Padding(
//           //   padding: EdgeInsets.all(5.0),
//           //   child: _buildListItem(
//           //     'Deliver Domestically',
//           //     switchValue: isSwitchOn,
//           //     onSwitchChanged: (value) {
//           //       setState(() {
//           //         isSwitchOn = value;
//           //       });
//           //     },
//           //     lineargradientColors: [Color(0xFF8B2CA0), Color(0xFF00C3C9)],
//           //     text2: 'Add minimum 5 images covering all angles.',
//           //     onTap: () {
//           //       // Handle tap event
//           //     },
//           //   ),
//           // ),
//           Text('Select Delivery Company'),
//           Column(
//             children: <Widget>[
//               SizedBox(height: 10.0),
//               DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(12),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xffDBDBDB)),
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   fillColor: Colors.white,
//                   hintText: 'FEDX',
//                 ),
//                 value: _selectedcompany,
//                 items: comapines.map((company) {
//                   return DropdownMenuItem<String>(
//                     value: company,
//                     child: Text(company),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedcompany = value;
//                   });
//                 },
//               ),
//             ],
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.02,
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: 150.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [Text('State'), Text('City')],
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.01,
//           ),
//           Container(
//             // margin: EdgeInsets.only(left: 20.0, right: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: buildDropdown("Michigan, MI", cities, selectedCity,
//                           (String? newValue) {
//                         setState(() {
//                           selectedCity = newValue;
//                         });
//                       }),
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: TextFormField(
//                         controller: zipCodeController,
//                         decoration: InputDecoration(
//                           hintText: 'Detroit',
//                           fillColor: Colors.white,
//                           hintStyle: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Color(0xffDBDBDB)),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Color(0xffDBDBDB)),
//                           ),
//                           contentPadding: EdgeInsets.all(15),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.02,
//           ),
//           Text('Shipping Price'),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.01,
//           ),
//           TextFormField(
//             decoration: InputDecoration(
//               hintText: '\$45.00',
//               contentPadding: EdgeInsets.all(15),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xffDBDBDB)),
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               fillColor: Colors.white,
//               // hintText: 'Street Address',
//             ),
//             validator: null,
//             onSaved: (value) {},
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.02,
//           ),
//           Text('Shipping Duration'),
//           Column(
//             children: <Widget>[
//               SizedBox(height: 10.0),
//               DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(12),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xffDBDBDB)),
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   fillColor: Colors.white,
//                   hintText: 'FEDX',
//                 ),
//                 value: _selectedduration,
//                 items: duration.map((durations) {
//                   return DropdownMenuItem<String>(
//                     value: durations,
//                     child: Text(durations),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedduration = value;
//                   });
//                 },
//               ),
//             ],
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.02,
//           ),
//           Text('Return Shipping Price'),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.01,
//           ),
//           TextFormField(
//             decoration: InputDecoration(
//               hintText: '\$45.00',
//               contentPadding: EdgeInsets.all(15),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xffDBDBDB)),
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               fillColor: Colors.white,
//               // hintText: 'Street Address',
//             ),
//             validator: null,
//             onSaved: (value) {},
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.02,
//           ),
//           Text('Return Shipping Location'),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.01,
//           ),
//           TextFormField(
//             decoration: InputDecoration(
//               hintText: '\$45.00',
//               contentPadding: EdgeInsets.all(15),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xffDBDBDB)),
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               fillColor: Colors.white,
//               // hintText: 'Street Address',
//             ),
//             validator: null,
//             onSaved: (value) {},
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.03,
//           ),
//           // Divider(),
//           // Padding(
//           //   padding: EdgeInsets.all(5.0),
//           //   child: _buildListItem(
//           //     'Deliver Domestically',
//           //     switchValue: isSwitchOn,
//           //     onSwitchChanged: (value) {
//           //       setState(() {
//           //         isSwitchOn = value;
//           //       });
//           //     },
//           //     lineargradientColors: [Color(0xFF8B2CA0), Color(0xFF00C3C9)],
//           //     text2: 'Add minimum 5 images covering all angles',
//           //     onTap: () {
//           //       // Handle tap event
//           //     },
//           //   ),
//           // ),
//           Divider(),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.02,
//           ),
//           CustomElevetedButton(
//             height: 40,
//             buttonName: 'Product Preview',
//             textColor: Colors.white,
//             ontap: () {
//               // if (currentStep < 2) {
//               //   setState(() {
//               //     currentStep += 1;
//               //   });
//               // }
//               showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return customsuccessalertpopup(
//                         message: "Product has been uploaded");
//                   });
//               Future.delayed(Duration(seconds: 2), () {
//                 Get.offAllNamed(RouteConstants.userbottomnavbar);
//               });
//             },
//             color: Color(0xff2E3192),
//             fontSize: 10,
//             width: MediaQuery.of(context).size.width * 0.92,
//           ),
//         ],
//       ),
//     );
//   }
// }

  Widget buildDropdown(String hint, List<String> items, String? selectedValue,
      void Function(String?)? onChanged) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(13),
          hintText: hint,
          fillColor: Colors.black,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xffDBDBDB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xffDBDBDB)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        value: selectedValue,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListItem(
    String text, {
    String? text2,
    Color? borderColour,
    bool switchValue = false,
    ValueChanged<bool>? onSwitchChanged,
    VoidCallback? onTap,
    List<Color>? lineargradientColors,
  }) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColour ?? Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 3,
          ),
          if (text2 != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text2,
                  style: TextStyle(fontSize: 10, color: Color(0xff757474)),
                ),
                _customGradientSwitch(
                  switchValue: switchValue,
                  onSwitchChanged: onSwitchChanged!,
                  gradientColors: lineargradientColors,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _customGradientSwitch({
    required bool switchValue,
    required ValueChanged<bool> onSwitchChanged,
    List<Color>? gradientColors,
  }) {
    return GestureDetector(
      onTap: () {
        onSwitchChanged(!switchValue);
      },
      child: Container(
        width: 50.0, // Adjust the width as needed
        height: 30.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors ?? [Colors.grey, Colors.grey],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              left: switchValue ? 20.0 : 0.0,
              right: switchValue ? 0.0 : 20.0,
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
