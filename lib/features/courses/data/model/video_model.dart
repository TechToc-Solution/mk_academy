class VideoData {
  List<Video>? videos;

  VideoData({this.videos});

  VideoData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      videos = <Video>[];
      json['data'].forEach((v) {
        videos!.add(Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (videos != null) {
      data['data'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Video {
  int? id;
  String? name;
  String? thumbnail;
  String? video;
  String? duration;
  String? filePath;
  List<DownloadItem>? downloads;

  Video(
      {this.id,
      this.name,
      this.thumbnail,
      this.video,
      this.duration,
      this.filePath,
      this.downloads});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    // video = json['video'];
    video =
        "https://vz-1d08d856-dd0.b-cdn.net/adee4c9c-b5e9-4637-909e-8f5eceb82b65/playlist.m3u8";
    duration = json['duration'];
    filePath = json['file'];
    downloads = [
      DownloadItem(
          quality: "360",
          url:
              "https://vz-1d08d856-dd0.b-cdn.net/adee4c9c-b5e9-4637-909e-8f5eceb82b65/play_360p.mp4"),
      DownloadItem(
          quality: "480",
          url:
              "https://vz-1d08d856-dd0.b-cdn.net/adee4c9c-b5e9-4637-909e-8f5eceb82b65/play_480p.mp4"),
      DownloadItem(
          quality: "720",
          url:
              "https://vz-1d08d856-dd0.b-cdn.net/adee4c9c-b5e9-4637-909e-8f5eceb82b65/play_720p.mp4")
    ];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['video'] = video;
    data['duration'] = duration;
    data['file'] = filePath;
    return data;
  }
}

class DownloadItem {
  final String url;
  final String quality;
  DownloadItem({required this.url, required this.quality});
}
