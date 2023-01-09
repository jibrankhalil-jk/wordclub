import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  Locale app_language = Locale('en');
  GlobalCubit() : super(GlobalInitial());

  change_app_language_to_urdu() {
    app_language = Locale('ur');
    emit(GlobalDummystate());
  }

  change_app_language_to_english() {
    app_language = Locale('en');
    emit(GlobalDummystate());
  }
}
