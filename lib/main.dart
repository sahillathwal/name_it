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

  /// The current word pair.
  var current = WordPair.random();

  /// Get the next word pair.
  void getNextName() {
    current = WordPair.random();
    notifyListeners();
  }

  /// The set of saved word pairs.
  var favorites = <WordPair>{};

  /// Toggle the saved state of a word pair.
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

/// The home page widget.
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Get the app state.
    var appState = context.watch<MyAppState>();

    // Get the current word pair.
    var pair = appState.current;

    // Determine the favorite icon.
    IconData icon = appState.favorites.contains(pair) ? Icons.favorite : Icons.favorite_border;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                // Favorite button.
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('like'),
                ),

                // Spacer.
                SizedBox(width: 15),

                // Next button.
                ElevatedButton(
                  onPressed: () {
                    appState.getNextName();
                  },
                  child: Text('Next'),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget that displays a big card with a word pair.
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  /// The word pair to display.
  final WordPair pair;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asPascalCase, 
          style: style, 
          semanticsLabel: "${pair.first} ${pair.second}",
          ),
      ),
    );
  }
}