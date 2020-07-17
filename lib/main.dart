import 'package:flutter/material.dart';
import 'package:videoTest/VideoPlayerWidget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:videoTest/chewie_list_item.dart';

import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String videoSource = "videos/AcousticNoiseReduction.mp4";
  void changeSource() {
    print(videoSource);
    setState(() {
      videoSource = "videos/IntroVideo.mp4";
    });
    _currentVideoPath.sink.add(videoSource);
  }

  final _currentVideoPath =
      BehaviorSubject<String>.seeded("videos/AcousticNoiseReduction.mp4");

  Widget Videos() {
    return StreamBuilder<String>(
      stream: _currentVideoPath,
      builder: (context, snapshot) {
        return VideoPlayerWidget(
          assetPath: snapshot.data,
          autoPlay: true,
          showControls: false,
          looping: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Column(
        children: <Widget>[
          Videos(),
          RaisedButton(
            onPressed: changeSource,
            child: Text("change"),
          )
        ],
      ),
    );
  }
}
