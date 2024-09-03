import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/types/gf_border_type.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/controller/productcontroller.dart';
import 'package:smsseller/customcomponents/customeleveted_button.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class UpdateStepper extends StatefulWidget {
  @override
  _UpdateStepperState createState() => _UpdateStepperState();
}

class _UpdateStepperState extends State<UpdateStepper> {
  final productcontroller = Get.put(ProductController(productRepo: Get.find()));
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    productcontroller.updateproductcategory.value = '';
    productcontroller.updateproductbrand.value = '';
    productcontroller.updateproductselectedAttributes.clear();
    productcontroller.updateselectedcategoryattributesList.clear();
    productcontroller.updateoldproductimageids.clear();
    productcontroller.updateproductuploadimages.clear();
    productcontroller.updateproductnamecontroller.value.clear();
    productcontroller.updateproductstockcontroller.value.clear();
    productcontroller.updateproductdescriptioncontroller.value.clear();
    productcontroller.updateproductsetpricecontroller.value.clear();
    productcontroller.updateproductsalepricecontroller.value.clear();
    productcontroller.updateproductcategory.value = productcontroller
            .getproductpreviewbyid.value?.data?.categoryId
            .toString() ??
        "";
    productcontroller.updateproductbrand.value = productcontroller
            .getproductpreviewbyid.value?.data?.brandId
            .toString() ??
        "";
    productcontroller.getCategoryAttributes(
        productcontroller.getproductpreviewbyid.value?.data?.category?.guid ??
            "");
    productcontroller.mapNewAttributesToSelectedAttributes();
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
              'Update Product',
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
        body: Obx(() => productcontroller.getproductpreviewbyidloading.value
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Center(
                  child: customcircularprogress(),
                ),
              )
            : productcontroller.getproductpreviewbyid.value == null ||
                    productcontroller.getproductpreviewbyid.value?.data == null
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Center(
                        child: Text(
                      "No Product Details",
                      style: TextStyle(fontSize: 15.sp),
                    )),
                  )
                : Stepper(
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
                    controlsBuilder:
                        (BuildContext context, ControlsDetails controls) {
                      return Container(); // This will remove the default buttons
                    },
                    steps: <Step>[
                      _customStep2(0, "Product Specifications"),
                      _customStep3(1, "Product Pricings"),
                    ],
                  )));
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
                productcontroller.uploadupdateproductimages(context);
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
            Obx(() => SizedBox(
                height: 10.h,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      productcontroller.updateproductuploadimages.isEmpty
                          ? const SizedBox()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: productcontroller
                                  .updateproductuploadimages.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final productimages = productcontroller
                                    .updateproductuploadimages[index];
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
                                                .updateproductremoveimages(
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
                      productcontroller
                              .getproductpreviewbyid.value!.data!.media!.isEmpty
                          ? const SizedBox()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: productcontroller.getproductpreviewbyid
                                  .value?.data?.media?.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final oldproductimages = productcontroller
                                    .getproductpreviewbyid
                                    .value
                                    ?.data
                                    ?.media?[index];
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.network(
                                            oldproductimages?.originalUrl ??
                                                AppConstants.noimage,
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
                                                .removeoldupdateproductimages(
                                                    oldimageid:
                                                        oldproductimages?.id ??
                                                            0,
                                                    index: index);
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
            Text('Product Name'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextFormField(
              controller: productcontroller.updateproductnamecontroller.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffDBDBDB)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                fillColor: Colors.white,
                hintText: productcontroller
                        .getproductpreviewbyid.value?.data?.title ??
                    "",
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
                  value: productcontroller
                          .getproductpreviewbyid.value?.data?.category?.id
                          .toString() ??
                      "",
                  items: productcontroller.getsellercategorieslist.value?.data
                      ?.map((categories) {
                    return DropdownMenuItem<String>(
                      value: categories.id.toString(),
                      child: Text(categories.name.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    productcontroller.updateproductcategorydropdown(value!);
                  },
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Obx(
              () => Wrap(
                spacing: 8.0,
                children: productcontroller.updateselectedcategoryattributesList
                    .map((attribute) {
                  final id = attribute['id'];
                  final name = attribute['name'];
                  final attributeId = attribute['attribute_id'];

                  return Chip(
                    label: Text('$name'),
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () {
                      if (name == null || id == null || attributeId == null)
                        return;
                      productcontroller.updateselectedcategoryattributesList
                          .removeWhere(
                        (entry) =>
                            entry['id'] == id &&
                            entry['name'] == name &&
                            entry['attribute_id'] == attributeId,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
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
                                  Text(categoryAttributeData?.name.toString() ??
                                      ""),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  DropdownButtonFormField<String>(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
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
                                        .updateproductselectedAttributes[
                                            categoryname]
                                        ?.first,
                                    onChanged: (newValue) {
                                      if (newValue == null) return;

                                      final categoryAttributeData =
                                          productcontroller
                                              .getcategoryattributes
                                              .value
                                              ?.data
                                              ?.attributes?[index];
                                      if (categoryAttributeData == null) return;

                                      final attributeId =
                                          categoryAttributeData.id;
                                      if (attributeId == null) return;

                                      final selectedOption =
                                          (categoryAttributeData.options ?? [])
                                              .firstWhere(
                                        (option) =>
                                            '${categoryAttributeData.name}_$option' ==
                                            newValue,
                                        orElse: () => '',
                                      );

                                      if (selectedOption.isEmpty) return;

                                      final randomId = productcontroller
                                          .generateUniqueRandomString(5);
                                      final entry = {
                                        'id': randomId,
                                        'name': selectedOption,
                                        'attribute_id': attributeId,
                                      };

                                      final existingEntryIndex = productcontroller
                                          .updateselectedcategoryattributesList
                                          .indexWhere((entry) =>
                                              entry['attribute_id'] ==
                                                  attributeId &&
                                              entry['name'] == selectedOption);

                                      if (existingEntryIndex == -1) {
                                        productcontroller
                                            .updateselectedcategoryattributesList
                                            .add(entry);
                                      }

                                      final currentAttributes =
                                          productcontroller
                                              .updateproductselectedAttributes
                                              .putIfAbsent(
                                                  categoryname, () => []);

                                      if (!currentAttributes
                                          .contains(newValue)) {
                                        productcontroller
                                                .updateproductselectedAttributes[
                                            categoryname] = [
                                          ...currentAttributes,
                                          '${categoryAttributeData.name}_$newValue',
                                        ];
                                      }
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
                value: productcontroller
                        .getproductpreviewbyid.value?.data?.brand?.id
                        .toString() ??
                    "",
                hint: Text('Select Brand'),
                items: productcontroller.getbrandslist.value?.data?.brands
                    ?.map((brand) {
                  return DropdownMenuItem<String>(
                    value: brand.id.toString(),
                    child: Text(brand.name.toString()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  productcontroller.updateproductbranddropdown(newValue!);
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
              controller: productcontroller.updateproductstockcontroller.value,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: productcontroller
                        .getproductpreviewbyid.value?.data?.stock
                        .toString() ??
                    "",
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
                  productcontroller.updateproductdescriptioncontroller.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffDBDBDB)),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                fillColor: Colors.white,
                hintText: productcontroller
                        .getproductpreviewbyid.value?.data?.description
                        .toString() ??
                    "",
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Description can\'t be empty';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            CustomElevetedButton(
              height: 5.h,
              buttonName: 'Next',
              textColor: Colors.white,
              ontap: () {
                if (productcontroller
                        .getproductpreviewbyid.value!.data!.media!.isEmpty &&
                    productcontroller.updateproductuploadimages.isEmpty) {
                  showErrrorSnackbar(message: "Please Upload Product Images");
                } else {
                  if (currentStep < 2) {
                    setState(() {
                      currentStep += 1;
                    });
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
            controller: productcontroller.updateproductsetpricecontroller.value,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: productcontroller
                      .getproductpreviewbyid.value?.data?.price
                      .toString() ??
                  "",

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
                productcontroller.updateproductsalepricecontroller.value,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: productcontroller
                      .getproductpreviewbyid.value?.data?.discountPrice
                      .toString() ??
                  "",

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
            () => productcontroller.updateproductloading.value
                ? Center(
                    child: customcircularprogress(),
                  )
                : CustomElevetedButton(
                    height: 5.h,
                    buttonName: 'Update',
                    textColor: Colors.white,
                    ontap: () {
                      productcontroller.getcategoryattributes.value!.data!
                                  .attributes!.isNotEmpty &&
                              productcontroller
                                  .updateselectedcategoryattributesList.isEmpty
                          ? showErrrorSnackbar(
                              message: "Please Select Attributes")
                          : productcontroller.getproductpreviewbyid.value!.data!
                                      .media!.isEmpty &&
                                  productcontroller
                                      .updateproductuploadimages.isEmpty
                              ? showErrrorSnackbar(
                                  message: "Please Upload Product Images")
                              : productcontroller.updateProduct(
                                  context: context,
                                  id: productcontroller
                                          .getproductpreviewbyid.value?.data?.id
                                          .toString() ??
                                      "");
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
}
