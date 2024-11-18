import 'dart:io';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

class CameraControllerApp extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  final RxBool isCameraInitialized = false.obs;
  final Rx<File?> capturedImage = Rx<File?>(null);
  final Rx<File?> recordedVideo = Rx<File?>(null);
  final RxBool isRecording = false.obs;

  VideoPlayerController? videoPlayerController;
  final RxBool isVideoInitialized = false.obs;
  final RxBool isVideoPlaying = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(cameras[0], ResolutionPreset.high);
        await cameraController.initialize();
        isCameraInitialized.value = true;
      } else {
        Get.snackbar('Error', 'No cameras available');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize camera: $e');
    }
  }

  Future<void> takePhoto() async {
    if (isCameraInitialized.value && cameraController.value.isInitialized) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String photoPath = '${appDir.path}/photo_${DateTime.now().millisecondsSinceEpoch}.jpg';

      await cameraController.takePicture().then((XFile file) {
        final File savedImage = File(file.path);
        capturedImage.value = savedImage.copySync(photoPath);
        Get.snackbar('Success', 'Photo captured successfully');
      }).catchError((error) {
        Get.snackbar('Error', 'Failed to capture photo: $error');
      });
    }
  }

  Future<void> startRecording() async {
    if (isCameraInitialized.value &&
        cameraController.value.isInitialized &&
        !cameraController.value.isRecordingVideo) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String videoPath = '${appDir.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

      await cameraController.startVideoRecording().then((_) {
        isRecording.value = true;
        recordedVideo.value = File(videoPath);
      }).catchError((error) {
        Get.snackbar('Error', 'Failed to start video recording: $error');
      });
    }
  }

  Future<void> stopRecording() async {
    if (isCameraInitialized.value && cameraController.value.isRecordingVideo) {
      await cameraController.stopVideoRecording().then((XFile file) {
        recordedVideo.value = File(file.path);
        initializeVideoPlayer();
        isRecording.value = false;
        Get.snackbar('Success', 'Video recording saved');
      }).catchError((error) {
        Get.snackbar('Error', 'Failed to stop video recording: $error');
      });
    }
  }

  Future<void> initializeVideoPlayer() async {
    if (recordedVideo.value != null) {
      videoPlayerController = VideoPlayerController.file(recordedVideo.value!)
        ..initialize().then((_) {
          isVideoInitialized.value = true;
          isVideoPlaying.value = false;
        });
    }
  }

  void playVideo() {
    if (videoPlayerController != null) {
      videoPlayerController!.play();
      isVideoPlaying.value = true;
    }
  }

  void pauseVideo() {
    if (videoPlayerController != null) {
      videoPlayerController!.pause();
      isVideoPlaying.value = false;
    }
  }

  @override
  void onClose() {
    if (isCameraInitialized.value) {
      cameraController.dispose();
    }
    videoPlayerController?.dispose();
    super.onClose();
  }
}
