import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final list = [
    "https://v3.cdnpk.net/videvo_files/video/free/2014-12/small_watermarked/Raindrops_Videvo_preview.webm",
    "https://v3.cdnpk.net/videvo_files/video/free/video0461/small_preview/_import_60e0167b4c3a96.14254367.webm",
    "https://v3.cdnpk.net/videvo_files/video/free/2022-01/small_watermarked/220114_01_Drone_4k_017_preview.webm",
    "https://v1.cdnpk.net/videvo_files/video/free/2022-11/small_preview/221017_02_Urban%20Football_4k_004.webm",
    "https://v3.cdnpk.net/videvo_files/video/free/video0468/small_preview/_import_616544715ef4e9.88359002.webm",
    "https://v3.cdnpk.net/videvo_files/video/free/2019-09/small_preview/190828_27_SuperTrees_HD_17.webm",
    "https://gemootest.s3.us-east-2.amazonaws.com/s/res/514885813225336832/ff85082d7b806c925b51d802d6aaa2c5.mp4?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARLZICB6QQHKRCV7K%2F20231124%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20231124T044408Z&X-Amz-SignedHeaders=host&X-Amz-Expires=7200&X-Amz-Signature=06f91a1e97a86d137c641cbefd1f99b1ce3cff840061024dcf2402b0a655e5a7",
    "https://gemootest.s3.us-east-2.amazonaws.com/s/res/514885813225336832/8b58499d434c9e1f1ac1ced2d0eec58b.mp4?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARLZICB6QQHKRCV7K%2F20231124%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20231124T044204Z&X-Amz-SignedHeaders=host&X-Amz-Expires=7200&X-Amz-Signature=594da62b6cc3dc835eeb1b3ad3cd8545e7a6d4292497a95125abdb7bdc7cee41",
    "https://gemootest.s3.us-east-2.amazonaws.com/s/res/514885813225336832/8d58fa2978042d107da7aa627fe02ab9.mp4?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARLZICB6QQHKRCV7K%2F20231124%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20231124T035515Z&X-Amz-SignedHeaders=host&X-Amz-Expires=7200&X-Amz-Signature=dcc630b8afecbbbac56d06808268d72439368dbdfdfbb71701facd5c6958b215",
  ];
  @override
  void initState() {
    // VideoPlayerHelper.precacheVideoDatasource(controller, dataSource)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(),
      ),
    );
  }
}
