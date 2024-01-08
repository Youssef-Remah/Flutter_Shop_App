import 'package:flutter/material.dart';
import 'package:shop_app/models/on_boarding_model.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<OnBoardingModel> onBoardings = 
  [
    OnBoardingModel(imagePath: 'lib/assets/images/purchase_online.png', imageTitle: 'Purchase Online'),
    OnBoardingModel(imagePath: 'lib/assets/images/track_order.png', imageTitle: 'Track Your Order'),
    OnBoardingModel(imagePath: 'lib/assets/images/get_your_order.png', imageTitle: 'Get Your Order'),
  ];

  PageController onBoardingController = PageController();

  void submit()
  {

    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value)
      {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute (builder: (BuildContext context) => const ShopLoginScreen()),
                (route) => false
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions:
        [
          TextButton(
              onPressed: submit,
              child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
              ),
          )
        ],
      ),
      body: SizedBox(
        height: screenHeight,
        child: Column(
          children:
          [
            SizedBox(
              height: screenHeight * 0.7,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => buildOnBoardingItem(OnBoardingModel: onBoardings[index]),
                itemCount: onBoardings.length,
                controller: onBoardingController,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                   SmoothPageIndicator(
                       controller: onBoardingController,
                       count: onBoardings.length,
                       effect: ExpandingDotsEffect(
                         activeDotColor: Colors.blue,
                         dotHeight: 10.0,
                         dotWidth: 13.0,
                         spacing: 5.0,
                       ),
                   ),

                  TextButton(
                      onPressed: ()
                      {
                        onBoardingController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                        );

                        var pageIndex = onBoardingController.page;

                        if( (pageIndex != null) && (pageIndex.round() == onBoardings.length-1) )
                        {
                          submit();
                        }

                      },
                      child: const Text(
                          'next',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem
      ({
          required OnBoardingModel,
      }) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children:
          [
            Image(image: AssetImage(OnBoardingModel.imagePath)),

            SizedBox(height: 30.0,),

            Text(
              OnBoardingModel.imageTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
  );
  }
}
