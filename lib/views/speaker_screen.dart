import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/speaker_controller.dart';

class SpeakerScreen extends StatelessWidget {
  final speakerController = Get.put(SpeakerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speaker Player'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (speakerController.selectedFile.value != null) {
                return Column(
                  children: [
                    Text(
                      'Selected File: ${speakerController.selectedFile.value!.path.split('/').last}',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                  ],
                );
              } else {
                return Text(
                  'No file selected.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                );
              }
            }),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await speakerController.uploadMp3();
                  },
                  child: Text('Upload MP3'),
                ),
                Obx(() {
                  return ElevatedButton(
                    onPressed: speakerController.isPlaying.value
                        ? speakerController.pauseAudio
                        : speakerController.playAudio,
                    child: Text(
                      speakerController.isPlaying.value ? 'Pause' : 'Play',
                    ),
                  );
                }),
                ElevatedButton(
                  onPressed: speakerController.stopAudio,
                  child: Text('Stop'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Obx(() {
              return speakerController.isPlaying.value
                  ? CircularProgressIndicator()
                  : SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
