import 'package:adwiah/View/Initial/View_Model/initial_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DemoScreen extends StatefulWidget {
  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  VideoPlayerController? _controller;
  InitialAppController controller = Get.find<InitialAppController>();
  String video = '';
  @override
  void initState() {
    super.initState();
    controller.aboutTextsList.forEach((element) {
      element.id == 7 ? video = element.textEn! : null;
    });

    _controller = VideoPlayerController.network(video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    _controller!.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: _controller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    )
                  : Container(),
            ),
            Positioned(
              top: 8,
              left: 16,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: Colors.red.withAlpha(100),
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.keyboard_backspace_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller!.value.isPlaying
                ? _controller!.pause()
                : _controller!.play();
          });
        },
        child: Icon(
          _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
