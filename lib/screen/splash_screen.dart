import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:konser/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components.dart';
import '../model/model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  /// Anime
  Widget animationDo(
    int index,
    int delay,
    Widget child,
  ) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: pageController,
              itemCount: listOfItems.length,
              onPageChanged: (newIndex) {
                setState(() {
                  currentIndex = newIndex;
                });
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: ((context, index) {
                return SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      /// IMG
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        width: size.width,
                        height: size.height / 2.0,
                        child: animationDo(
                          index,
                          100,
                          Image.asset(listOfItems[index].img),
                        ),
                      ),

                      /// TITLE TEXT
                      Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: animationDo(
                            index,
                            300,
                            Text(
                              listOfItems[index].title,
                              textAlign: TextAlign.center,
                              style: textTheme.displayLarge,
                            ),
                          )),

                      /// SUBTITLE TEXT
                      animationDo(
                        index,
                        500,
                        Text(
                          listOfItems[index].subTitle,
                          textAlign: TextAlign.center,
                          style: textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),

          /// ---------------------------
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// PAGE INDICATOR
                SmoothPageIndicator(
                  controller: pageController,
                  count: listOfItems.length,
                  effect: const ExpandingDotsEffect(
                    spacing: 6.0,
                    radius: 10.0,
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    expansionFactor: 3.8,
                    dotColor: Colors.grey,
                    activeDotColor: MyColors.btnColor,
                  ),
                  onDotClicked: (newIndex) {
                    setState(() {
                      currentIndex = newIndex;
                      pageController.animateToPage(newIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    });
                  },
                ),
                currentIndex == 2

                    /// GET STARTED BTN
                    ? GetStartBtn(size: size, textTheme: textTheme)

                    /// SKIP BTN
                    : SkipBtn(
                        size: size,
                        textTheme: textTheme,
                        onTap: () {
                          setState(() {
                            pageController.animateToPage(2,
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.fastOutSlowIn);
                          });
                        },
                      )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
