import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:powerpal/app_styles.dart';
import 'package:powerpal/loginScreen.dart';
import 'package:powerpal/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/mytext_button.dart';
import '../widgets/onboardnav_button.dart';
import './pages.dart';
import '../widgets/widgets.dart';

import '../model/onboard_data.dart';
import '../size_configs.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;

  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kSecondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Future setSeenonboard()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seenOnboard = await prefs.setBool('seeOnboard', true);
    //Set On board to true when running onboard page for the first time.
  }

  @override
  void initState() {
    super.initState();
    setSeenonboard();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 9,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: onboardingContents.length,
              itemBuilder: (context, index) => Column(
                children: [
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  Text(
                    onboardingContents[index].title,
                    style: KTitle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  Container(
                    height: sizeV * 50,
                    child: Image.asset(
                      onboardingContents[index].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: kBodyText1,
                      children: [
                        TextSpan(
                            text: 'WE CAN',
                            style: TextStyle(
                              color: kPrimaryColor,
                            )),
                        TextSpan(text: 'HELP YOU'),
                        TextSpan(text: 'PURCHASE UNITS'),
                        TextSpan(
                          text: 'SEAMLESSLY',
                          style: TextStyle(
                            color: kPrimaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                currentPage == onboardingContents.length - 1?
                 MyTextButton(
                  buttonName: 'Get Started',
                  onPressed: () {
                    Navigator.push(context,
                     MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                  bgColor: kPrimaryColor,
                 ):
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OnBoardNavBtn(
                      name: 'Skip',
                      onPressed: (){
                        Navigator.push(context,
                     MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                    ),
                    Row(
                      children: List.generate(
                        onboardingContents.length,
                        (index) => dotIndicator(index),
                      ),
                    ),
                    OnBoardNavBtn(name: 'Next',
                     onPressed: (){
                      _pageController.nextPage(duration: Duration(
                        microseconds: 400
                      ), curve: Curves.easeInOut);
                     })
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}




