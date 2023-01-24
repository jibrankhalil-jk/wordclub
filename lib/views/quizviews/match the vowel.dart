import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/models/database_main_model.dart';
import 'package:wordclub/others/constants.dart';
import 'package:localization/localization.dart';

class Match_The_Vowel extends StatefulWidget {
  Match_The_Vowel({this.bundletype, this.quiztype});
  var bundletype, quiztype;

  @override
  State<Match_The_Vowel> createState() => _Match_The_VowelState();
}

class _Match_The_VowelState extends State<Match_The_Vowel> {
  List<QuizMainModel> QuizList = [];
  List<QuizMainModel> WrongList = [];

  int quiz_completed_status = 0;
  // var myindex = 1;
  var answercntrl = TextEditingController();
  var pagecntrl = PageController(initialPage: 0);
  var current_blankselected = null;
  var current_selected_vovel = '_';
  var wordexpen = null;
  var final_answer = null;

  @override
  Widget build(BuildContext context) {
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
                                      if (ismultipleoffive(mainindex)) {
                                        BlocProvider.of<GlobalCubit>(context)
                                            .showfulladd();
                                      }
                                      // log('is 6 :${ismultipleoffive(6)}');

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
                                                            QuizList[mainindex]
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
                                                              var length = QuizList[
                                                                      mainindex]
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
                                                                        itemCount: QuizList[mainindex]
                                                                            .word
                                                                            .length,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        itemBuilder:
                                                                            (context,
                                                                                subindex) {
                                                                          if (wordexpen ==
                                                                              null) {
                                                                            wordexpen =
                                                                                QuizList[mainindex == 0 ? mainindex : pagecntrl.page!.toInt()].word.replaceAll(RegExp('[aeiou]'), '_').split('');
                                                                          }
                                                                          if (current_blankselected ==
                                                                              subindex) {
                                                                            wordexpen[subindex] =
                                                                                current_selected_vovel;
                                                                          }
                                                                          final_answer =
                                                                              wordexpen.toString();
                                                                          log(wordexpen
                                                                              .toString());

                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 2),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  if (wordexpen[subindex].toString() == '_') {
                                                                                    current_blankselected = subindex;
                                                                                  }
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                width: size,
                                                                                // ignore: sort_child_properties_last
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  wordexpen[subindex].toString(),
                                                                                  // 'a',
                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width / 17, color: Colors.white, fontWeight: FontWeight.w500),
                                                                                  textAlign: TextAlign.center,
                                                                                )),
                                                                                decoration: BoxDecoration(
                                                                                    color: wordexpen[subindex].toString() == '_'
                                                                                        ? current_blankselected == subindex
                                                                                            ? Colors.blue
                                                                                            : Colors.grey
                                                                                        : Colors.green,
                                                                                    borderRadius: BorderRadius.circular(6)),
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
                                            Row(
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 20),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      7,
                                                  // width: double.infinity,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.7,
                                                  child: ListView.builder(
                                                      itemCount: 4,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder: (context,
                                                          vowelindex) {
                                                        return InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          onTap: () {
                                                            // log(vowelindex
                                                            //     .toString());
                                                            setState(() {
                                                              if (vowelindex ==
                                                                  0) {
                                                                current_selected_vovel =
                                                                    'A';
                                                              } else if (vowelindex ==
                                                                  1) {
                                                                current_selected_vovel =
                                                                    'E';
                                                              } else if (vowelindex ==
                                                                  2) {
                                                                current_selected_vovel =
                                                                    'I';
                                                              } else if (vowelindex ==
                                                                  3) {
                                                                current_selected_vovel =
                                                                    'O';
                                                              } else if (vowelindex ==
                                                                  4) {
                                                                current_selected_vovel =
                                                                    'U';
                                                              } else {
                                                                current_selected_vovel =
                                                                    '_';
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 2),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                7,
                                                            child: Center(
                                                                child: Text(
                                                              vowelindex == 0
                                                                  ? 'A'
                                                                  : vowelindex ==
                                                                          1
                                                                      ? 'E'
                                                                      : vowelindex ==
                                                                              2
                                                                          ? 'I'
                                                                          : vowelindex == 3
                                                                              ? 'O'
                                                                              : 'U',
                                                              style: TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      17,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                                Spacer(),
                                                InkWell(
                                                  onTap: () async {
                                                    if (final_answer
                                                            .toString()
                                                            .contains('_') ==
                                                        false) {
                                                      if (final_answer
                                                              .toString()
                                                              .replaceAll(
                                                                  ' ', '')
                                                              .replaceAll(
                                                                  ',', '')
                                                              .replaceAll(
                                                                  '[', '')
                                                              .replaceAll(
                                                                  ']', '')
                                                              .toLowerCase() ==
                                                          QuizList[pagecntrl
                                                                  .page!
                                                                  .toInt()]
                                                              .word
                                                              .toLowerCase()) {
                                                        log('correct');
                                                        showDialog(
                                                            barrierDismissible:
                                                                false,
                                                            context: context,
                                                            builder: (context) {
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
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      } else {
                                                        log('Incorrect');
                                                        await BlocProvider.of<
                                                                    GlobalCubit>(
                                                                context)
                                                            .play_tick_sound();
                                                        showDialog(
                                                            barrierDismissible:
                                                                false,
                                                            context: context,
                                                            builder: (context) {
                                                              return WillPopScope(
                                                                onWillPop: () =>
                                                                    Future.value(
                                                                        false),
                                                                child:
                                                                    AlertDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  content: Text(
                                                                    "That was incorrect.\nThe correct answer was ${QuizList[pagecntrl.page!.toInt()].word}.\n${answercntrl.text.isEmpty == true ? 'Your answer was empty' : ''}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  actions: [
                                                                    MaterialButton(
                                                                        color: Colors
                                                                            .red,
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            if (quiz_completed_status <
                                                                                QuizList.length) {
                                                                              quiz_completed_status++;
                                                                              WrongList.add(QuizList[mainindex]);
                                                                            }
                                                                            wordexpen =
                                                                                null;
                                                                            current_blankselected =
                                                                                null;
                                                                            final_answer =
                                                                                null;
                                                                            Navigator.pop(context);

                                                                            if (quiz_completed_status <
                                                                                QuizList.length) {
                                                                              pagecntrl.jumpToPage(mainindex + 1);
                                                                            }
                                                                          });
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
                                                      }
                                                      Timer.periodic(
                                                          Duration(
                                                              milliseconds:
                                                                  800),
                                                          (timer) {
                                                        timer.cancel();

                                                        if (final_answer
                                                                .toString()
                                                                .replaceAll(
                                                                    ' ', '')
                                                                .replaceAll(
                                                                    ',', '')
                                                                .replaceAll(
                                                                    '[', '')
                                                                .replaceAll(
                                                                    ']', '')
                                                                .toLowerCase() ==
                                                            QuizList[mainindex]
                                                                .word
                                                                .toLowerCase()) {
                                                          setState(() {
                                                            if (quiz_completed_status <
                                                                QuizList
                                                                    .length) {
                                                              quiz_completed_status++;
                                                            }
                                                            current_blankselected =
                                                                null;
                                                            current_selected_vovel =
                                                                '_';
                                                            wordexpen = null;
                                                            final_answer = null;
                                                            Navigator.pop(
                                                                context);

                                                            if (quiz_completed_status <
                                                                QuizList
                                                                    .length) {
                                                              pagecntrl
                                                                  .jumpToPage(
                                                                      mainindex +
                                                                          1);
                                                            }
                                                          });
                                                        }
                                                      });
                                                      log(final_answer
                                                          .toString()
                                                          .replaceAll(' ', '')
                                                          .replaceAll(',', '')
                                                          .replaceAll('[', '')
                                                          .replaceAll(']', '')
                                                          .toLowerCase());
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 20),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            7,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            7,
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                          AppAssets().play),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16)),
                                                  ),
                                                ),
                                              ],
                                            ),
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

  ismultipleoffive(n) {
    while (n > 0) n = n - 5;

    if (n == 0) return true;

    return false;
  }
}
