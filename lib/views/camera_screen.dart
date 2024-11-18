import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controllers/camera_controller.dart';

class CameraScreen extends StatelessWidget {
  final cameraControllerApp = Get.put(CameraControllerApp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Obx(() {
        if (!cameraControllerApp.isCameraInitialized.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            AspectRatio(
              aspectRatio: cameraControllerApp.cameraController.value.aspectRatio,
              child: CameraPreview(cameraControllerApp.cameraController),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: cameraControllerApp.takePhoto,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Photo'),
                ),
                Obx(() {
                  return ElevatedButton.icon(
                    onPressed: cameraControllerApp.isRecording.value
                        ? cameraControllerApp.stopRecording
                        : cameraControllerApp.startRecording,
                    icon: Icon(cameraControllerApp.isRecording.value ? Icons.stop : Icons.videocam),
                    label: Text(cameraControllerApp.isRecording.value ? 'Stop' : 'Record'),
                  );
                }),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  if (cameraControllerApp.capturedImage.value != null)
                    Column(
                      children: [
                        Text('Captured Photo:'),
                        Image.file(cameraControllerApp.capturedImage.value!),
                      ],
                    ),
                  if (cameraControllerApp.recordedVideo.value != null)
                    Column(
                      children: [
                        Text('Recorded Video:'),
                        Obx(() {
                          if (!cameraControllerApp.isVideoInitialized.value) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return AspectRatio(
                            aspectRatio: cameraControllerApp.videoPlayerController?.value.aspectRatio ?? 16 / 9,
                            child: VideoPlayer(cameraControllerApp.videoPlayerController!),
                          );
                        }),
                        SizedBox(height: 8),
                        Obx(() {
                          return ElevatedButton.icon(
                            onPressed: cameraControllerApp.isVideoPlaying.value
                                ? cameraControllerApp.pauseVideo
                                : cameraControllerApp.playVideo,
                            icon: Icon(cameraControllerApp.isVideoPlaying.value ? Icons.pause : Icons.play_arrow),
                            label: Text(cameraControllerApp.isVideoPlaying.value ? 'Pause' : 'Play'),
                          );
                        }),
                      ],
                    ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
