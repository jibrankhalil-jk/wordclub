import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/others/routes.dart';
import 'package:wordclub/others/theme.dart';
import 'package:wordclub/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetStorage _getx_storage = GetStorage();
  await _getx_storage.initStorage;
  String? App_language;
  try {
    App_language = await _getx_storage.read('App_Language');
    if (App_language == null) {
      await _getx_storage.write('App_Language', 'en');
    }
  } catch (e) {}

  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  runApp(Splash());
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GlobalCubit(),
        child: BlocBuilder<GlobalCubit, GlobalState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                // GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                LocalJsonLocalization.delegate,
              ],
              supportedLocales: [
                Locale('en', 'US'),
                Locale('ur', 'PK'),
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                if (supportedLocales.contains(locale)) {
                  return locale;
                }
                if (locale?.languageCode == 'ur') {
                  return Locale('ur', 'PK');
                }
                // default language
                return Locale('en', 'US');
              },
              locale: BlocProvider.of<GlobalCubit>(context).app_language,
              theme: theme(),
              themeMode: ThemeMode.light,
              // initialRoute: '/Home',
              home: Home(),
              onGenerateRoute: Routes.onGenerateRoute,
            );
          },
        ));
  }
}
