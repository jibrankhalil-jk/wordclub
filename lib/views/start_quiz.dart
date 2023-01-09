import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:wordclub/others/constants.dart';

import 'choose_a_quiz.dart';

class Start_Quiz extends StatelessWidget {
  const Start_Quiz({super.key});

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
                flex: 4,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Text(
                    'What kind of quiz would like to take?'.i18n(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  height: 59,
                  child: MaterialButton(
                      color: AppPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Choose_a_quiz('Vocabularly')));
                      },
                      child: Text(
                        'Vocabularly'.i18n(),
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ))),
              Spacer(
                flex: 1,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  height: 59,
                  child: MaterialButton(
                      color: AppPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Choose_a_quiz('Spellings')));
                      },
                      child: Text(
                        'Spellings'.i18n(),
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ))),
              Spacer(
                flex: 10,
              ),
            ],
          )))
        ],
      ),
    ));
  }
}















//     return Scaffold(
//         body: Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: Stack(
//         children: [
//           Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: SvgPicture.asset(AppAssets().background_illustration)),
//           SafeArea(
//               child: Center(
//                   child: Column(
//             children: [],
//           )))
//         ],
//       ),
//     ));
//   }
// }
