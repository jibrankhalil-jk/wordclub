import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/others/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});
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
                Spacer(
                  flex: 2,
                ),
                Text(
                  'Word Club',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: AppPrimaryColor),
                ),
                Spacer(
                  flex: 3,
                ),
                GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/Start_Quiz'),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 8,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            AppAssets().quiz_button,
                            fit: BoxFit.fill,
                          ),
                          Center(
                              child: Text(
                            'Start Quiz'.i18n(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width / 20,
                                fontWeight: FontWeight.w400),
                          ))
                        ],
                      ),
                    )),
                Spacer(
                  flex: 1,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 8,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            AppAssets().regular_quiz_button,
                            fit: BoxFit.fill,
                          ),
                          Center(
                              child: Text(
                            'Bookmarks'.i18n(),
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 20,
                                fontWeight: FontWeight.w400),
                          ))
                        ],
                      ),
                    )),
                Spacer(
                  flex: 1,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 8,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            AppAssets().regular_quiz_button,
                            fit: BoxFit.fill,
                          ),
                          Center(
                              child: Text(
                            'History'.i18n(),
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 20,
                                fontWeight: FontWeight.w400),
                          ))
                        ],
                      ),
                    )),
                Spacer(
                  flex: 1,
                ),
                GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/Settings'),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 8,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            AppAssets().regular_quiz_button,
                            fit: BoxFit.fill,
                          ),
                          Center(
                              child: Text(
                            'Settings'.i18n(),
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 20,
                                fontWeight: FontWeight.w400),
                          ))
                        ],
                      ),
                    )),
                Spacer(
                  flex: 5,
                ),
              ],
            )),
          )
        ],
      ),
    ));
  }
}

// Column(
//                 children: [
//                   Spacer(
//                     flex: 10,
//                   ),
//                   CircleAvatar(
//                     radius: 40,
//                   ),
//                   Spacer(
//                     flex: 10,
//                   ),
//                   Container(
//                       margin: EdgeInsets.symmetric(horizontal: 50),
//                       width: double.infinity,
//                       height: 69,
//                       child: MaterialButton(
//                           color: AppPrimaryColor,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                           onPressed: () {},
//                           child: Text(
//                             'Started',
//                             style: TextStyle(fontSize: 17, color: Colors.white),
//                           ))),
//                   Spacer(
//                     flex: 4,
//                   ),
//                 ],
//               ),
