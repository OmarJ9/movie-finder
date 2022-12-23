import 'package:flutter/material.dart';
import 'package:movie_finder/src/data/models/video_model.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../constants/app_colors.dart';

class TrailerScreen extends StatefulWidget {
  final List<VideoModel> videos;

  const TrailerScreen({
    super.key,
    required this.videos,
  });

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videos[0].key,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayerBuilder(
        onExitFullScreen: () {},
        player: YoutubePlayer(
          controller: _controller,
          bottomActions: [
            const SizedBox(width: 14.0),
            CurrentPosition(),
            const SizedBox(width: 8.0),
            ProgressBar(
              isExpanded: true,
              colors: const ProgressBarColors(
                playedColor: AppColors.green,
                handleColor: Colors.amberAccent,
              ),
            ),
            RemainingDuration(),
            const PlaybackSpeedButton(),
          ],
          aspectRatio: 16 / 9,
          showVideoProgressIndicator: true,
          progressIndicatorColor: AppColors.green,
        ),
        builder: (context, player) {
          return SizedBox(height: 100.h, child: player);
        },
      ),
    );
  }
}
