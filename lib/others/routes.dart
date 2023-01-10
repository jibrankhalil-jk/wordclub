import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordclub/cubit/global_cubit.dart';
import 'package:wordclub/views/home.dart';
import 'package:wordclub/views/homeviews/history.dart';
import 'package:wordclub/views/settings.dart';
import 'package:wordclub/views/start_quiz.dart';

import '../views/homeviews/bookmarks.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/Home':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => GlobalCubit(),
                  child: Home(),
                ));
      case '/Start_Quiz':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => GlobalCubit(),
                  child: const Start_Quiz(),
                ));
      case '/Settings':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => GlobalCubit(),
                  child: Settings(),
                ));
      case '/Bookmarks':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => GlobalCubit(),
                  child: Bookmarks(),
                ));
      case '/History':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => GlobalCubit(),
                  child: History(),
                ));
      // case '/App_Languages':
      //   return MaterialPageRoute(
      //       builder: (context) => BlocProvider(
      //             create: (context) => GlobalCubit(),
      //             child: App_Language(),
      //           ));
    }
  }
}
