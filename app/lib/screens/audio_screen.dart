import 'package:app/screens/scan_screen.dart';
import 'package:app/widgets/MusicVisualizer.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen>
    with SingleTickerProviderStateMixin {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool _isPlaying = false;
  bool _isBuffering = false;
  //String _streamUrl = '';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text(
          'silentN0iiise',
          style:
              TextStyle(color: Color(0xFF3E3E3E), fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.popAndPushNamed(context, '/HomeScreen');
            assetsAudioPlayer.stop();
            setState(() {
              _isPlaying = false;
            });
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: _isBuffering
          ? const Center(
              child: SizedBox(
                child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                ),
                height: 70,
                width: 70,
              ),
            )
          : Center(
              child: Column(
                children: [
                  const Spacer(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          args.title.toString(),
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          args.description.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  _isPlaying
                      ? TextButton(
                          onPressed: () {
                            assetsAudioPlayer.stop();
                            setState(() {
                              _isPlaying = false;
                            });
                          },
                          child: const Icon(
                            Icons.stop_sharp,
                            size: 150,
                            color: Colors.greenAccent,
                          ),
                        )
                      : TextButton(
                          onPressed: () async {
                            setState(() {
                              _isBuffering = true;
                            });
                            try {
                              if (kIsWeb) {
                                print('web');
                                AssetsAudioPlayer.newPlayer().open(
                                  Audio.liveStream(args.url.toString()),
                                  autoStart: true,
                                );
                              } else {
                                print('native');
                              }
                              await assetsAudioPlayer.open(
                                Audio.liveStream(args.url.toString()),
                              );
                              setState(() {
                                _isPlaying = true;
                                _isBuffering = false;
                              });
                            } catch (t) {}
                          },
                          child: const Icon(
                            Icons.play_arrow,
                            size: 150,
                            color: Colors.greenAccent,
                          ),
                        ),
                  const Spacer(),
                  _isPlaying
                      ? SizedBox(height: 100, child: Musicvisualizer())
                      : const SizedBox(height: 100),
                  const Spacer(),
                ],
              ),
            ),
    );
  }
}
