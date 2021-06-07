import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:name_gen/favoritesscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      routes: <String, WidgetBuilder>{
        TheStateWid.routeName: (context) => TheStateWid(),
        // FavoritesPage.routeName: (context) => FavoritesPage(),
      },
      home: Scaffold(
        body: Center(
          // child: Text('Hello World'),
          // child: Text(wordPair.asPascalCase),
          child: TheStateWid(),
        ),
      ),
      // If you insert the initial route here, it results in
      // the initial route being put ONTO the home route, which
      // is the initial page, therefore, the initial page is on
      // top of another initial page.
      // initialRoute: TheStateWid.routeName,
      onGenerateRoute: (RouteSettings settings) {
        var pagePath;
        String routeStr = settings.name.toString();
        switch (routeStr) {
          case FavoritesPage.routeName:
            pagePath = FavoritesPage(
              arguments: settings.arguments as Map,
            );
            break;
        }

        return MaterialPageRoute(builder: (context) => pagePath);
      },
    );
  }
}

class TheStateWid extends StatefulWidget {
  static const String routeName = "/startingScreen";
  const TheStateWid({Key? key}) : super(key: key);

  @override
  _TheStateWidState createState() => _TheStateWidState();
}

class _TheStateWidState extends State<TheStateWid> {
  final _suggestions = <WordPair>[];
  final _favorites = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();

    return Scaffold(
      appBar: AppBar(
        title: Text("Any Name on Top"),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).pushNamed(FavoritesPage.routeName, arguments: {
      'titleString': _suggestions.last.asPascalCase,
      'favoritesList': _favorites,
      'biggerFont': _biggerFont,
    }).then((value) {
      setState(() {});
    });
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final _alreadySaved = _favorites.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        // If the statement on the left is true --> do the thing on the left
        // Otherwise do the thing in the right (same as in C)
        _alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (_alreadySaved)
            _favorites.remove(pair);
          else
            _favorites.add(pair);
        });
      },
    );
  }
}
