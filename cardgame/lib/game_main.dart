import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cardgame/utils/logic.dart';
import 'package:cardgame/widgets/score_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/auth_controllers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const game());
}

class game extends StatefulWidget {
  const game({Key? key}) : super(key: key);

  @override
  _gamestate createState() => _gamestate();
}

class _gamestate extends State<game> {
  int tries = 0;
  int score = 0;
  bool _firstAttemptScoreTaken = false;
  final Game _game = Game();
  List<bool> isCardPressed = List.filled(16, false);
  final AuthController _authController = Get.put(AuthController());

  
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _playLocal();
    _game.initGame();
  }

  Future<void> _playLocal() async {
    _audioPlayer.open(
      Audio('assets/sound/sound.mp3'),
      autoStart: true,
      loopMode: LoopMode.single, // Adjust loop mode as needed
    );
  }

  void resetGame() {
    setState(() {
      tries = 0;
      score = 0;
      _firstAttemptScoreTaken = false;
      _game.initGame();
      isCardPressed = List.filled(16, false);
    });
  }

  @override
  void dispose() {
    // Dispose the audio player when the widget is disposed
    _audioPlayer.dispose();
    super.dispose();
  }

  late double screen_width;

  // make board
  @override
  Widget build(BuildContext context) {
    screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 56, 65, 137),
          actions: [
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                _authController.logout();
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 56, 65, 137),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("MEMBERISE",
                  style:
                      GoogleFonts.podkova(fontSize: 48, color: Colors.white)),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                scoreBoard("Tries", "${tries}"),
                scoreBoard("Score", "${score}")
              ],
            ),
            SizedBox(
              height: screen_width,
              width: screen_width,
              child: GridView.builder(
                  itemCount: _game.gameImg!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          // game logic
                          if (!_firstAttemptScoreTaken &&
                              !isCardPressed[index]) {
                            print(_game.cards_list[index]);
                            setState(() {
                              tries++;
                              _game.gameImg![index] = _game.cards_list[index];
                              _game.matchCheck
                                  .add({index: _game.cards_list[index]});
                              isCardPressed[index] = true;
                            });
                            if (_game.matchCheck.length == 2) {
                              if (_game.matchCheck[0].values.first ==
                                  _game.matchCheck[1].values.first) {
                                print("true");
                                score += 100;
                                _game.matchCheck.clear();
                              } else {
                                print(false);
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  print(_game.gameImg!);
                                  setState(() {
                                    _game.gameImg![_game.matchCheck[0].keys
                                        .first] = _game.hiddenCardpath;
                                    _game.gameImg![_game.matchCheck[1].keys
                                        .first] = _game.hiddenCardpath;
                                    _game.matchCheck.clear();
                                    isCardPressed = List.filled(16, false);
                                  });
                                });
                              }
                            }
                            if (score == 600) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Selamat, Anda Menang"),
                                    content: const Text("Mau mengulangi?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          resetGame(); // Add a function to reset the game
                                        },
                                        child: const Text("Ya"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          SystemNavigator
                                              .pop(); // Tutup aplikasi
                                        },
                                        child: const Text("Tidak"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: AssetImage(_game.gameImg![index]),
                              scale: 1,
                            ),
                          ),
                        ));
                  }),
            ),
          ],
        ));
  }
}
