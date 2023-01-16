import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/models/database_main_model.dart';
import 'package:wordclub/others/constants.dart';
import 'package:localization/localization.dart';

class Flash_cards extends StatefulWidget {
  Flash_cards({this.bundletype, this.quiztype});
  var bundletype, quiztype;

  @override
  State<Flash_cards> createState() => _Flash_cardsState();
}

class _Flash_cardsState extends State<Flash_cards> {
  List<QuizMainModel> QuizList = [];
  List<QuizMainModel> CompletedQuizList = [];
  int quiz_completed_status = 1;
  var myindex = 1;

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
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: FutureBuilder(
                          future: BlocProvider.of<GlobalCubit>(context)
                              .Fetch_Table_Data(table: widget.bundletype),
                          builder: (context, AsyncSnapshot datasnap) {
                            if (datasnap.hasData) {
                              if (QuizList.isEmpty) {
                                QuizList = datasnap.data;
                                QuizList.shuffle();
                              }
                              return Column(
                                children: [
                                  Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '$quiz_completed_status/${QuizList.length}',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Container(
                                            height: 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.7,
                                            child: LinearPercentIndicator(
                                              // width: 100.0,
                                              lineHeight: double.infinity,
                                              percent: double.parse(
                                                  '${(quiz_completed_status / QuizList.length) * 1}'),
                                              progressColor: Colors.blue,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                              AppAssets().close_square)
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
                                        physics: ClampingScrollPhysics(),
                                        onPageChanged: ((value) {
                                          setState(() {
                                            if (quiz_completed_status !=
                                                QuizList.length) {
                                              if (myindex == value - 1) {
                                                myindex = value;
                                              }
                                              if (value == 0 &&
                                                  quiz_completed_status ==
                                                      myindex - 1) {
                                                quiz_completed_status =
                                                    (myindex + 1) + 1;
                                              } else {
                                                quiz_completed_status =
                                                    myindex + 1;
                                              }
                                            }

                                            // CompletedQuizList.add(value);
                                            // if (myindex == value) {
                                            //   quiz_completed_status =
                                            //       quiz_completed_status + 1;

                                            //   myindex == QuizList.length
                                            //       ? quiz_completed_status = 3
                                            //       : null;
                                            // }

                                            log('value $value');
                                            log('MyIndex $myindex');
                                            log('completed $quiz_completed_status');
                                            // log('MyIndex $myindex');
                                          });
                                        }),
                                        itemCount: datasnap.data.length,
                                        itemBuilder: (context, index) {
                                          return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      14,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    BlocProvider.of<
                                                                GlobalCubit>(
                                                            context)
                                                        .speak_with_tts(
                                                            '${QuizList[index].word}');
                                                  },
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    child: Center(
                                                        child: SvgPicture.asset(
                                                      AppAssets().volume,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              9,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              9,
                                                    )),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.black),
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(300)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  '${QuizList[index].word}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 19),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${QuizList[index].pronunciation}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 19),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      14,
                                                ),
                                                Container(
                                                  // height: MediaQuery.of(context).size.height / 4,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Origin'.i18n()),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color: Colors
                                                                  .black12,
                                                            ),
                                                            // height: 40,
                                                            width:
                                                                double.infinity,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  '${QuizList[index].origin}'),
                                                            ),
                                                          ),
                                                          Text('Part of Speech'
                                                              .i18n()),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color: Colors
                                                                  .black12,
                                                            ),
                                                            // height: 40,
                                                            width:
                                                                double.infinity,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  '${QuizList[index].part_of_speech}'),
                                                            ),
                                                          ),
                                                          Text('Defination'
                                                              .i18n()),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color: Colors
                                                                  .black12,
                                                            ),
                                                            // height: 40,
                                                            width:
                                                                double.infinity,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  '${QuizList[index].defination}'),
                                                            ),
                                                          ),
                                                          Text('Sentences'
                                                              .i18n()),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color: Colors
                                                                  .black12,
                                                            ),
                                                            // height: 40,
                                                            width:
                                                                double.infinity,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  '${QuizList[index].sentence}'),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      3,
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              );
                            } else {
                              return Center(
                                  child: CupertinoActivityIndicator());
                            }
                          }),
                    ))
                  ],
                ),
              )));
        },
      ),
    );
  }
}
