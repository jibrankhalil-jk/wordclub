import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/models/database_main_model.dart';
import 'package:wordclub/others/constants.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({super.key});

  @override
  Widget build(BuildContext context) {
    List bookmarks = GetStorage().read('bookmarks') ?? [];

    log(bookmarks.length.toString());
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
              Expanded(
                child: PageView.builder(
                    itemCount: bookmarks.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 14,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<GlobalCubit>(context)
                                    .speak_with_tts('${bookmarks[index].word}');
                              },
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
                              '${bookmarks[index].word}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${bookmarks[index].pronunciation}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
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
                                              '${bookmarks[index].origin}'),
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
                                              '${bookmarks[index].part_of_speech}'),
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
                                              '${bookmarks[index].defination}'),
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
                                              '${bookmarks[index].sentence}'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Spacer(),
                                          Text('${index}/${bookmarks.length}'),
                                        ],
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
                      );
                    }),
              )
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
