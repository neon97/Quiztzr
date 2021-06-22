import 'package:edgeclass/constants/data.dart';
import 'package:edgeclass/widgets.dart/appbackground.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'Animations/optionBoxAnimate.dart';
import 'Animations/showUp.dart';

class QuixHome extends StatefulWidget {
  @override
  _QuixHomeState createState() => _QuixHomeState();
}

class _QuixHomeState extends State<QuixHome> {
  //datatypes
  bool visibleMainBox = true;

  SizedBox _spacer = SizedBox(
    height: 10,
  );
  TextStyle _textStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return ScafTile(
        widgeter: Scaffold(
            backgroundColor: Colors.transparent,
            body: backGround(
                AnimatedOpacity(
                  opacity: visibleMainBox ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
//header

                      Expanded(
                        flex: 1,
                        child: ShowUp(
                          child: Text(
                            listQuestions[0]["data"]["metadata"]["microConcept"]
                                    [0]["label"]
                                .toString(),
                            style: _textStyle,
                            textAlign: TextAlign.center,
                          ),
                          delay: 10,
                        ),
                      ),

//show up animation

                      Expanded(
                        flex: 1,
                        child: ShowUp(
                          child: Text(
                            listQuestions[0]["data"]["stimulus"].toString(),
                            style: _textStyle,
                            textAlign: TextAlign.center,
                          ),
                          delay: 10,
                        ),
                      ),

                      _spacer,

//circularProgressIndicatio
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: SfRadialGauge(
                            enableLoadingAnimation: true,
                            axes: <RadialAxis>[
                              RadialAxis(
                                  showLabels: false,
                                  showTicks: false,
                                  minimum: 0,
                                  maximum: 100,
                                  startAngle: 270,
                                  endAngle: 270,
                                  axisLineStyle: const AxisLineStyle(
                                      thicknessUnit: GaugeSizeUnit.factor,
                                      thickness: 0.03),
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        angle: 180,
                                        widget: Text(
                                          "0:08",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 35),
                                        )),
                                  ],
                                  pointers: <GaugePointer>[
                                    RangePointer(
                                      value: 90,
                                      width: 12,
                                      pointerOffset: -6,
                                      cornerStyle: CornerStyle.bothCurve,
                                      enableAnimation: true,
                                      animationDuration: 1200,
                                      animationType: AnimationType.ease,
                                      sizeUnit: GaugeSizeUnit.logicalPixel,
                                      // color: const Color(0xFFF67280),
                                      gradient: const SweepGradient(
                                          colors: <Color>[
                                            Color(0xFFFF7676),
                                            Color(0xFFF54EA2)
                                          ],
                                          stops: <double>[
                                            0.25,
                                            0.75
                                          ]),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),

                      _spacer,

//options
                      Expanded(
                          flex: 5,
                          child: GridView.count(
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 25,
                            crossAxisCount: 2,
                            children: [
                              for (int i = 0; i < 4; i++)
                                OptionAnimate(
                                  delay: i * 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 20,
                                        backgroundColor: bgColor,
                                        child: Text(
                                          listQuestions[0]["data"]["options"][i]
                                                  ["value"]
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        listQuestions[0]["data"]["options"][i]
                                                ["label"]
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                EdgeInsets.fromLTRB(30, 50, 30, 0))));
  }
}
