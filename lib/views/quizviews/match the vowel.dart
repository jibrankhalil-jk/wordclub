import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/others/constants.dart';
import 'package:localization/localization.dart';

class Match_The_Vowel extends StatelessWidget {
  Match_The_Vowel({this.bundletype, this.quiztype});
  var bundletype, quiztype;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalCubit(),
      child: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Are you sure want to exit?'.i18n()),
                      actions: [
                        ElevatedButton(
                            onPressed: () {}, child: Text('Resume'.i18n())),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text('Quit'.i18n())),
                      ],
                    );
                  });
              return Future.value(false);
            },
            child: Scaffold(
                body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SvgPicture.asset(
                          AppAssets().background_illustration)),
                  SafeArea(
                      child: Column(
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '1/10',
                                style: TextStyle(color: Colors.white),
                              ),
                              Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width / 1.7,
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.white,
                                  color: Colors.orange,
                                  value: 0.7,
                                ),
                              ),
                              SvgPicture.asset(AppAssets().close_square)
                            ]),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(19),
                                bottomLeft: Radius.circular(19))),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 7,
                              ),
                              Stack(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Column(
                                          children: [
                                            Text('Pronunciation'.i18n()),
                                            Text(
                                              '/Blay-zr/',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 9,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7,
                                              width: double.infinity,
                                              child: ListView.builder(
                                                  // itemCount: 8,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            7,
                                                        child: Center(
                                                            child: Text(
                                                          'A',
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  17,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<GlobalCubit>(context)
                                            .speak_with_tts('Blayzr ');
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        child: Center(
                                            child: SvgPicture.asset(
                                          AppAssets().volume,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              18,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              18,
                                        )),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(300)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 7.6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Bottom_Button(context, 'Defination', () {}),
                                  Bottom_Button(context, 'Origin', () {}),
                                  Bottom_Button(context, 'Sentence', () {}),
                                  Bottom_Button(
                                      context, 'Part of Speech', () {}),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    height:
                                        MediaQuery.of(context).size.width / 7,
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    child: ListView.builder(
                                        itemCount: 3,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7,
                                              child: Center(
                                                  child: Text(
                                                'A',
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            17,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              )),
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                            ),
                                          );
                                        }),
                                  ),
                                  Spacer(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 7,
                                    height:
                                        MediaQuery.of(context).size.width / 7,
                                    child: Center(
                                      child: SvgPicture.asset(AppAssets().play),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            )),
          );
        },
      ),
    );
  }

  Bottom_Button(context, Title, onpressed) {
    var buttonsize = MediaQuery.of(context).size.width / 6;
    return GestureDetector(
      onTap: () {
        onpressed();
      },
      child: Container(
        height: buttonsize,
        width: buttonsize,
        child: Stack(
          // alignment: AlignmentGeometry,
          children: [
            SvgPicture.asset(
              AppAssets().bottom_buttons,
              height: buttonsize,
              width: buttonsize,
            ),
            Center(
              child: Text(
                '$Title'.i18n(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: buttonsize / 6.5,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}