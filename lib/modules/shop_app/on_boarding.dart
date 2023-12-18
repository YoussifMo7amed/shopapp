
// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:shopapp/network/local/cache.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login/login.dart';

class BoardingModel {
  String? image;
  String? Title;
  String? Body;
  BoardingModel({required this.image, required this.Title, required this.Body});
}

List<BoardingModel> boarding = [
  BoardingModel(
      image: 'assets/onbording_1.png',
      Title: 'Let Us Shop Now',
      Body: 'Here We go'),
  BoardingModel(
      image: 'assets/onbording_1.png',
      Title: 'We Have Hot Offers',
      Body: 'You must Take A look'),
  BoardingModel(
      image: 'assets/onbording_1.png',
      Title: 'Login Now',
      Body: 'You Are In The Right Place'),
];

class onBoardingSCreen extends StatefulWidget {
  const onBoardingSCreen({super.key});

  @override
  State<onBoardingSCreen> createState() => _onBoardingSCreenState();
}

class _onBoardingSCreenState extends State<onBoardingSCreen> {
  @override
  Widget build(BuildContext context) {
    var controler = PageController();
    bool isLast = false;
    void submit()
    {
      casheHealper.saveData(key: 'onBoarding', value: true).then((value) 
      {
        if(value){
         Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
        }
      }
      );

    }
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: submit,
                child: const Text(
                  'Skip',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int value) {
                  if (value == boarding.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
                controller: controler,
                itemBuilder: (context, index) =>
                    OnBoardingSCreens(boarding[index]),
                itemCount: boarding.length,
              )),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controler,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                        expansionFactor: 3.0,
                        spacing: 5.0,
                        offset: 15,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        strokeWidth: 1.5,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.deepOrange),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: Colors.deepOrange,
                    onPressed: () {
                      if (isLast) {
                       submit();
                        
                      } else {
                        controler.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

Widget OnBoardingSCreens(BoardingModel model) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
       children: [
      Expanded(
        child: Image.asset('${model.image}'),),

      const SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.Title}',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.Body}',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      )
    ]);
