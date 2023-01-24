import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/main.dart';
import 'package:wordclub/models/database_main_model.dart';
import 'package:wordclub/others/constants.dart';
import 'package:localization/localization.dart';
import 'package:wordclub/widgets/result.dart';

class Fill_In_TheBlanks extends StatefulWidget {
  Fill_In_TheBlanks({this.bundletype, this.quiztype});
  var bundletype, quiztype;

  @override
  State<Fill_In_TheBlanks> createState() => _Fill_In_TheBlanksState();
}

class _Fill_In_TheBlanksState extends State<Fill_In_TheBlanks> {
  List<QuizMainModel> QuizList = [];
  int quiz_completed_status = 0;
  List? indexword;
  var answercntrl = TextEditingController();
  var pagecntrl = PageController(initialPage: 0);
  List? final_answer;
  var tectcntrl = TextEditingController();

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
                                    itemBuilder: (context, mainindex) {
                                      return SingleChildScrollView(
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
                                                            QuizList[mainindex ==
                                                                        0
                                                                    ? mainindex
                                                                    : pagecntrl
                                                                        .page!
                                                                        .toInt()]
                                                                .word,
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
                                                          BlocBuilder<
                                                              GlobalCubit,
                                                              GlobalState>(
                                                            builder: (context,
                                                                state) {
                                                              var length = QuizList[mainindex ==
                                                                          0
                                                                      ? mainindex
                                                                      : pagecntrl
                                                                          .page!
                                                                          .toInt()]
                                                                  .word
                                                                  .length;
                                                              var size = length <=
                                                                      6
                                                                  ? MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      8
                                                                  : length == 7
                                                                      ? MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          9.5
                                                                      : length ==
                                                                              8
                                                                          ? MediaQuery.of(context).size.width /
                                                                              10.5
                                                                          : length == 9
                                                                              ? MediaQuery.of(context).size.width / 12
                                                                              : length == 10
                                                                                  ? MediaQuery.of(context).size.width / 13.5
                                                                                  : length == 11
                                                                                      ? MediaQuery.of(context).size.width / 14.8
                                                                                      : MediaQuery.of(context).size.width / 8;

                                                              return Container(
                                                                height: size,
                                                                width: double
                                                                    .infinity,
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount:
                                                                            length,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        itemBuilder:
                                                                            (context,
                                                                                subindex) {
                                                                          if (indexword ==
                                                                              null) {
                                                                            indexword = mainindex == 0
                                                                                ? QuizList[mainindex == 0 ? mainindex : pagecntrl.page!.toInt()].word.split('')
                                                                                : QuizList[mainindex == 0 ? mainindex : pagecntrl.page!.toInt()].word.split('');
                                                                            if (length <=
                                                                                5) {
                                                                              indexword![Random().nextInt(length)] = '_';
                                                                              indexword![Random().nextInt(length)] = '_';
                                                                            } else if (length >
                                                                                6) {
                                                                              indexword![Random().nextInt(length)] = '_';
                                                                              indexword![Random().nextInt(length)] = '_';
                                                                              indexword![Random().nextInt(length)] = '_';
                                                                            }
                                                                          }
                                                                          if (final_answer ==
                                                                              null) {
                                                                            final_answer =
                                                                                indexword;
                                                                          }

                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 2),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {},
                                                                              child: Container(
                                                                                width: size,
                                                                                // ignore: sort_child_properties_last
                                                                                child: Center(
                                                                                    child: indexword![subindex] == '_'
                                                                                        ? CupertinoTextField(
                                                                                            onChanged: (value) {
                                                                                              final_answer![subindex] = value;
                                                                                            },
                                                                                            maxLength: 1,
                                                                                            padding: EdgeInsets.all(size / 3),
                                                                                          )
                                                                                        : Text(
                                                                                            indexword![subindex].toString(),
                                                                                            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 17, color: Colors.white, fontWeight: FontWeight.w500),
                                                                                            textAlign: TextAlign.center,
                                                                                          )),
                                                                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(6)),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                              );
                                                            },
                                                          ),
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
                                                        QuizList[mainindex]
                                                            .word,
                                                      );
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
                                                      detail:
                                                          QuizList[mainindex]
                                                              .defination);
                                                }),
                                                Bottom_Button(context, 'Origin',
                                                    () {
                                                  dialog(
                                                      title: 'Origin',
                                                      detail:
                                                          QuizList[mainindex]
                                                              .origin);
                                                }),
                                                Bottom_Button(
                                                    context, 'Sentence', () {
                                                  dialog(
                                                      title: 'Sentence',
                                                      detail: QuizList[
                                                              mainindex]
                                                          .sentence
                                                          .replaceAll(
                                                              QuizList[
                                                                      mainindex]
                                                                  .word,
                                                              '____'));
                                                }),
                                                Bottom_Button(
                                                    context, 'Part of Speech',
                                                    () {
                                                  dialog(
                                                      title: 'Part of Speech',
                                                      detail:
                                                          QuizList[mainindex]
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
                                                    onPressed: () async {
                                                      if (final_answer
                                                              .toString()
                                                              .replaceAll(
                                                                  ',', '')
                                                              .replaceAll(
                                                                  '[', '')
                                                              .replaceAll(
                                                                  ']', '')
                                                              .replaceAll(
                                                                  ' ', '')
                                                              .contains('_') ==
                                                          false) {
                                                        if (final_answer
                                                                .toString()
                                                                .replaceAll(
                                                                    ',', '')
                                                                .replaceAll(
                                                                    '[', '')
                                                                .replaceAll(
                                                                    ']', '')
                                                                .replaceAll(
                                                                    ' ', '')
                                                                .toUpperCase() ==
                                                            QuizList[mainindex ==
                                                                        0
                                                                    ? mainindex
                                                                    : pagecntrl
                                                                        .page!
                                                                        .toInt()]
                                                                .word
                                                                .toUpperCase()) {
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
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Correct',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          color:
                                                                              Colors.green),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                        } else {
                                                          await BlocProvider.of<
                                                                      GlobalCubit>(
                                                                  context)
                                                              .play_tick_sound();
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
                                                                            .white,
                                                                    content:
                                                                        Text(
                                                                      "That was incorrect.\nThe correct answer was  .\n${answercntrl.text.isEmpty == true ? 'Your answer was empty' : ''}",
                                                                      // "That was incorrect.\nThe correct answer was ${QuizList[index].word}.\n${answercntrl.text.isEmpty == true ? 'Your answer was empty' : ''}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    actions: [
                                                                      MaterialButton(
                                                                          color: Colors
                                                                              .red,
                                                                          onPressed:
                                                                              () {
                                                                            // setState(
                                                                            //     () {
                                                                            //   if (quiz_completed_status <=
                                                                            //       QuizList.length) {
                                                                            //     quiz_completed_status++;
                                                                            //   }
                                                                            //   Navigator.pop(context);
                                                                            //   answercntrl.clear();
                                                                            //   pagecntrl.jumpToPage(index +
                                                                            //       1);
                                                                            // WrongList.add(QuizList.)
                                                                            // });}
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'ok',
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                );
                                                              });

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
                                                                          fontSize:
                                                                              25,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    content:
                                                                        Text(
                                                                      QuizList[
                                                                              mainindex]
                                                                          .word,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          color:
                                                                              Colors.white),
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
                                                            final_answer = null;
                                                            pagecntrl
                                                                .jumpToPage(
                                                                    mainindex +
                                                                        1);
                                                            if (quiz_completed_status <=
                                                                QuizList
                                                                    .length) {
                                                              quiz_completed_status++;
                                                            }
                                                            Navigator.pop(
                                                                context);
                                                            pagecntrl
                                                                .jumpToPage(
                                                                    mainindex +
                                                                        1);
                                                          });
                                                        });
                                                      }
                                                      print(final_answer
                                                          .toString()
                                                          .replaceAll(',', '')
                                                          .replaceAll('[', '')
                                                          .replaceAll(']', '')
                                                          .replaceAll(' ', ''));
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
