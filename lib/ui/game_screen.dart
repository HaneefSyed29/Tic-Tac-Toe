import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ui/theme/color.dart';
import 'package:tic_tac_toe/utils/game_logic.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //Adding the necessary variables
  bool gameOver = false;
  String lastValue = "X";
  int turn = 0; //to check the draw
  String result = "";
  List<int> scoreBoard = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ]; // the score are for the different combination of game [Row1,2,3 Col1,2,3 Diagonal1,2]

  //Declaring a new Game Components
  Game game = Game();

  //init the GameBoard
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    double boardHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's $lastValue Turn".toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: boardWidth,
            height: boardHeight,
            child: GridView.count(
              crossAxisCount: Game.boardLength ~/
                  3, // the ~/ operator allows you to integer and return an Int as a result
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,

              children: List.generate(Game.boardLength, (index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1.5, color: Colors.white),
                  ),
                  child: InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                            //when we click we need to add the new value to the board and refresh the screen
                            //we need also to toggle the player
                            //we need to apply the click only if the field is empty
                            if (game.board![index] == "") {
                              setState(() {
                                game.board![index] = lastValue;
                                turn++;
                                gameOver = game.winnerCheck(
                                    lastValue, index, scoreBoard, 3);
                                if (gameOver) {
                                  result =
                                      "$lastValue is the Winner".toUpperCase();
                                } else if (!gameOver && turn == 9) {
                                  result = "It's a Draw!".toUpperCase();
                                  gameOver = true;
                                }
                              });
                              if (lastValue == "X") {
                                lastValue = "O";
                              } else {
                                lastValue = "X";
                              }
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
                                  ? Colors.yellow
                                  : Colors.pink,
                              fontSize: 64),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Text(result,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 40.0,
          ),
          SizedBox(
            width: boardWidth - 70,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: 1.5, color: Colors.white),
                  shape: const StadiumBorder(),
                  backgroundColor: MainColor.accentColor),
              onPressed: () {
                setState(() {
                  //erase the board
                  game.board = Game.initGameBoard();
                  lastValue = "X";
                  gameOver = false;
                  turn = 0;
                  result = "";
                  scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              child: const Text(
                "REPLAY",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
