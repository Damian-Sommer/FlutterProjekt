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
  int playerXPoints = 0;
  int playerOPoints = 0;
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
              Text("Spieler x: " + playerXPoints.toString() + "\nSpieler o: " + playerOPoints.toString()),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (updateBoard(inputReiheNr.text, playerID)) {
                        playerID = playerID + 1;
                        if (isWon(currentPlayersColumn, currentPlayersRow)) {
                          print("Spieler " + currentPlayer + " hat das Spiel gewonnen!");
                          switch (currentPlayer) {
                            case "x":
                              playerXPoints++;
                              break;
                            case "o":
                              playerOPoints++;
                              break;
                            default:
                          }
                          playerID = 0;
                          createBoard();
                          outputBoard();
                          currentPlayerUpdate();
                        }
                      }
                      outputBoard();
                      currentPlayerUpdate();
                    });
                  },
                  child: Text("Absenden")),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      print("Das Spiel wurde neugestartet");
                      playerOPoints = 0;
                      playerXPoints = 0;
                      playerID = 0;
                      createBoard();
                      outputBoard();
                      currentPlayerUpdate();
                    });
                  },
                  child: Text("Neustarten")),
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  "Spieler " + currentPlayer + " ist dran",
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

  bool checkVertical(int col, int row) {
    int min = row;
    int max = row;

    while (true) {
      if (min > 0 && twoDList[min - 1][col] == currentPlayer) {
        min--;
      } else {
        break;
      }
    }
    while (true) {
      if (max < 5 && twoDList[max + 1][col] == currentPlayer) {
        max++;
      } else {
        break;
      }
    }

    if (max - min >= 3) {
      return true;
    }

    return false;
  }

  bool checkHorizontal(int col, int row) {
    int min = col;
    int max = col;

    while (true) {
      if (min > 0 && twoDList[row][min - 1] == currentPlayer) {
        min--;
      } else {
        break;
      }
    }
    while (true) {
      if (max < 5 && twoDList[row][max + 1] == currentPlayer) {
        max++;
      } else {
        break;
      }
    }

    if (max - min >= 3) {
      return true;
    }

    return false;
  }

  bool checkDiagonalSlash(int col, int row) {
    int minCol = col;
    int maxCol = col;
    int minRow = row;
    int maxRow = row;

    while (true) {
      if (minCol > 0 && maxRow < 5 && twoDList[maxRow + 1][minCol - 1] == currentPlayer) {
        minCol--;
        maxRow++;
      } else {
        break;
      }
    }
    while (true) {
      if (maxCol < 6 && minRow > 0 && twoDList[minRow - 1][maxCol + 1] == currentPlayer) {
        maxCol++;
        minRow--;
      } else {
        break;
      }
    }

    if (maxCol - minCol >= 3) {
      return true;
    }
    return false;
  }

  bool checkDiagonalBackSlash(int col, int row) {
    int numSame = 1;
    int minCol = col;
    int maxCol = col;
    int minRow = row;
    int maxRow = row;
    
    while (true) {
      if (minCol > 0 && minRow > 0 && twoDList[minRow - 1][minCol - 1] == currentPlayer) {
        minCol--;
        minRow--;
      } else {
        break;
      }
    }
    while (true) {
      if (maxCol < 6 && maxRow < 5 && twoDList[maxRow + 1][maxCol + 1] == currentPlayer) {
        maxCol++;
        maxRow++;
      } else {
        break;
      }
    }

    if (maxCol - minCol >= 3) {
      return true;
    }
    return false;
  }

  bool isWon(int col, int row) {
    if (checkHorizontal(col, row) || checkVertical(col, row) || checkDiagonalSlash(col, row) || checkDiagonalBackSlash(col, row)) {
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
