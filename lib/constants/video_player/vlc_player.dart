import 'dart:async';
import 'package:edgeclass/Constants/video_player/durationConvert.dart';
import 'package:edgeclass/constants/router.dart';
import 'package:edgeclass/screens/QuizPage/quizHome.dart';
import 'package:edgeclass/screens/VideoPage/showNotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../data.dart';
import 'overlay.dart';

class VlcPlayerWithControls extends StatefulWidget {
  final String fileName;

  VlcPlayerWithControls({@required this.fileName});

  @override
  VlcPlayerWithControlsState createState() => VlcPlayerWithControlsState();
}

class VlcPlayerWithControlsState extends State<VlcPlayerWithControls>
    with AutomaticKeepAliveClientMixin {
  //
  final double initSnapshotRightPosition = 10;
  final double initSnapshotBottomPosition = 10;

  //
  double sliderValue = 0.0;
  double volumeValue = 50;
  String position = '';
  String duration = '';
  int numberOfCaptions = 0;
  int numberOfAudioTracks = 0;
  bool validPosition = false;
  bool showPlaybackSppeed = false;

  //
  List<double> playbackSpeeds = [0.5, 1.0, 2.0];
  int playbackSpeedIndex = 1;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    vlcGlobalcontroller.addListener(listener);
  }

  @override
  void dispose() {
    vlcGlobalcontroller.removeListener(listener);
    super.dispose();
  }

  void listener() async {
    if (!mounted) return;
    //
    if (vlcGlobalcontroller.value.isInitialized) {
      var oPosition = vlcGlobalcontroller.value.position;
      var oDuration = vlcGlobalcontroller.value.duration;
      vlcPlayedPosition = oPosition;

//logic for handling and showing the notes
      if (showNoteOnly) {
        for (int i = 0; i < listStopaageDurations.length; i++) {
          Duration _temp = parseDuration(listStopaageDurations[i].duration);
          if (vlcPlayedPosition.inSeconds == _temp.inSeconds) {
            vlcGlobalcontroller.pause();
            showingNotesDialog(
                context, listStopaageDurations[i].notes, vlcPlayedPosition);
          }
        }
      }

//logic for hadling the route on end of the video
      if (vlcGlobalcontroller.value.isEnded) {
        routeTo(context, QuixHome());
      }
      if (oPosition != null && oDuration != null) {
        if (oDuration.inHours == 0) {
          var strPosition = oPosition.toString().split('.')[0];
          var strDuration = oDuration.toString().split('.')[0];
          position =
              "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
          duration =
              "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
        } else {
          position = oPosition.toString().split('.')[0];
          duration = oDuration.toString().split('.')[0];
        }
        validPosition = oDuration.compareTo(oPosition) >= 0;
        sliderValue = validPosition ? oPosition.inSeconds.toDouble() : 0;
      }
      numberOfCaptions = vlcGlobalcontroller.value.spuTracksCount;
      numberOfAudioTracks = vlcGlobalcontroller.value.audioTracksCount;

      //
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AspectRatio(
      aspectRatio: 16 / 9.5,
      child: Container(
        child: Stack(
          children: [
//vlc player
            VlcPlayer(
              aspectRatio: 16 / 9,
              controller: vlcGlobalcontroller,
              placeholder: Center(
                child: SpinKitPouringHourglass(
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),

//playback speed data
            showPlaybackSppeed
                ? Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black45),
                      child: Text(
                        '${playbackSpeeds.elementAt(playbackSpeedIndex)}x',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),

//position & duration
            Positioned(
              left: 10,
              bottom: 15,
              child: Text(
                "$position / $duration",
                style: TextStyle(color: Colors.white),
              ),
            ),

//slider seeking video
            Positioned(
              bottom: 2.0,
              left: -25,
              child: Container(
                width: deviceWidth + deviceWidth / 7,
                height: 10,
                child: SliderTheme(
                  data: SliderThemeData(
                      trackHeight: 2,
                      thumbColor: Colors.redAccent,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 6.0)),
                  child: Slider(
                    activeColor: Colors.red,
                    inactiveColor: Colors.white70,
                    value: sliderValue,
                    min: 0.0,
                    max: (!validPosition &&
                            vlcGlobalcontroller.value.duration == null)
                        ? 1.0
                        : vlcGlobalcontroller.value.duration.inSeconds
                            .toDouble(),
                    onChanged: validPosition ? _onSliderPositionChanged : null,
                  ),
                ),
              ),
            ),

//play, pause, and seek for 10 sec
            ControlsOverlay(),

//playback speeed action
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  icon: Icon(
                    MaterialCommunityIcons.play_speed,
                    color: Colors.white,
                  ),
                  onPressed: _cyclePlaybackSpeed),
            ),

//fulScreen action
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  icon: Icon(
                    MaterialCommunityIcons.play_speed,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    // await vlcGlobalcontroller.options.adv
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _onSliderPositionChanged(double progress) {
    setState(() {
      showNoteOnly = false;
      sliderValue = progress.floor().toDouble();
    });

    //convert to Milliseconds since VLC requires MS to set time
    vlcGlobalcontroller.setTime(sliderValue.toInt() * 1000);
  }

  hidePlayBackSpeed() {
    setState(() {
      showPlaybackSppeed = false;
    });
  }

  void _cyclePlaybackSpeed() async {
    Timer(Duration(seconds: 2), hidePlayBackSpeed);
    playbackSpeedIndex++;
    if (playbackSpeedIndex >= playbackSpeeds.length) {
      playbackSpeedIndex = 0;
    }
    setState(() {
      showPlaybackSppeed = true;
    });
    return await vlcGlobalcontroller
        .setPlaybackSpeed(playbackSpeeds.elementAt(playbackSpeedIndex));
  }
}
