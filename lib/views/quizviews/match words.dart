import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/others/constants.dart';
import 'package:localization/localization.dart';

class Match_The_Words extends StatelessWidget {
  Match_The_Words({this.bundletype, this.quiztype});
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
                      content: Text('Are you sure want to exit'),
                      actions: [
                        ElevatedButton(onPressed: () {}, child: Text('Resume')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text('Quit')),
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
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                              Center(
                                child: Text(
                                  'What word has the following defination?'
                                      .i18n(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(
                                  'Lorem ipsum kkjh kjskjkj kj  kj'.i18n(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
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
                                    horizontal: 20,
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        children: [
                                          MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Colors.grey,
                                              onPressed: () {},
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 13),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.4,
                                                  child: Center(
                                                      child: Text(
                                                    'Option 1',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )))),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Colors.grey,
                                              onPressed: () {},
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 13),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.4,
                                                  child: Center(
                                                      child: Text(
                                                    'Option 1',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )))),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Colors.grey,
                                              onPressed: () {},
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 13),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.4,
                                                  child: Center(
                                                      child: Text(
                                                    'Option 1',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )))),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Colors.grey,
                                              onPressed: () {},
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 13),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.4,
                                                  child: Center(
                                                      child: Text(
                                                    'Option 1',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )))),
                                        ],
                                      )),
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
