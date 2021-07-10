import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  final String title;
  final String img;
  final String body;

  OnBoardingModel({this.title, this.img, this.body});
}


class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  bool isFinished = false;

  var pageController = PageController();

  final pageViewController = PageController(initialPage: 0);

  List<OnBoardingModel> onBoardingContent = [
    OnBoardingModel(
        title: 'Title 1', body: 'Body 1', img: 'assets/imgs/img1.png'),
    OnBoardingModel(
        title: 'Title 2', body: 'Body 2', img: 'assets/imgs/img2.png'),
    OnBoardingModel(
        title: 'Title 3', body: 'Body 3', img: 'assets/imgs/img3.png'),
  ];

  void submit() {
    CacheHelper.saveData(
      key: 'isBoarding',
      value: true,
    ).then((value)
    {
      if (value) {
        navigateAndFinish(
          context,
         LoginScreen(),
        );
      }
    }).catchError((error){print({'error is here ${error.toString()}'});});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: submit,
                    child: Text(
                      'skip',
                      style: TextStyle(
                        fontFamily: 'Janna-Bold',
                        fontSize: 17.0,
                        color: defaultColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == onBoardingContent.length - 1) {
                      isFinished = true;
                    } else {
                      isFinished = false;
                    }
                  },
                  controller: pageController,
                  physics: BouncingScrollPhysics(),
                  itemCount: onBoardingContent.length,
                  itemBuilder: (context, index) => viewBuilder(onBoardingContent[index])
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  bottom: 20.0, start: 20.0, end: 20.0),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      expansionFactor: 4.0, // المسافات ما بين النقاط
                      dotWidth: 10.0,
                      spacing: 5.0,
                      activeDotColor: defaultColor,
                    ),
                    controller: pageController,
                    count: onBoardingContent.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: defaultColor,
                    onPressed: (){
                      if(isFinished){
                        submit();
                      }else{
                        pageController.nextPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.linearToEaseOut
                        );
                      }
                    },
                    child: Icon(Icons.arrow_forward_outlined),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget viewBuilder(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              width: double.infinity,
              image: AssetImage(
                '${model.img}',
              ),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                bottom: 20.0, start: 20.0, end: 20.0),
            child: Text(
              '${model.title}',
              style: TextStyle(
                  fontFamily: 'Janna-Bold',
                  fontSize: 50.0,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                bottom: 20.0, start: 20.0, end: 20.0),
            child: Text(
              '${model.body}',
              style: TextStyle(
                  fontFamily: 'Janna-Bold',
                  fontSize: 30.0,
                  color: Colors.black),
            ),
          ),
        ],
      );
}
