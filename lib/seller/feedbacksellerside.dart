import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SellerFeedback extends StatefulWidget {
  const SellerFeedback({super.key});

  @override
  State<SellerFeedback> createState() => _SellerFeedbackState();
}

class _SellerFeedbackState extends State<SellerFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              // mainAxisAlignment: ,
              children: [
                Text('Last 12 months',
                    style: TextStyle(
                      fontSize: 14,
                    )),
                SizedBox(
                  width: 2.w,
                ),
                Image.asset('assets/images/arrowdownicon.png')
              ],
            ),
          ),
          feedbackreview(context, 'Positive reviews', '2.0'),
          feedbackreview(context, 'Negative reviews', '4.0'),
          feedbackreview(context, 'Reply timing', '5.0'),
          feedbackreview(context, 'Customer care', '6.0'),
          buildContainerWithContent(
              context: context,
              price: '200',
              description: "asdads",
              imagePath: 'assets/images/profileseller.png',
              saleprice: '200'),
          buildContainerWithContent(
              context: context,
              price: '200',
              description: "asdads",
              imagePath: 'assets/images/profileseller.png',
              saleprice: '200'),
          buildContainerWithContent(
              context: context,
              price: '200',
              description: "asdads",
              imagePath: 'assets/images/profileseller.png',
              saleprice: '200')
        ]),
      ),
    );
  }

  Padding feedbackreview(BuildContext context, String tittle, String review) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tittle),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            // height:,
            child: LinearProgressIndicator(
              value: 3.0,
              // Set the alue to 0.5 for half-filled progress
              backgroundColor:
                  Colors.grey, // Optional: Customize background color
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xff2E3192)), // Optional: Customize progress color
            ),
          ),
          Container(
            // height: 30, // Set the desired height here

            child: Card(
              // margin: EdgeInsets.all(10),
              shape: CircleBorder(),
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  review,
                  style: TextStyle(color: Color(0xffFFA149), fontSize: 11),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildContainerWithContent({
  required BuildContext context,
  required String imagePath,
  required String description,
  required String price,
  required String saleprice,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 10.0, right: 10.0),
    child: Column(
      children: [
        Card(
          color: Colors.white,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceA.,
              children: [
                // NetworkImage(url)
                // Image.asset(imagePath), // Load your image here
                Row(
                  children: [
                    Center(
                      child: Image.asset(
                        imagePath,
                        height: MediaQuery.of(context).size.height * 0.1,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('@Superman  (33). '),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            Text('10 days ago')
                          ],
                        ),
                        Row(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star_purple500_sharp,
                                      color: const Color(0xffFFAD33),
                                      size: 16.sp,
                                    ))),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Reply',
                      style:
                          TextStyle(fontSize: 13.sp, color: Color(0xff8B2CA0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              fillColor: const Color(0XFFFFFFFF),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFFDBDBDB), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFFDBDBDB), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.all(15.0),
              suffixIcon: Image.asset(
                'assets/images/chatmessagefieldicon.png',
                scale: 1.6,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Reply.....',
              hintStyle: TextStyle(color: Color(0xFF404040).withOpacity(0.5)),
            ),
          ),
        )
      ],
    ),
  );
}
