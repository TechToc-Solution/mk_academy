enum ValidationState { normal, email, password, phoneNumber, price }

enum DownloadStatus {
  initial,
  downloading,
  completed,
  failed,
  permissionDenied;

  bool get isDownloading => this == downloading;
  bool get isCompleted => this == completed;
}
