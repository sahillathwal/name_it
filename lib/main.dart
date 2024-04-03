import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

/// The main application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer It!',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

/// The state of the main application widget.
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNextName() {
    current = WordPair.random();
    notifyListeners();
  }
}

/// The home page widget.
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text("Here's a name:"),
          Text(appState.current.asPascalCase),
          ElevatedButton(
            onPressed: () {
              appState.getNextName();
            },
            child: Text('New Name'),
          ),
        ],
      ),
    );
  }
}