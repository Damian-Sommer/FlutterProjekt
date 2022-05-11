// ignore_for_file: deprecated_member_use, unused_local_variable, empty_catches, avoid_print

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
  TextEditingController inputReiheNr = new TextEditingController();
  String getuName = "";
  String board = "";
  String errorMessage = "";
  int playerID = 0;
  var twoDList;
  @override
  Widget build(BuildContext context) {
    createBoard();
    return Scaffold(
        appBar: AppBar(
          title: const Text("TextField Demo"),
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
              /*TextField(
                controller: inputPasswordController,
                decoration: const InputDecoration(
                  hintText: "Your password",
                  labelText: "Password",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.visiblePassword,
                autocorrect: false,
                enableSuggestions: false,

                //style: TextStyle(decoration: TextDecoration.none),
              ),*/
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      errorMessage = updateBoard(inputReiheNr.text, playerID);
                      board = outputBoard();
                      playerID = playerID + 1;
                      inputReiheNr.text = "";
                    });
                  },
                  child: Text("Absenden")),
              // ignore: unnecessary_null_comparison
              Text(board),
              Text(errorMessage),
            ],
          ),
        ));
  }

  void createBoard() {
    int row = 6;
    int col = 7;

    this.twoDList = List.generate(
        row, (i) => List.filled(col, "*", growable: false),
        growable: false);
  }

  String outputBoard() {
    String ausgabe = "";
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 5; j++) {
        ausgabe += twoDList[i][j];
      }
      ausgabe += "\n";
    }
    return ausgabe;
  }

  String updateBoard(String strColumn, int playerNr) {
//For fill;
    // ignore: prefer_conditional_assignment
    /*if (reihe == "") {
      reihe = "0";
    }*/
    int column;
    try {
      if (strColumn == "") {
        return "Bitte gebe eine Nummer ein!";
      }
      column = int.parse(strColumn);
    } catch (Exception) {
      return "Bitte gebe eine Nummer ein!";
    }

    if (twoDList[column][0] != "*") {
      playerID--;
      return "Diese Kolonne ist voll";
    }

    int row = 0;
    while (row < 6 - 1 && twoDList[column][row + 1] == "*") {
      row++;
    }
    print(row);
    /*if (isfull(reiheID)) {
      print("Game Finished");
      return "Game Finished";
    } else {*/

    String outputSymbol = "";
    if (playerID % 2 == 0) {
      outputSymbol = "x";
      print(column);
    } else {
      outputSymbol = "0";
    }
    twoDList[column][row] = outputSymbol;
    /*String ausgabe = "";
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 6; i++) {
        ausgabe = ausgabe + twoDList[i][j];
      }
      ausgabe = ausgabe + "\n";
    }
    return ausgabe;*/
    return "";
  } /*

  bool isfull(int reihe) {
    for (int column = 0; column < 6; column++) {
      if (twoDList[column][reihe] == "*") {
        return false;
      }
    }
    return true;
  }*/
}
