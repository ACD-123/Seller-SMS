import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/route_constants.dart';

class WelcomeScreen1 extends StatefulWidget {
  @override
  _WelcomeScreen1State createState() => _WelcomeScreen1State();
}

class _WelcomeScreen1State extends State<WelcomeScreen1> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> pages = [
    OnboardingPage(
      image: 'assets/images/welcome1.png',
      title: 'Simple Shopping',
      description:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English',
    ),
    OnboardingPage(
      image: 'assets/images/welcome2.png',
      title: 'Safe Payment',
      description:
          'It is a Long Established Fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English',
    ),
    OnboardingPage(
      image: 'assets/images/welcome3.png',
      title: 'Fast Delivery',
      description:
          'It is a Long Established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 25,
                  child: _currentPage > 0
                      ? GestureDetector(
                          onTap: () {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(color: Color(0xff2E3192)),
                          ),
                        )
                      : SizedBox(),
                ),
                _currentPage < pages.length - 1
                    ? Positioned(
                        bottom: 20,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            if (_currentPage < pages.length - 1) {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            } else {
                              // Navigate to next screen
                              // Get.toNamed(RouteConstants.ksignin);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Color(0xff2E3192),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Positioned(
                        bottom: 7,
                        right: 20,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed(RouteConstants.loginscreen);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2E3192),
                            minimumSize: Size(14.w, 4.h),
                          ),
                          child: Text(
                            "Let's start",
                            style: TextStyle(color: Color(0xffFFFFFF)),
                          ),
                        ),
                      ),
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: _buildPageIndicator(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages.length,
        (index) => _buildIndicatorItem(_currentPage == index),
      ),
    );
  }

  Widget _buildIndicatorItem(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: isActive ? 0.3.h : 0.2.h,
      width: 28.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? const Color(0xff2E3192) : const Color(0xffC1BBBB),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            image,
            height: 35.h,
            width: 100.w,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    color: const Color(0xff1375EA),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff8A8484),
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
