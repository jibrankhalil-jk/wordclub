import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/others/constants.dart';
import 'package:wordclub/views/quizviews/flash_cards.dart';
import 'package:wordclub/views/quizviews/fill%20in%20the%20blanks.dart';
import 'package:wordclub/views/quizviews/match%20the%20vowel.dart';
import 'package:wordclub/views/quizviews/match%20words.dart';
import 'package:wordclub/views/quizviews/multiple%20choices.dart';
import 'package:wordclub/views/quizviews/type%20full%20word.dart';

class Choose_a_word_pack extends StatefulWidget {
  Choose_a_word_pack(this.type, this.quiztype);
  var type, quiztype;

  @override
  State<Choose_a_word_pack> createState() => _Choose_a_word_packState();
}

class _Choose_a_word_packState extends State<Choose_a_word_pack> {
  int current_tab = 0;

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
                    child:
                        SvgPicture.asset(AppAssets().background_illustration)),
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
                      child: BlocBuilder<GlobalCubit, GlobalState>(
                        builder: (context, state) {
                          return CupertinoSlidingSegmentedControl(
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
                          );
                        },
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
                        child: BlocBuilder<GlobalCubit, GlobalState>(
                          builder: (context, state) {
                            return FutureBuilder(
                                future: current_tab == 0
                                    ? BlocProvider.of<GlobalCubit>(context)
                                        .Fetch_all_word_packs()
                                    : current_tab == 1
                                        ? BlocProvider.of<GlobalCubit>(context)
                                            .Fetch_all_word_packs(level: 1)
                                        : current_tab == 2
                                            ? BlocProvider.of<GlobalCubit>(
                                                    context)
                                                .Fetch_all_word_packs(level: 2)
                                            : current_tab == 3
                                                ? BlocProvider.of<GlobalCubit>(
                                                        context)
                                                    .Fetch_all_word_packs(
                                                        level: 3)
                                                : null,
                                builder: (context, AsyncSnapshot datasnap) {
                                  if (datasnap.hasData) {
                                    // log(datasnap.data[0].level.toString());
                                    return ListView.builder(
                                        itemCount: datasnap.data.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            margin: EdgeInsets.only(
                                                bottom: 20,
                                                left: 10,
                                                right: 10),
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: AppPrimaryColor,
                                                    width: 5),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  if (widget.quiztype ==
                                                      'Flash Cards') {
                                                    return Flash_cards(
                                                      bundletype: '${GetStorage().read('App_Language') == 'en' ? datasnap.data[index].title : datasnap.data[index].urduname}',
                                                      quiztype: widget.quiztype,
                                                    );
                                                  } else if (widget.quiztype ==
                                                      'fill in the blanks') {
                                                    return Fill_In_TheBlanks(
                                                      bundletype:  '${GetStorage().read('App_Language') == 'en' ? datasnap.data[index].title : datasnap.data[index].urduname}',
                                                      quiztype: widget.quiztype,
                                                    );
                                                  } else if (widget.quiztype ==
                                                      'Match_The_Words') {
                                                    return Match_The_Words(
                                                      bundletype:  '${GetStorage().read('App_Language') == 'en' ? datasnap.data[index].title : datasnap.data[index].urduname}',
                                                      quiztype: widget.quiztype,
                                                    );
                                                  } else if (widget.quiztype ==
                                                      'Multiple_Choices') {
                                                    return Multiple_Choices(
                                                      bundletype:  '${GetStorage().read('App_Language') == 'en' ? datasnap.data[index].title : datasnap.data[index].urduname}',
                                                      quiztype: widget.quiztype,
                                                    );
                                                  } else if (widget.quiztype ==
                                                      'Type Full Word') {
                                                    return Type_Full_Word(
                                                      bundletype:  '${GetStorage().read('App_Language') == 'en' ? datasnap.data[index].title : datasnap.data[index].urduname}',
                                                      quiztype: widget.quiztype,
                                                    );
                                                  } else if (widget.quiztype ==
                                                      'Match_The_Vowel') {
                                                    return Match_The_Vowel(
                                                      bundletype:  '${GetStorage().read('App_Language') == 'en' ? datasnap.data[index].title : datasnap.data[index].urduname}',
                                                      quiztype: widget.quiztype,
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                }));
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    30,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    4,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: Row(children: [
                                                          Text(
                                                            // '${datasnap.data[index].}',
                                                            '${GetStorage().read('App_Language') == 'en' ? datasnap.data[index].title : datasnap.data[index].urduname}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            child: Center(
                                                                child: Text(
                                                              '${datasnap.data[index].level}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                            width: 30,
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        177,
                                                                        213,
                                                                        166,
                                                                        1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7)),
                                                          )
                                                        ]),
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppPrimaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(18.0),
                                                        child: Text(
                                                          '${GetStorage().read('App_Language') == 'en' ? datasnap.data[index].title : datasnap.data[index].urduname}',
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return CupertinoActivityIndicator();
                                  }
                                });
                          },
                        )),
                  ],
                )))
              ],
            )));
  }
}
