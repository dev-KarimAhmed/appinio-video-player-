class VideoModel {
  String video240, video480, videoUrl;
  VideoModel({
    required this.videoUrl,
    required this.video240,
    required this.video480,
  });
}

List<VideoModel> videosModels = [
  VideoModel(
    videoUrl:
        'https://drive.google.com/uc?export=download&id=1EwIuKz9TTG-fJ6CuZVRffKT7FxzbIiTp',
    video240:
        'https://drive.google.com/uc?export=download&id=1Dog6bdpM1wVzLwd3u8VO4Y4hLk2Z1oDL',
    video480:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  ),
  VideoModel(
    videoUrl:
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    video240:
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    video480:
        "https://drive.google.com/uc?export=download&id=1Dog6bdpM1wVzLwd3u8VO4Y4hLk2Z1oDL",
  ),
];
