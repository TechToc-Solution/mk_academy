class VersionData {
  bool? success;
  String? message;
  VersionModel? version;

  VersionData({this.success, this.message, this.version});

  VersionData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    version = json['data'] != null ? VersionModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (version != null) {
      data['data'] = version!.toJson();
    }
    return data;
  }
}

class VersionModel {
  String? minRequiredVersion;
  String? maxVersion;
  String? ios;
  String? android;

  VersionModel(
      {this.minRequiredVersion, this.maxVersion, this.ios, this.android});

  VersionModel.fromJson(Map<String, dynamic> json) {
    minRequiredVersion = json['min_required_version']?.toString();
    maxVersion = json['max_version']?.toString();
    ios = json['ios']?.toString();
    android = json['android']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min_required_version'] = minRequiredVersion;
    data['max_version'] = maxVersion;
    data['ios'] = ios;
    data['android'] = android;
    return data;
  }
}
