import 'package:edgeclass/constants/videPaths.dart';
import 'package:edgeclass/constants/video_player/vlc_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import '../data.dart';

class Player extends StatefulWidget {
  final String fileName;
  Player({@required this.fileName});
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  void initState() {
    super.initState();
    vlcGlobalcontroller = VlcPlayerController.network(
      // Constants.elephantDreamStreamUrl,
      widget.fileName,
      hwAcc: HwAcc.FULL,
      autoPlay: true,

      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([
          VlcAdvancedOptions.networkCaching(2000),
        ]),
        rtp: VlcRtpOptions([
          VlcRtpOptions.rtpOverRtsp(true),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: VlcPlayerWithControls(
        fileName: widget.fileName,
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await vlcGlobalcontroller.stopRendererScanning();
    await vlcGlobalcontroller.dispose();
  }
}
