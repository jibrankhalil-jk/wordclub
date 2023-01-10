import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:text_to_speech/text_to_speech.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final GetStorage _getStorage = GetStorage();
  GlobalCubit() : super(GlobalInitial());
  TextToSpeech tts = TextToSpeech();

  Locale app_language =
      GetStorage().read('App_Language') == 'en' ? Locale('en') : Locale('ur');

  change_app_language_to_urdu() async {
    emit(GlobalDummystate());
    app_language = await Locale('ur');
    await _getStorage.write('App_Language', 'ur');
    emit(GlobalInitial());
  }

  change_app_language_to_english() async {
    emit(GlobalDummystate());
    app_language = await Locale('en');
    await _getStorage.write('App_Language', 'en');
    emit(GlobalInitial());
  }

  speak_with_tts(var text) async {
    await tts.speak(text);
  }
}
