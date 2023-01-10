import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/others/constants.dart';
import 'package:localization/localization.dart';

class Flash_cards extends StatelessWidget {
  Flash_cards({this.bundletype, this.quiztype});
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
                                height: MediaQuery.of(context).size.height / 14,
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<GlobalCubit>(context)
                                      .speak_with_tts('Alpha');
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: MediaQuery.of(context).size.width / 4,
                                  child: Center(
                                      child: SvgPicture.asset(
                                    AppAssets().volume,
                                    height:
                                        MediaQuery.of(context).size.width / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 9,
                                  )),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(300)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Alpha',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 19),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 14,
                              ),
                              Container(
                                // height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Origin'.i18n()),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.black12,
                                          ),
                                          // height: 40,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'lksjlskllksjlskllksjlskllksjlskl'),
                                          ),
                                        ),
                                        Text('Part of Speech'.i18n()),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.black12,
                                          ),
                                          // height: 40,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'lksjlskllksjlskllksjlskllksjlskl'),
                                          ),
                                        ),
                                        Text('Defination'.i18n()),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.black12,
                                          ),
                                          // height: 40,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'lksjlskllksjlskllksjlskllksjlskl'),
                                          ),
                                        ),
                                        Text('Sentences'.i18n()),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.black12,
                                          ),
                                          // height: 40,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'lksjlskllksjlskllksjlskllksjlskl'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 3,
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
}
