class VideoDataModel {
  int? id;
  String? name;
  String? thumbnail;
  String? hlsUrl;
  List<DownloadUrls>? downloadUrls;
  String? file;
  bool? isViewed;

  VideoDataModel(
      {this.id,
      this.name,
      this.thumbnail,
      this.hlsUrl,
      this.downloadUrls,
      this.file,
      this.isViewed});

  VideoDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    hlsUrl = json['hls_url'];
    if (json['download_urls'] != null) {
      downloadUrls = <DownloadUrls>[];
      json['download_urls'].forEach((v) {
        downloadUrls!.add(DownloadUrls.fromJson(v));
      });
    }
    file = json['file'];
    isViewed = json['is_viewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['hls_url'] = hlsUrl;
    if (downloadUrls != null) {
      data['download_urls'] = downloadUrls!.map((v) => v.toJson()).toList();
    }
    data['file'] = file;
    data['is_viewed'] = isViewed;
    return data;
  }
}

class DownloadUrls {
  String? resolution;
  String? url;

  DownloadUrls({this.resolution, this.url});

  DownloadUrls.fromJson(Map<String, dynamic> json) {
    resolution = json['resolution'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resolution'] = resolution;
    data['url'] = url;
    return data;
  }
}
