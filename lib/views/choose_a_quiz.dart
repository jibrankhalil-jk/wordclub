import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:wordclub/models/quiz_option_model.dart';
import 'package:wordclub/others/constants.dart';
import 'package:wordclub/views/choose_a_word_pack.dart';

class Choose_a_quiz extends StatelessWidget {
  Choose_a_quiz(this.type);
  var type;

  @override
  Widget build(BuildContext context) {
    List<Quiz_Option_Model> Vocabularly_items = [
      Quiz_Option_Model(
          Title: 'Flash Cards'.i18n(),
          img: AppAssets().flash_cards2,
          Progress: '0',
          Icon: AppAssets().flash_cards,
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Choose_a_word_pack(type, 'Flash Cards')));
          }),
      Quiz_Option_Model(
          img: AppAssets().match_the_word2,
          Title: 'Match The Words'.i18n(),
          Progress: '0',
          Icon: AppAssets().match_the_word,
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Choose_a_word_pack(type, 'Match_The_Words')));
          }),
      Quiz_Option_Model(
          Title: 'Multiple Choices'.i18n(),
          Progress: '0',
          Icon: AppAssets().mcqs,
          img: AppAssets().mcqs2,
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Choose_a_word_pack(type, 'Multiple_Choices')));
          }),
    ];
    List<Quiz_Option_Model> Spellings_items = [
      Quiz_Option_Model(
          Title: 'Flash Cards'.i18n(),
          Progress: '0',
          Icon: AppAssets().flash_cards,
          img: AppAssets().flash_cards2,
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Choose_a_word_pack(type, 'Flash Cards')));
          }),
      Quiz_Option_Model(
          Title: 'Fill in the Blanks'.i18n(),
          Progress: '0',
          img: AppAssets().fill_in_the_blanks2,
          Icon: AppAssets().fill_in_the_blanks,
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Choose_a_word_pack(type, 'fill in the blanks')));
          }),
      Quiz_Option_Model(
          Title: 'Multiple Choices'.i18n(),
          img: AppAssets().mcqs2,
          Progress: '0',
          Icon: AppAssets().mcqs,
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Choose_a_word_pack(type, 'Multiple_Choices')));
          }),
      Quiz_Option_Model(
          img: AppAssets().match_the_word2,
          Title: 'Type full word'.i18n(),
          Progress: '0',
          Icon: AppAssets().match_the_word,
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Choose_a_word_pack(type, 'Type Full Word')));
          }),
      Quiz_Option_Model(
          img: AppAssets().match_the_vowel2,
          Title: 'Match The Vowel'.i18n(),
          Progress: '0',
          Icon: AppAssets().match_the_vowel,
          onpressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Choose_a_word_pack(type, 'Match_The_Vowel')));
          }),
    ];
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
                height: MediaQuery.of(context).size.width / 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Text(
                    'Choose a Quiz'.i18n(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 17,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 25,
                ),
                height: MediaQuery.of(context).size.height / 1.24,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.78, crossAxisCount: 2),
                    itemCount: type == 'Spellings'
                        ? Spellings_items.length
                        : Vocabularly_items.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          type == 'Spellings'
                              ? Spellings_items[index].onpressed!()
                              : Vocabularly_items[index].onpressed!();
                        },
                        child: Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Center(
                                    // child: SvgPicture.asset(
                                    //   type == 'Spellings'
                                    //       ? Spellings_items[index].Icon
                                    //       : Vocabularly_items[index].Icon,
                                    //   fit: BoxFit.fill,),
                                    child: Image.asset(
                                  type == 'Spellings'
                                      ? Spellings_items[index].img
                                      : Vocabularly_items[index].img,
                                )),
                                Spacer(),
                                Text(
                                  type == 'Spellings'
                                      ? Spellings_items[index].Title
                                      : Vocabularly_items[index].Title,
                                ),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                    })),
              ),
            ],
          )))
        ],
      ),
    ));
  }
}
