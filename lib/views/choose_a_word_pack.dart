import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:wordclub/others/constants.dart';
import 'package:wordclub/views/quizviews/flash_cards.dart';

class Choose_a_word_pack extends StatefulWidget {
  Choose_a_word_pack(this.type, this.quiztype);
  var type, quiztype;

  @override
  State<Choose_a_word_pack> createState() =>
      _Choose_a_word_packState(type, quiztype);
}

class _Choose_a_word_packState extends State<Choose_a_word_pack> {
  _Choose_a_word_packState(this.type, this.quiztype);
  var type, quiztype;

  var current_tab = 0;
  @override
  Widget build(BuildContext context) {
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
              child: SvgPicture.asset(AppAssets().background_illustration)),
          SafeArea(
              child: Center(
                  child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Text(
                    'Chose a word pack'.i18n(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CupertinoSlidingSegmentedControl(
                  children: {
                    0: Text('All Bundles'.i18n()),
                    1: Text('Level one'.i18n()),
                    2: Text('Level two'.i18n()),
                    3: Text('Level three'.i18n())
                  },
                  onValueChanged: (value) {
                    setState(() {
                      current_tab = value!;
                    });
                  },
                  groupValue: current_tab,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 25,
                  ),
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Card(
                          margin:
                              EdgeInsets.only(bottom: 20, left: 10, right: 10),
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: AppPrimaryColor, width: 5),
                              borderRadius: BorderRadius.circular(15)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(13),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Flash_cards(
                                            bundletype: '',
                                            quiztype: quiztype,
                                          )));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 30,
                              height: MediaQuery.of(context).size.height / 4,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(children: [
                                        Text(
                                          'kjkjljskslj',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: Center(
                                              child: Text(
                                            '1',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  177, 213, 166, 1),
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                        )
                                      ]),
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: AppPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text(
                                          'kjlkjdkjlj kjlkjdkjlj kjlkjdkjlj kjlkjdkjlj kjlkjdkjlj v kjlkjdkjlj'),
                                    )
                                  ]),
                            ),
                          ),
                        );
                      })),
            ],
          )))
        ],
      ),
    ));
  }
}
