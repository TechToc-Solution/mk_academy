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

  Video({
    this.id,
    this.name,
    this.thumbnail,
  });

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    // video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
