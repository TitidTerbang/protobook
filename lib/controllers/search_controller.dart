import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchController extends GetxController {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final RxBool isListening = false.obs;
  final RxString speechText = ''.obs;

  Future<void> startListening() async {
    bool available = await _speechToText.initialize(
      onStatus: (status) => print("Status: $status"),
      onError: (error) => print("Error: $error"),
    );

    if (available) {
      isListening.value = true;
      _speechToText.listen(onResult: (result) {
        speechText.value = result.recognizedWords;
      });
    } else {
      print("Speech recognition unavailable");
    }
  }

  void stopListening() {
    _speechToText.stop();
    isListening.value = false;
  }
}