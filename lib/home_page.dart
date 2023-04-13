import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double currentvol = 0.5;
  double brightness = 0.0;

  @override
  void initState() {
    super.initState();
    initPlatformBrightness();
    PerfectVolumeControl.hideUI = false; //set if system UI is hided or not on volume up/down
    Future.delayed(Duration.zero,() async {
      currentvol = await PerfectVolumeControl.getVolume();
      setState(() {
        //refresh UI
      });
    });

    PerfectVolumeControl.stream.listen((volume) {
      setState(() {
        currentvol = volume;
      });
    });
    super.initState();
  }

  Future<void> initPlatformBrightness() async {
    double bright;
    try {
      bright = await FlutterScreenWake.brightness;
    } on PlatformException {
      bright = 1.0;
    }
    if (!mounted) return;

    setState(() {
      brightness = bright;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff222222),
      body: SliderTheme(
        data: const SliderThemeData(
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.black26,
          thumbColor: Colors.white
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: const Color(0xff222222),
                    child: Container(
                      width: 80,
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xff222222),
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff222222),
                            Color(0xff222222),
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff000000),
                            offset: Offset(5, 5),
                            blurRadius: 15,
                            spreadRadius: 4,
                          ),
                          BoxShadow(
                            color: Color(0xff333333),
                            offset: Offset(-5, -5),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(Icons.sunny, size: 40, color: Colors.white,),
                          RotatedBox(
                            quarterTurns: 3,
                            child: Slider(
                              value: brightness,
                              onChanged: (value) {
                                setState(() {
                                  brightness = value;
                                });
                                FlutterScreenWake.setBrightness(brightness);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        brightness = 0;
                      });
                    },
                    child: Container(
                      color: const Color(0xff222222),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xff222222),
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff222222),
                              Color(0xff222222),
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff000000),
                              offset: Offset(5, 5),
                              blurRadius: 15,
                              spreadRadius: 4,
                            ),
                            BoxShadow(
                              color: Color(0xff333333),
                              offset: Offset(-5, -5),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.dark_mode, size: 40, color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: const Color(0xff222222),
                    child: Container(
                      width: 80,
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xff222222),
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff222222),
                            Color(0xff222222),
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff000000),
                            offset: Offset(5, 5),
                            blurRadius: 15,
                            spreadRadius: 4,
                          ),
                          BoxShadow(
                            color: Color(0xff333333),
                            offset: Offset(-5, -5),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(Icons.volume_up, size: 40, color: Colors.white,),
                          RotatedBox(
                            quarterTurns: 3,
                            child: Slider(
                              value: currentvol,
                              onChanged: (newvol){
                                currentvol = newvol;
                                PerfectVolumeControl.setVolume(newvol); //set new volume
                                setState(() {

                                });
                              },
                              min: 0, //
                              max:  1,
                              divisions: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        currentvol = 0;
                      });
                    },
                    child: Container(
                      color: const Color(0xff222222),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xff222222),
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff222222),
                              Color(0xff222222),
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff000000),
                              offset: Offset(5, 5),
                              blurRadius: 15,
                              spreadRadius: 4,
                            ),
                            BoxShadow(
                              color: Color(0xff333333),
                              offset: Offset(-5, -5),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.volume_off, size: 40, color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
