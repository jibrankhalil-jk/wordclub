import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wordclub/others/constants.dart';

class Flash_cards extends StatelessWidget {
  Flash_cards({this.bundletype, this.quiztype});
  var bundletype, quiztype;

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
              child: SingleChildScrollView(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 8.4),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.width / 4,
                    child: Center(
                        child: SvgPicture.asset(
                      AppAssets().volume,
                      height: MediaQuery.of(context).size.width / 9,
                      width: MediaQuery.of(context).size.width / 9,
                    )),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width / 8.4)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    
                    child: Column(
                      children: [
                        Text(',jhkjh k'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    ));
  }
}
