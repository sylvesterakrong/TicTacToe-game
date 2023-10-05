//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/ui/theme/color.dart';
import 'package:tictactoe/utils/game_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver = false;
  List<int> scoreboard = [0,0,0,0,0,0];

  Game game = Game();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    //print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("It's $lastValue turn".toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 58)),
            const SizedBox(height: 20.0),
            Container(
              width: boardwidth,
              height: boardwidth,
              child: GridView.count(
                crossAxisCount: Game.boardlenth ~/ 3,
                padding: const EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardlenth, (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                          if (game.board![index] =="") {
                              setState(() {
                              game.board![index] = lastValue;
                              if (lastValue == "X") {
                                lastValue = "O";
                              } else {
                                lastValue = "X";
                              }
                            });
                          }
                          
                          },
                    child: Container(
                      width: Game.blocsize,
                      height: Game.blocsize,
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.blue
                                : Colors.pink,
                            fontSize: 64.0,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  game.board = Game.initGameBoard();
                  lastValue = "X";
                });
              },
              icon: const Icon(Icons.replay),
              label: const Text("Repeat the GAME!"),
            ),
          ],
        ));
  }
}
