import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AudioScreen extends StatefulWidget {
  AudioScreen({Key? key}) : super(key: key);

  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool _isPlaying = false;
  bool _isBuffering = false;
  String _streamUrl =
      'https://jazzloft.stream.laut.fm/jazzloft?t302=2021-08-12_22-25-52&uuid=06aa8aa6-3713-4aa0-acec-15f58c148cfa';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: _isBuffering
            ? Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    color: NeumorphicTheme.defaultTextColor(context),
                  ),
                  height: 70,
                  width: 70,
                ),
              )
            : Center(
                child: Column(
                  children: [
                    Spacer(),
                    NeumorphicText(
                      "silentN0iiise",
                      style: NeumorphicStyle(
                        depth: 5, //customize depth here
                        color: Color(0xFF3E3E3E), //customize color here
                      ),
                      textStyle: NeumorphicTextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold //customize size here
                          // AND others usual text style properties (fontFamily, fontWeight, ...)
                          ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Placeholder(),
                    ),
                    Spacer(),
                    _isPlaying
                        ? NeumorphicButton(
                            style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.circle(),
                            ),
                            padding: EdgeInsets.all(18),
                            margin: EdgeInsets.all(18),
                            onPressed: () {
                              assetsAudioPlayer.stop();
                              setState(() {
                                _isPlaying = false;
                              });
                            },
                            child: Icon(
                              Icons.stop_sharp,
                              size: 50,
                              color: Colors.grey[800],
                            ),
                          )
                        : NeumorphicButton(
                            style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.circle(),
                            ),
                            padding: EdgeInsets.all(18),
                            margin: EdgeInsets.all(18),
                            onPressed: () async {
                              setState(() {
                                _isBuffering = true;
                              });
                              try {
                                if (kIsWeb) {
                                  print('web');
                                  AssetsAudioPlayer.newPlayer().open(
                                    Audio.liveStream(_streamUrl),
                                    autoStart: true,
                                  );
                                } else {
                                  print('native');
                                }
                                await assetsAudioPlayer.open(
                                  Audio.liveStream(_streamUrl),
                                );

                                setState(() {
                                  _isPlaying = true;
                                  _isBuffering = false;
                                });
                              } catch (t) {}
                            },
                            child: Icon(
                              Icons.play_arrow,
                              size: 50,
                              color: Colors.grey[800],
                            ),
                          ),
                    Spacer(),
                  ],
                ),
              ),
      ),
    );
  }
}
