import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import '../data.dart';

class ControlsOverlay extends StatelessWidget {
  static const double _playButtonIconSize = 20;
  static const double _replayButtonIconSize = 40;
  static const double _seekButtonIconSize = 15;

  static const Duration _seekStepForward = Duration(seconds: 10);
  static const Duration _seekStepBackward = Duration(seconds: -10);

  static const Color _iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 50),
        reverseDuration: Duration(milliseconds: 200),
        child: Builder(
          builder: (ctx) {
            if (vlcGlobalcontroller.value.isEnded ||
                vlcGlobalcontroller.value.hasError) {
              return Center(
                child: FittedBox(
                  child: IconButton(
                    onPressed: _replay,
                    color: _iconColor,
                    iconSize: _replayButtonIconSize,
                    icon: Icon(Icons.replay),
                  ),
                ),
              );
            }

            switch (vlcGlobalcontroller.value.playingState) {
              case PlayingState.initialized:
              case PlayingState.stopped:
              case PlayingState.paused:
                return SizedBox.expand(
                  child: Container(
                    color: Colors.black45,
                    child: FittedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () => _seekRelative(_seekStepBackward),
                            color: _iconColor,
                            iconSize: _seekButtonIconSize,
                            icon: Icon(Icons.replay_10),
                          ),
                          IconButton(
                            onPressed: _play,
                            color: _iconColor,
                            iconSize: _playButtonIconSize,
                            icon: Icon(Icons.play_arrow),
                          ),
                          IconButton(
                            onPressed: () => _seekRelative(_seekStepForward),
                            color: _iconColor,
                            iconSize: _seekButtonIconSize,
                            icon: Icon(Icons.forward_10),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              case PlayingState.buffering:
              case PlayingState.playing:
                return GestureDetector(onTap: _pause);

              case PlayingState.ended:
              case PlayingState.error:
                return Center(
                  child: FittedBox(
                    child: IconButton(
                      onPressed: _replay,
                      color: _iconColor,
                      iconSize: _replayButtonIconSize,
                      icon: Icon(Icons.replay),
                    ),
                  ),
                );
              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Future<void> _play() {
    return vlcGlobalcontroller.play();
  }

  Future<void> _replay() async {
    await vlcGlobalcontroller.stop();
    await vlcGlobalcontroller.play();
  }

  Future<void> _pause() async {
    if (vlcGlobalcontroller.value.isPlaying) {
      await vlcGlobalcontroller.pause();
    }
  }

  Future<void> _seekRelative(Duration seekStep) async {
    if (vlcGlobalcontroller.value.duration != null) {
      await vlcGlobalcontroller
          .seekTo(vlcGlobalcontroller.value.position + seekStep);
    }
  }
}
