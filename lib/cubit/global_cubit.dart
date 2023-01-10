import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final GetStorage _getStorage = GetStorage();
  GlobalCubit() : super(GlobalInitial());

  Locale app_language =
      GetStorage().read('App_Language') == 'en' ? Locale('en') : Locale('ur');

  change_app_language_to_urdu() async {
    emit(GlobalDummystate());
    app_language = Locale('en');
    await _getStorage.write('App_Language', 'ur');
  }

  change_app_language_to_english() async {
    emit(GlobalDummystate());
    app_language = Locale('ur');
    await _getStorage.write('App_Language', 'en');
  }
}
