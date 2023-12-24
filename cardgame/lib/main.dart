import 'package:cardgame/utils/logic.dart';
import 'package:cardgame/widgets/score_board.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tries = 0;
  int score = 0;
  // start initiate game
  Game _game = Game();
  @override
  void initState(){
    super.initState();
    _game.initGame();
  }

  late double screen_width;
  // make board
  @override
  Widget build(BuildContext context) {
  screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xFFe55870),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "MEMORY GAME",
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
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
                      crossAxisCount: 3,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      ), 
                      padding: const EdgeInsets.all(16.0),
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          // game logic
                          print(_game.cards_list[index]);
                          setState(() {
                            tries++;
                            _game.gameImg![index] = _game.cards_list[index];
                            _game.matchCheck.add({index: _game.cards_list[index]});
                          });
                          if(_game.matchCheck.length == 2){
                            if(_game.matchCheck[0].values.first == _game.matchCheck[1].values.first){
                              print("true");
                              score += 100;
                              _game.matchCheck.clear();
                            } else {
                              print(false);
                              Future.delayed(const Duration(milliseconds: 100), (){
                                print(_game.gameImg!);
                                setState(() {
                                  _game.gameImg![_game.matchCheck[0].keys.first] = _game.hiddenCardpath;
                                  _game.gameImg![_game.matchCheck[1].keys.first] = _game.hiddenCardpath;
                                  _game.matchCheck.clear();
                                });
                              });
                            }
                          }
                        },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFB46A),
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage(_game.gameImg![index]),
                                fit: BoxFit.cover,
                                ),
                            ),
                          )
                        );
                    }),
              ),
          ],
        ));
  }
}
