import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

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
    return Stack(
      children: [
//vlc player
        VlcPlayer(
          aspectRatio: 16 / 9,
          controller: vlcGlobalcontroller,
          placeholder: Center(child: CircularProgressIndicator()),
        ),

//play, pause, and seek for 10 sec
        ControlsOverlay(),
      ],
    );
  }
}
