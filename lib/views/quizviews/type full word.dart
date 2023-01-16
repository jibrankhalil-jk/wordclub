import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/others/constants.dart';
import 'package:localization/localization.dart';

import '../../models/database_main_model.dart';

class Type_Full_Word extends StatefulWidget {
  Type_Full_Word({this.bundletype, this.quiztype});
  var bundletype, quiztype;

  @override
  State<Type_Full_Word> createState() => _Type_Full_WordState();
}

class _Type_Full_WordState extends State<Type_Full_Word> {
  List<QuizMainModel> QuizList = [];
  int quiz_completed_status = 0;
  // var myindex = 1;
  var answercntrl = TextEditingController();
  var pagecntrl = PageController();

  dialog({var title, detail}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(detail),
          );
        });
  }

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
                    return CupertinoAlertDialog(
                      content: Text('Are you sure want to exit?'.i18n()),
                      actions: [
                        TextButton(
                            // color: Colors.blue,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Resume'.i18n(),
                              style: TextStyle(color: Colors.blue),
                            )),
                        TextButton(
                            // color: Colors.red,
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Quit'.i18n(),
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                    );
                  });
              return Future.value(false);
            },
            child: FutureBuilder(
                future: BlocProvider.of<GlobalCubit>(context)
                    .Fetch_Table_Data(table: widget.bundletype),
                builder: (context, AsyncSnapshot datasnap) {
                  if (datasnap.hasData) {
                    if (QuizList.isEmpty) {
                      QuizList = datasnap.data;
                      QuizList.shuffle();
                    }

                    return Scaffold(
                        body: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2.2,
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.bottomCenter,
                                ),
                                SvgPicture.asset(
                                    AppAssets().background_illustration),
                              ],
                            ),
                          ),
                          SafeArea(
                              child: Column(
                            children: [
                              Container(
                                // ignore: sort_child_properties_last
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '$quiz_completed_status/${QuizList.length}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        child: LinearPercentIndicator(
                                          // width: 100.0,
                                          lineHeight: double.infinity,
                                          percent: double.parse(
                                              '${(quiz_completed_status / QuizList.length) * 1}'),
                                          // percent: 0.4,
                                          progressColor: Colors.orange,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  content: Text(
                                                      'Are you sure want to exit?'
                                                          .i18n()),
                                                  actions: [
                                                    TextButton(
                                                        // color: Colors.blue,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Resume'.i18n(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        )),
                                                    TextButton(
                                                        // color: Colors.red,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Quit'.i18n(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                  ],
                                                );
                                              });
                                        },
                                        borderRadius: BorderRadius.circular(9),
                                        child: SvgPicture.asset(
                                            AppAssets().close_square),
                                      )
                                    ]),
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(19),
                                        bottomLeft: Radius.circular(19))),
                              ),
                              Expanded(
                                child: PageView.builder(
                                    controller: pagecntrl,
                                    itemCount: datasnap.data.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return SingleChildScrollView(
                                        // dragStartBehavior: DragStartBehavior.start,
                                        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  7,
                                            ),
                                            Stack(
                                              children: [
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  margin: EdgeInsets.fromLTRB(
                                                      20, 20, 20, 0),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Column(
                                                        children: [
                                                          Text('Pronunciation'
                                                              .i18n()),
                                                          Text(
                                                            QuizList[index]
                                                                .pronunciation,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(
                                                            height: 9,
                                                          ),
                                                          TextField(
                                                            controller:
                                                                answercntrl,
                                                          )
                                                        ],
                                                      )),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  top: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  GlobalCubit>(
                                                              context)
                                                          .speak_with_tts(
                                                              QuizList[index]
                                                                  .word);
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              8,
                                                      child: Center(
                                                          child:
                                                              SvgPicture.asset(
                                                        AppAssets().volume,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            18,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            18,
                                                      )),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  Colors.black),
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      300)),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  7.6,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Bottom_Button(
                                                    context, 'Defination', () {
                                                  dialog(
                                                      title: 'Defination',
                                                      detail: QuizList[index]
                                                          .defination);
                                                }),
                                                Bottom_Button(context, 'Origin',
                                                    () {
                                                  dialog(
                                                      title: 'Origin',
                                                      detail: QuizList[index]
                                                          .origin);
                                                }),
                                                Bottom_Button(
                                                    context, 'Sentence', () {
                                                  dialog(
                                                      title: 'Sentence',
                                                      detail: QuizList[index]
                                                          .sentence);
                                                }),
                                                Bottom_Button(
                                                    context, 'Part of Speech',
                                                    () {
                                                  dialog(
                                                      title: 'Part of Speech',
                                                      detail: QuizList[index]
                                                          .part_of_speech);
                                                }),
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  20,
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        1.8,
                                                    right: 30),
                                                width: double.infinity,
                                                height: 59,
                                                child: MaterialButton(
                                                    color: AppPrimaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    onPressed: () {
                                                      if (answercntrl
                                                          .text.isNotEmpty) {
                                                        if (quiz_completed_status <=
                                                                QuizList
                                                                    .length ==
                                                            true) {
                                                          quiz_completed_status +
                                                              1;
                                                        }
                                                        if (answercntrl.text
                                                                .toUpperCase() ==
                                                            QuizList[index]
                                                                .word
                                                                .toUpperCase()) {
                                                          log('correct');
                                                          showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return WillPopScope(
                                                                  onWillPop: () =>
                                                                      Future.value(
                                                                          false),
                                                                  child:
                                                                      AlertDialog(
                                                                    title: Text(
                                                                      'Correct',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              25,
                                                                          color:
                                                                              Colors.green),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                        } else {
                                                          log('Incorrect');
                                                          showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return WillPopScope(
                                                                  onWillPop: () =>
                                                                      Future.value(
                                                                          false),
                                                                  child:
                                                                      AlertDialog(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    title: Text(
                                                                      'Incorrect',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              25,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    content:
                                                                        Text(
                                                                      QuizList[
                                                                              index]
                                                                          .word,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              25,
                                                                          color:
                                                                              Colors.green),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                        }

                                                        Timer.periodic(
                                                            Duration(
                                                                seconds: 2),
                                                            (timer) {
                                                          timer.cancel();

                                                          setState(() {
                                                            if (quiz_completed_status <=
                                                                QuizList
                                                                    .length) {
                                                              quiz_completed_status++;
                                                            }
                                                            Navigator.pop(
                                                                context);
                                                            pagecntrl
                                                                .jumpToPage(
                                                                    index + 1);
                                                          });
                                                        });
                                                        log(quiz_completed_status
                                                            .toString());
                                                        log(QuizList.length
                                                            .toString());
                                                      }
                                                    },
                                                    child: Text(
                                                      'Submit'.i18n(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ))),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  10,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ));
                  } else {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                }),
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
      child: SizedBox(
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
