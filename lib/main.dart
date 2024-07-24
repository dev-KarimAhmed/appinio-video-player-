import 'dart:developer';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:video_app/models/video_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        videos: videosModels,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.videos});
  final List<VideoModel> videos;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CachedVideoPlayerController _videoPlayerController;
  late CachedVideoPlayerController _videoPlayerController2;
  late CachedVideoPlayerController _videoPlayerController3;

  late CustomVideoPlayerController _customVideoPlayerController;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings(
    showSeekButtons: true,
    controlBarDecoration: BoxDecoration(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  @override
  void initState() {
    super.initState();
    _initializeVideoControllers(widget.videos.first);
  }

  void _initializeVideoControllers(VideoModel video) {
    _videoPlayerController = CachedVideoPlayerController.network(
      video.videoUrl,
    )..initialize().then((_) => setState(() {}));

    _videoPlayerController2 =
        CachedVideoPlayerController.network(video.video240);
    _videoPlayerController3 =
        CachedVideoPlayerController.network(video.video480);

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
      additionalVideoSources: {
        "240p": _videoPlayerController2,
        "480p": _videoPlayerController3,
        "720p": _videoPlayerController,
      },
    );
  }

  void _updateVideo(VideoModel video) {
    _videoPlayerController.dispose();
    _videoPlayerController2.dispose();
    _videoPlayerController3.dispose();

    _initializeVideoControllers(video);
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    _videoPlayerController.dispose();
    _videoPlayerController2.dispose();
    _videoPlayerController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text("Appinio Video Player"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        log('@$index');
                        _updateVideo(widget.videos[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Video [$index]'),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  itemCount: widget.videos.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
