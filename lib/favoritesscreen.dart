import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class FavoritesPage extends StatefulWidget {
  static const String routeName = "/favorites";
  final Map? arguments;

  const FavoritesPage({Key? key, @required this.arguments}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Map arguments = {};
  List<WordPair> _clonedfavorites = [];

  @override
  void initState() {
    super.initState();
    _clonedfavorites =
        List.from(Map.from(widget.arguments as Map)['favoritesList']);
    arguments = widget.arguments as Map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['titleString']),
      ),
      body: _getFavoritesBody(),
    );
  }

  Widget _getFavoritesBody() {
    final allElements = _getFavorites();
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: allElements.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;

          return allElements[index];
        });
  }

  List<Widget> _getFavorites() {
    final _favorites = arguments['favoritesList'] as List<WordPair>;
    final tiles = _clonedfavorites.map((WordPair pair) {
      return ListTile(
        title: Transform.translate(
          child: Text(
            pair.asPascalCase,
            // "I have no clue that the thing akjfal;kjfa ",
            // style: arguments['biggerFont'],
          ),
          offset: Offset(-40, -0),
        ),
        // leading: Icon(
        //   _favorites.contains(pair) ? Icons.favorite : Icons.favorite_border,
        //   color: _favorites.contains(pair) ? Colors.red : null,
        // ),
        leading: Transform.translate(
          child: Icon(
            _favorites.contains(pair) ? Icons.favorite : Icons.favorite_border,
            color: _favorites.contains(pair) ? Colors.red : null,
          ),
          offset: Offset(-20, -0),
        ),
        onTap: () {
          setState(() {
            if (_favorites.contains(pair)) {
              _favorites.remove(pair);
            } else {
              _favorites.add(pair);
            }
          });
        },
      );
    });

    return tiles.isNotEmpty
        ? ListTile.divideTiles(tiles: tiles, context: context).toList()
        : <Widget>[];
  }
}
