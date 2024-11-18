import 'dart:io';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class SpeakerController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  final Rx<File?> selectedFile = Rx<File?>(null);
  final RxBool isPlaying = false.obs;

  // Upload file MP3
  Future<void> uploadMp3() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      // Simpan file ke direktori lokal aplikasi
      Directory appDir = await getApplicationDocumentsDirectory();
      String newPath = '${appDir.path}/${file.path.split('/').last}';
      File savedFile = await file.copy(newPath);

      selectedFile.value = savedFile;
      print('File uploaded and saved to: $newPath');
    }
  }

  // Play MP3
  Future<void> playAudio() async {
    if (selectedFile.value != null) {
      await audioPlayer.play(DeviceFileSource(selectedFile.value!.path));
      isPlaying.value = true;
    } else {
      Get.snackbar('Error', 'No file selected to play!');
    }
  }

  // Pause audio
  Future<void> pauseAudio() async {
    await audioPlayer.pause();
    isPlaying.value = false;
  }

  // Stop audio
  Future<void> stopAudio() async {
    await audioPlayer.stop();
    isPlaying.value = false;
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
