class UGCKitResult {
  /// 错误码
  int? errorCode;

  /// 详细描述
  String? descMsg;

  /// 封面
  String? coverPath;

  /// 输出视频路径
  String? outputPath;

  UGCKitResult({this.errorCode, this.descMsg, this.coverPath, this.outputPath});
}
