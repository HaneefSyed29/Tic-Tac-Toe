class Player {
  static const x = "X";
  static const o = "o";
  static const empty = "";
}

class Game {
  static const boardLength = 9; //we will create a board of 3*3 blocks
  static const blocsize = 100.0;

  //Creating the empty board
  List<String>? board;

  static List<String> initGameBoard() =>
      List.generate(boardLength, (index) => Player.empty);

  //algorithm to check the winner
  //for winner we need to declare scoreboard in the main file

  bool winnerCheck(
      String player, int index, List<int> scoreboard, int gridSize) {
    //first we have to declare the row and col
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 : -1;

    scoreboard[row] += score;
    scoreboard[gridSize + col] += score;

    if (row == col) scoreboard[2 * gridSize] += score;
    if (gridSize - 1 - col == row) scoreboard[2 * gridSize + 1] += score;

    //checking if we have 3 or -3 in the score board
    if (scoreboard.contains(3) || scoreboard.contains(-3)) return true;

    //by default it will return false
    return false;
  }
}
