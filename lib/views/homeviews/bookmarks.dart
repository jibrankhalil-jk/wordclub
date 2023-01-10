import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:wordclub/others/constants.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({super.key});

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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Text(
                    'Bookmarks'.i18n(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
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
