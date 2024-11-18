import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchController extends GetxController {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final searchController = TextEditingController().obs;
  var isListening = false.obs;

  void startListening() async {
    bool available = await _speechToText.initialize(
      onStatus: (status) => print("Speech status: $status"),
      onError: (error) => print("Speech error: $error"),
    );
    if (available) {
      isListening.value = true;
      _speechToText.listen(
        onResult: (result) {
          searchController.value.text = result.recognizedWords;
        },
      );
    } else {
      print("Speech recognition unavailable");
    }
  }

  void stopListening() {
    _speechToText.stop();
    isListening.value = false;
  }
}
