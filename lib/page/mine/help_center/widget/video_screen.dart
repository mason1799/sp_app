import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  final String url;

  VideoScreen({required this.url});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();
    player.setDataSource(widget.url, autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FijkView(
        color: Colors.black,
        player: player,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}
