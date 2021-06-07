      // MaterialPageRoute<void>(
      //   builder: (BuildContext context) {
      //     final tiles = _favorites.map((WordPair pair) {
      //       return ListTile(
      //         title: Text(
      //           pair.asPascalCase,
      //           style: _biggerFont,
      //         ),
      //       );
      //     });

      //     final divided = tiles.isNotEmpty
      //         ? ListTile.divideTiles(tiles: tiles, context: context).toList()
      //         : <Widget>[];

      //     return Scaffold(
      //       appBar: AppBar(
      //         title: Text("Any secondary page top text"),
      //       ),
      //       body: ListView(children: divided),
      //     );
      //   },
      // ),