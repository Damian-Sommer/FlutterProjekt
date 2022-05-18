// ignore_for_file: deprecated_member_use, unused_local_variable, empty_catches, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController inputReiheNr = TextEditingController();
  String getuName = "";
  String board = "";
  String errorMessage = "";
  String getPass = "";
  String currentPlayer = "x";
  int currentPlayersColumn = -1;
  int currentPlayersRow = -1;
  String message = "";
  bool firstTime = true;
  int playerID = 0;
  var twoDList;
  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      createBoard();
      firstTime = false;
    }
    outputBoard();
    return Scaffold(
        appBar: AppBar(
          title: const Text("4 Gewinnt"),
        ),
        body: Center(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextField(
                controller: inputReiheNr,
                decoration: const InputDecoration(
                  hintText: "Spalte",
                  labelText: "Input Spalte",
                  labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                autocorrect: false,
                enableSuggestions: false,
                //style: TextStyle(decoration: TextDecoration.none),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (updateBoard(inputReiheNr.text, playerID)) {
                        playerID = playerID + 1;
                        if (isWon(currentPlayersColumn, currentPlayersRow)) {
                          print(currentPlayer + " won the game!");
                        }
                      }
                      outputBoard();
                      currentPlayerUpdate();
                    });
                  },
                  child: Text("Absenden")),
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  "Player " + currentPlayer + "'s turn",
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  "0 1 2 3 4 5 6",
                  style: TextStyle(
                    fontSize: 12.5,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black,
                    decorationThickness: 2,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  board,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: Text(
                  message + "\n",
                  style: TextStyle(color: Color.fromARGB(255, 252, 33, 17)),
                ),
              ),
            ],
          ),
        ));
  }

  void createBoard() {
    this.twoDList =
        List.generate(6, (i) => List.filled(7, "*"), growable: false);

    /*for (int i = 2; i < 4; i++) {
      twoDList[0][i] = "o";
    }
    twoDList[2][1] = "x";*/
  }

  void outputBoard() {
    String ausgabe = "";
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 7; j++) {
        ausgabe += twoDList[i][j] + " ";
      }
      ausgabe += "\n";
    }
    board = ausgabe;
  }

  void currentPlayerUpdate() {
    if (playerID == 0) {
      currentPlayer = "x";
    } else if (playerID % 2 == 0) {
      currentPlayer = "x";
    } else {
      currentPlayer = "o";
    }
  }

  bool checkVertical(int column, int row) {
    int minRow = row;
    int maxRow = row;

    while (minRow > 0 && twoDList[minRow - 1][column] == currentPlayer) {
      minRow--;
    }
    while (maxRow < 6 - 1 && twoDList[maxRow + 1][column] == currentPlayer) {
      maxRow++;
    }
    if (maxRow - minRow + 1 >= 4) {
      return true;
    }

    return false;
  }

  bool checkHorizontal(int column, int row) {
    int minColumn = column;
    int maxColumn = column;

    while (minColumn > 0 && twoDList[row][minColumn - 1] == currentPlayer) {
      minColumn--;
    }
    while (maxColumn < 6 - 1 && twoDList[row][maxColumn + 1] == currentPlayer) {
      maxColumn++;
    }
    print(maxColumn);
    print(minColumn);
    if (maxColumn - minColumn + 1 >= 4) {
      return true;
    }

    return false;
  }

  bool checkDiagonalSlash(int column, int row) {
    int minColumn = column;
    int maxColumn = column;
    int minRow = row;
    int maxRow = row;

    while (minColumn > 0 &&
        maxRow < 6 - 1 &&
        twoDList[maxRow + 1][minColumn - 1] == currentPlayer) {
      minColumn--;
      maxRow++;
    }

    while (maxColumn < 7 - 1 &&
        minRow > 0 &&
        twoDList[minRow - 1][maxColumn + 1] == currentPlayer) {
      maxColumn++;
      minRow--;
    }
    if (maxColumn - minColumn + 1 >= 4) {
      return true;
    }
    return false;
  }

  bool checkDiagonalBackSlash(int column, int row) {
    int numSame = 1;
    int minColumn = column;
    int maxColumn = column;
    int minRow = row;
    int maxRow = row;

    while (minColumn > 0 &&
        minRow > 0 &&
        twoDList[minRow - 1][minColumn - 1] == currentPlayer) {
      minColumn--;
      minRow--;
    }

    while (maxColumn < 7 - 1 &&
        maxRow < 6 - 1 &&
        twoDList[maxRow + 1][maxColumn + 1] == currentPlayer) {
      maxColumn++;
      maxRow++;
    }
    if (maxColumn - minColumn + 1 >= 4) {
      return true;
    }
    return false;
  }

  bool isWon(int column, int row) {
    if (checkHorizontal(column, row) ||
        checkVertical(column, row) ||
        checkDiagonalSlash(column, row) ||
        checkDiagonalBackSlash(column, row)) {
      return true;
    }
    return false;
  }

  bool updateBoard(String strColumn, int playerNr) {
    int column;
    if (strColumn == null) {
      message = "Gib eine Zahl ein zwischen 0 und 7!";
      return false;
    }
    try {
      column = int.parse(strColumn);
    } catch (Exception) {
      message = "Gib eine Zahl ein zwischen 0 und 7!";
      return false;
    }

    if (column > 6 || column < 0) {
      message = "Bitte gebe eien Zahl von 0 - 6 ein!";
      return false;
    }

    if (this.twoDList[0][column] != "*") {
      return false;
    }

    int row = 0;
    while (row < 5 && this.twoDList[row + 1][column] == "*") {
      row++;
    }

    /*if (isfull(reiheID)) {
      print("Game Finished");
      return "Game Finished";
    } else {*/

    String outputSymbol = "";
    if (playerID % 2 == 0) {
      outputSymbol = "x";
    } else {
      outputSymbol = "o";
    }
    this.twoDList[row][column] = outputSymbol;
    this.currentPlayersColumn = column;
    this.currentPlayersRow = row;
    return true;
  }
}
