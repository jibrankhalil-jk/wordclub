import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/models/database_main_model.dart';
import 'package:wordclub/others/constants.dart';

class Result extends StatelessWidget {
  Result({required this.all, required this.wrong});
  List<QuizMainModel> wrong, all;

  @override
  Widget build(BuildContext context) {
    // correct.removeWhere((element) => wrong.contains(element));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(
            horizontal: 20, vertical: MediaQuery.of(context).size.height / 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cstmbutton(MediaQuery.of(context).size.width / 6,
                    '${all.length}', 'Total'),
                cstmbutton(MediaQuery.of(context).size.width / 5,
                    '${all.length - wrong.length}', 'Correct'),
                cstmbutton(MediaQuery.of(context).size.width / 6,
                    '${wrong.length}', 'Wrong'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Resultview(
                                  all: all,
                                  wrong: wrong,
                                )));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
                    child: Text(
                      'See Results',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: AppPrimaryColor,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: AppPrimaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  cstmbutton(buttonsize, string, bottom) {
    return Column(
      children: [
        Container(
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
                  '$string',
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
        SizedBox(
          height: 5,
        ),
        Text('$bottom')
      ],
    );
  }
}

class Resultview extends StatefulWidget {
  Resultview({required this.all, required this.wrong});
  List<QuizMainModel> wrong, all;

  @override
  State<Resultview> createState() => _ResultviewState(all: all, wrong: wrong);
}

class _ResultviewState extends State<Resultview> {
  _ResultviewState({required this.all, required this.wrong});
  List<QuizMainModel> wrong, all;
  List<QuizMainModel> correct = [];
  int current_tab = 0;
  var pagecntrl = PageController();

  @override
  Widget build(BuildContext context) {
    correct = all;
    correct.removeWhere((element) => wrong.contains(element));

    log(correct.length.toString());
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<GlobalCubit, GlobalState>(
                builder: (context, state) {
                  return CupertinoSlidingSegmentedControl(
                    children: {
                      0: Text('Correct'.i18n()),
                      1: Text('Wrong'.i18n()),
                    },
                    onValueChanged: (value) {
                      setState(() {
                        current_tab = value!;
                        pagecntrl.jumpToPage(value);
                      });
                    },
                    groupValue: current_tab,
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: pagecntrl,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListView.builder(
                    itemCount: correct.length,
                    itemBuilder: (context, correctindex) => Padding(
                          padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                          child: Text(correct[correctindex].word),
                        )),
                ListView.builder(
                    itemCount: wrong.length + 1,
                    itemBuilder: (context, index) {
                      return index == wrong.length
                          ? MaterialButton(
                              child: Text('Add All to Bookmarks'),
                              onPressed: () {
                                BlocProvider.of<GlobalCubit>(context)
                                    .updatebookmarks(wrong);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            )
                          : Padding(
                              padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                              child: Text('${index + 1}. ' + wrong[index].word),
                            );
                    }),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
