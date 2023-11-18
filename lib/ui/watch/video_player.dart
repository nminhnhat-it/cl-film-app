import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class VideoPlayer extends StatefulWidget {
  final String videoLink;

  const VideoPlayer({
    super.key,
    required this.videoLink,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  _VideoPlayerState();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer.network(
        widget.videoLink,
        betterPlayerConfiguration: const BetterPlayerConfiguration(
          fit: BoxFit.contain,
          autoDispose: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          fullScreenAspectRatio: 16 / 9,
          deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        ),
      ),
    );
  }
}
