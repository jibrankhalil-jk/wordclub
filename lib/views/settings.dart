import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/others/constants.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings'.i18n(),
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('General'.i18n()),
                ListTile(
                  leading: SvgPicture.asset(AppAssets().notification),
                  title: Text('Push notificaions'.i18n()),
                  trailing: Switch(
                    value: false,
                    onChanged: (Value) {},
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Container(
                              height: 100,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          BlocProvider.of<GlobalCubit>(context)
                                              .change_app_language_to_english();
                                        },
                                        child: Text('English')),
                                    TextButton(
                                        onPressed: () {
                                          BlocProvider.of<GlobalCubit>(context)
                                              .change_app_language_to_urdu();
                                        },
                                        child: Text('Urdu')),
                                  ]),
                            ),
                          );
                        });
                  },
                  child: ListTile(
                    leading: SvgPicture.asset(AppAssets().document),
                    title: Text('Language'.i18n()),
                  ),
                ),
                Text('Support'.i18n()),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: SvgPicture.asset(AppAssets().infocircle),
                    title: Text('Contact support'.i18n()),
                  ),
                ),
                Text('About'.i18n()),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: SvgPicture.asset(AppAssets().star),
                    title: Text('Rate us'.i18n()),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: SvgPicture.asset(AppAssets().document),
                    title: Text('Term of Conditions'.i18n()),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: SvgPicture.asset(AppAssets().document),
                    title: Text('Privacy Policies'.i18n()),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(AppAssets().infocircle),
                  title: Text('Version'.i18n()),
                  trailing: Text('v1.0'),
                ),
              ])),
        ),
      ),
    );
  }
}
