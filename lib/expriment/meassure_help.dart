import 'dart:async';
import 'dart:io';
import 'package:tct/components/stepbutton_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/reusable_card.dart';
import 'package:tct/globals/global_variables.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tct/globals/constants_ui.dart';

class MeasureHelpPage extends StatefulWidget {
  final bool metricUnit;

  MeasureHelpPage(
      {required Key key,
      required this.metricUnit,
      required RouteSettings settings})
      : super(key: key);

  @override
  _MeasureHelpPageState createState() => _MeasureHelpPageState(metricUnit);
}

// Removed redundant openGallery function

class _MeasureHelpPageState extends State<MeasureHelpPage> {
  bool metricUnit;

  _MeasureHelpPageState(this.metricUnit);

  Color caughtColor = Colors.grey;

  double redLength = 30.0;
  double blueLength = 20.0;

  double kMinArrowLeftRight = -300.0;
  double kMaxArrowLeftRight = deviceWidth;
  double stepArrowLeftRight = 1.0;
  double kMinArrowUpDown = -30.0;
  double kMaxArrowUpDown = 30.0;
  double stepArrowUpDown = 1.0;

  XFile? imageFile;

  void _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    var picture = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  void openGallery(BuildContext context) async {
    final picker = ImagePicker();
    var picture = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialogDuplicate(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () {
                    openGallery(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    _openCamera(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text('No image file');
    } else {
      return Image.file(
        File(imageFile!.path),
        height: picWidth,
      );
    }
  }

  void resetAll() {
    blueX = 0.0;
    blueY = 0.0;
    redX = 0.0;
    redY = 0.0;
    blueLength = 30.0;
    redLength = 30.0;
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () {
                    openGallery(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    _openCamera(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: logoSize,
                height: logoSize,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/turbo_appbar_logo.png'),
                    ))),
            Text(
              'Messure Help',
              style: kAppBarTextStyle,
              textScaleFactor: textScaleFactorTc,
            ),
            Container(width: 30.0),
          ],
        ),
      ),
      body: Builder(builder: (context) {
        //var appBarHeight = MediaQuery.of(context).padding.top;
        picWidth = MediaQuery.of(context).size.width;
        picHeight = MediaQuery.of(context).size.height;
        //print('appBarHeight $appBarHeight');
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  //Cent
                  //
                  // er(child: Text('Anders')),
                  Center(
                    child: Column(
                      children: <Widget>[
                        _decideImageView(),
                        ElevatedButton(
                          onPressed: () {
                            _showChoiceDialog(context);
                            resetAll();
                          },
                          child: Text('Select Image'),
                        ),
                      ],
                    ),
                  ),
                  //ImageAssets(),

//                  DragBox(Offset(200.0, 100.0), 'W', Colors.blueAccent, blueLength, 10),
                  DragBox(Offset((picWidth - 15) + blueX, blueY + 15), 'B',
                      Colors.blue, 10, blueLength),
                  DragBox(Offset((picWidth - 15) + redX, redY + 15), 'A',
                      Colors.red, 10, redLength),
                ],
              ),
              ReusableCard(
                onPress: () {},
                colour: kActiveCardColourOutput,
                cardChild: Column(
                  children: <Widget>[
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StepButtonClose(
                            icon: FontAwesomeIcons.arrowLeft,
                            onStepPress: () {
                              timer = Timer.periodic(
                                  Duration(milliseconds: tapTime), (t) {
                                setState(() {
                                  if (blueX > kMinArrowLeftRight) {
                                    blueX = blueX - stepArrowLeftRight;
                                    print('Left1 blueX $blueX');
                                  }
                                  print('Left2 blueX $blueX');
                                });
                              });
                            },
                            onPressEnd: () {
                              timer.cancel();
                            },
                            onStep: () {
                              setState(() {
                                if (blueX > kMinArrowLeftRight) {
                                  blueX = blueX - stepArrowLeftRight;
                                  print('Left blueX $blueX');
                                }
                              });
                            }),
                        Column(
                          children: <Widget>[
                            StepButtonClose(
                                icon: FontAwesomeIcons.arrowUp,
                                onStepPress: () {
                                  timer = Timer.periodic(
                                      Duration(milliseconds: tapTime), (t) {
                                    setState(() {
                                      if (blueY > kMinArrowUpDown) {
                                        blueY = blueY - stepArrowUpDown;
                                        print('Left1 blueY $blueY');
                                      }
                                      print('Left2 blueY $blueY');
                                    });
                                  });
                                },
                                onPressEnd: () {
                                  timer.cancel();
                                },
                                onStep: () {
                                  setState(() {
                                    if (blueY > kMinArrowUpDown) {
                                      blueY = blueY - stepArrowUpDown;
                                      print('Left blueY $blueY');
                                    }
                                  });
                                }),
                            StepButtonClose(
                                icon: FontAwesomeIcons.arrowDown,
                                onStepPress: () {
                                  timer = Timer.periodic(
                                      Duration(milliseconds: tapTime), (t) {
                                    setState(() {
                                      if (blueY < kMaxArrowUpDown) {
                                        blueY = blueY + stepArrowUpDown;
                                        print('Right blueY $blueY');
                                      }
                                    });
                                  });
                                },
                                onPressEnd: () {
                                  timer.cancel();
                                },
                                onStep: () {
                                  setState(() {
                                    if (blueY < kMaxArrowUpDown) {
                                      blueY = blueY + stepArrowUpDown;
                                      print('Right blueY $blueY');
                                    }
                                  });
                                }),
                          ],
                        ),
                        StepButtonClose(
                            icon: FontAwesomeIcons.arrowRight,
                            onStepPress: () {
                              timer = Timer.periodic(
                                  Duration(milliseconds: tapTime), (t) {
                                setState(() {
                                  if (blueX < kMaxArrowLeftRight) {
                                    blueX = blueX + stepArrowLeftRight;
                                    print('Right blueX $blueX');
                                  }
                                });
                              });
                            },
                            onPressEnd: () {
                              timer.cancel();
                            },
                            onStep: () {
                              setState(() {
                                if (blueX < kMaxArrowLeftRight) {
                                  blueX = blueX + stepArrowLeftRight;
                                  print('Right blueX $blueX');
                                }
                              });
                            }),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Size',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.red,
                            thumbColor: Colors.blueGrey,
                            valueIndicatorColor: Colors.blue,
                            overlayColor: Colors.blueAccent,
                            inactiveTrackColor: Colors.white,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 15.0),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 30.0),
                          ),
                          child: Slider(
                              value: redLength,
                              min: 20.0,
                              max: 400.0,
                              inactiveColor: Color(0xFF8D8E89),
                              divisions: 80,
                              onChanged: (double value) {
                                setState(() {
                                  redLength = value;
                                });
                              }),
                        ),
                      ],
                    ),
                    //SizedBox(height: 20),
                  ],
                ),
              ),

//              Column(
//                children: <Widget>[
//                  SliderTheme(
//                    data: SliderTheme.of(context).copyWith(
//                      activeTrackColor: Colors.red,
//                      thumbColor: Colors.red,
//                      valueIndicatorColor: Colors.blue,
//                      overlayColor: Colors.blueAccent,
//                      inactiveTrackColor: Colors.white,
//                      thumbShape:
//                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
//                      overlayShape:
//                          RoundSliderOverlayShape(overlayRadius: 30.0),
//                    ),
//                    child: Slider(
//                        value: blueX,
//                        min: kMinArrowLeftRight,
//                        max: kMaxArrowLeftRight,
//                        inactiveColor: Color(0xFF8D8E89),
//                        divisions: 60,
//                        onChanged: (double value) {
//                          setState(() {
//                            blueX = value;
//                            print(picHeight);
//                            print(picWidth);
//                          });
//                        }),
//                  ),
//                  //Text(blueX.toString()),
//                ],
//              ),
            ],
          ),
        );
      }),
    );
  }
}

class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;
  final double objectWidth;
  final double objectHeight;

  DragBox(this.initPos, this.label, this.itemColor, this.objectWidth,
      this.objectHeight);

  @override
  DragBoxState createState() => DragBoxState();
}

double blueX = 0.0;
double blueY = 0.0;
double redX = 0.0;
double redY = 0.0;

class DragBoxState extends State<DragBox> {
  Offset position = Offset(blueX, blueY);

  late Size preferredSize;

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print('Set state position $position');
  }

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
    print('Init position $position');
    print(picHeight);
    print(picWidth);
    setState(() {
      // ImageAssets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
          left: position.dx + blueX,
          top: position.dy + blueY,
          child: Column(
            children: <Widget>[
              // Text(blueX.toString()),
              // Text(blueY.toString()),
              Draggable(
                data: widget.itemColor,
                child: Container(
                  width: widget.objectWidth,
                  height: widget.objectHeight,
                  color: widget.itemColor,
                  child: Center(
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 8.0,
                      ),
                    ),
                  ),
                ),
                onDraggableCanceled: (velocity, offset) {
                  setState(() {
                    print(offset);
                    print(offset.dy);
                    print('kToolbarHeight $kToolbarHeight');
                    print(position.dx);
                    print(position.dy);
                    position = Offset(
                        offset.dx,
                        offset.dy -
                            (kToolbarHeight + (kToolbarHeight / 3 + 1)));

                    // position = offset;
                  });
                },
                feedback: Container(
                  width: widget.objectWidth,
                  height: widget.objectHeight,
                  color: widget.itemColor.withOpacity(0.7),
                  child: Center(
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 8.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class ImageAssets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/pipe.png');
    Image image = Image(
      image: assetImage,
    );

    return Container(child: image);
  }
}

//Image(image: AssetImage('images/tc_icon.png')
