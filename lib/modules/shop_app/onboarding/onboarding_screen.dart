import 'package:flutter/material.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/network/local/cashe_helper.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/shop_login_screen.dart';
class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding=[
    BoardingModel(
      image: 'assets/images/doc1.png',
      title: 'FIND YOUR OWN DOCTOR',
      body: 'Looking for Your Doctor board and remember your doctor Code from it.',
    ),
    BoardingModel(
      image: 'assets/images/time.png',
      title: 'SELECT TIME SLOT',
      body: 'View all available Time Slots Of Your Own Doctor and Book from those.',
    ),
    BoardingModel(
      image: 'assets/images/call.png',
      title: 'MAKE VIDEO CALL',
      body: 'Get Ready. Your Own Doctor Will start video call you at booked Time Slot.',
    ),
  ];

  var boardController=PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: submit,
              text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller:boardController,
                onPageChanged: (int index){
                  if(index == boarding.length-1){
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    isLast=false;
                  }
                },
                physics: const BouncingScrollPhysics(),
                  itemBuilder:(context, index)=> buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 3,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: defaultColor,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        submit();
                      }else{
                        boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 850,
                          ),
                          curve:
                          Curves.fastOutSlowIn,
                        );
                      }
                    },
                  child: const Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void submit(){
    CasheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if(value){
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(
            model.image
          ),
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
    ],
  );
}

