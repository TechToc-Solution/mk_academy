class AdsData {
  List<Ads>? ads;

  AdsData({this.ads});

  AdsData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      ads = <Ads>[];
      json['data'].forEach((v) {
        ads!.add(new Ads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.ads != null) {
      data['data'] = this.ads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ads {
  int? id;
  String? image;
  String? createdAt;

  Ads({this.id, this.image, this.createdAt});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}
