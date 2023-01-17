import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/models/database_main_model.dart';
import 'package:wordclub/others/constants.dart';
import 'package:localization/localization.dart';

class Multiple_Choices extends StatefulWidget {
  Multiple_Choices({this.bundletype, this.quiztype});
  var bundletype, quiztype;

  @override
  State<Multiple_Choices> createState() => _Multiple_ChoicesState();
}

class _Multiple_ChoicesState extends State<Multiple_Choices> {
  List<QuizMainModel> QuizList = [];

  int quiz_completed_status = 1;
  var myindex = 1;
  var pageviewcntrl = PageController();
  bool checked = false;
  int optchosed = 0;
  @override
  Widget build(BuildContext context) {
    checkoption(index, button) {
      optchosed = button;

      if (index != QuizList.length) {
        if (checked == false) {
          setState(() {
            checked = true;
          });
          Timer.periodic(Duration(seconds: 1), (timer) {
            timer.cancel();
            setState(() {
              quiz_completed_status++;
              pageviewcntrl.jumpToPage((index + 1));
              checked = false;
              optchosed = 0;
            });
          });
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text('Finished')));
      }
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
                                                                  color: Colors
                                                                      .blue),
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
                                                                  color: Colors
                                                                      .red),
                                                            )),
                                                      ],
                                                    );
                                                  });
                                            },
                                            borderRadius:
                                                BorderRadius.circular(9),
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
                                        controller: pageviewcntrl,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: QuizList.length,
                                        itemBuilder: (context, index) {
                                          return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      10,
                                                ),
                                                Center(
                                                  child: Text(
                                                    QuizList[index].word,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 19),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    QuizList[index]
                                                        .pronunciation,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 19),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    QuizList[index]
                                                        .multiplechoices
                                                        .Mcq_Question,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17),
                                                  ),
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
                                                      horizontal: 20,
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(18.0),
                                                        child: Column(
                                                          children: [
                                                            MaterialButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                color: checked ==
                                                                        true
                                                                    ? optchosed ==
                                                                            1
                                                                        ? QuizList[index].Matchword.Mw_CorrectAnswer ==
                                                                                '1'
                                                                            ? Colors
                                                                                .green
                                                                            : Colors
                                                                                .red
                                                                        : QuizList[index].Matchword.Mw_CorrectAnswer ==
                                                                                '1'
                                                                            ? Colors
                                                                                .green
                                                                            : Colors
                                                                                .grey
                                                                    : Colors
                                                                        .grey,
                                                                onPressed: () {
                                                                  checkoption(
                                                                      index, 1);
                                                                },
                                                                child: Container(
                                                                     margin: EdgeInsets.symmetric(vertical: 13),
                                                                    width: MediaQuery.of(context).size.width / 1.4,
                                                                    child: Center(
                                                                        child: Text(
                                                                      // 'Option 1',
                                                                      QuizList[
                                                                              index]
                                                                          .multiplechoices
                                                                          .Mcq_Option_A,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )))),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            MaterialButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                color: checked ==
                                                                        true
                                                                    ? optchosed ==
                                                                            2
                                                                        ? QuizList[index].Matchword.Mw_CorrectAnswer ==
                                                                                '2'
                                                                            ? Colors
                                                                                .green
                                                                            : Colors
                                                                                .red
                                                                        : QuizList[index].Matchword.Mw_CorrectAnswer ==
                                                                                '2'
                                                                            ? Colors
                                                                                .green
                                                                            : Colors
                                                                                .grey
                                                                    : Colors
                                                                        .grey,
                                                                onPressed: () {
                                                                  checkoption(
                                                                      index, 2);
                                                                },
                                                                child: Container(
                                                                    margin: EdgeInsets.symmetric(vertical: 13),
                                                                    width: MediaQuery.of(context).size.width / 1.4,
                                                                    child: Center(
                                                                        child: Text(
                                                                      // 'Option 2',
                                                                      QuizList[
                                                                              index]
                                                                          .multiplechoices
                                                                          .Mcq_Option_B,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )))),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            MaterialButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                color: checked ==
                                                                        true
                                                                    ? optchosed ==
                                                                            3
                                                                        ? QuizList[index].Matchword.Mw_CorrectAnswer ==
                                                                                '3'
                                                                            ? Colors
                                                                                .green
                                                                            : Colors
                                                                                .red
                                                                        : QuizList[index].Matchword.Mw_CorrectAnswer ==
                                                                                '3'
                                                                            ? Colors
                                                                                .green
                                                                            : Colors
                                                                                .grey
                                                                    : Colors
                                                                        .grey,
                                                                onPressed: () {
                                                                  checkoption(
                                                                      index, 3);
                                                                },
                                                                child: Container(
                                                                    margin: EdgeInsets.symmetric(vertical: 13),
                                                                    width: MediaQuery.of(context).size.width / 1.4,
                                                                    child: Center(
                                                                        child: Text(
                                                                      // 'Option 3',
                                                                      QuizList[
                                                                              index]
                                                                          .multiplechoices
                                                                          .Mcq_Option_C,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )))),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            MaterialButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                color: checked ==
                                                                        true
                                                                    ? optchosed ==
                                                                            4
                                                                        ? QuizList[index].Matchword.Mw_CorrectAnswer ==
                                                                                '4'
                                                                            ? Colors
                                                                                .green
                                                                            : Colors
                                                                                .red
                                                                        : QuizList[index].Matchword.Mw_CorrectAnswer ==
                                                                                '4'
                                                                            ? Colors
                                                                                .green
                                                                            : Colors
                                                                                .grey
                                                                    : Colors
                                                                        .grey,
                                                                onPressed: () {
                                                                  checkoption(
                                                                      index, 4);
                                                                },
                                                                child: Container(
                                                                    margin: EdgeInsets.symmetric(vertical: 13),
                                                                    width: MediaQuery.of(context).size.width / 1.4,
                                                                    child: Center(
                                                                        child: Text(
                                                                      // 'Option D',
                                                                      QuizList[
                                                                              index]
                                                                          .multiplechoices
                                                                          .Mcq_Option_D,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )))),
                                                          ],
                                                        )),
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
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                  child: CupertinoActivityIndicator());
                            }
                          }))
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
