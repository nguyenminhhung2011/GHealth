import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';

class TestVideo extends StatefulWidget {
  const TestVideo({super.key});

  @override
  State<TestVideo> createState() => _TestVideoState();
}

class _TestVideoState extends State<TestVideo> {
  //https://github.com/minhunsocute/Data-GHealth/blob/main/workout_image/Hip%20Bridge.mp4?raw=true
  late BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    debugPrint('1');
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "https://github.com/minhunsocute/Data-GHealth/blob/main/workout_image/Hip%20Bridge.mp4?raw=true");
    debugPrint('2');
    _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(autoPlay: true),
        betterPlayerDataSource: betterPlayerDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer.network(
        "https://github.com/minhunsocute/Data-GHealth/blob/main/workout_image/Hip%20Bridge.mp4?raw=true",
        betterPlayerConfiguration:
            const BetterPlayerConfiguration(autoPlay: true),
      ),
    );
  }
}
