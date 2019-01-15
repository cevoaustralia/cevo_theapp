import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
// @required is defined in the meta.dart package

// We use an underscore to indicate that these variables are private.
// See https://www.dartlang.org/guides/language/effective-dart/design#libraries
final _rowHeight = 100.0;

class Team extends StatelessWidget {
  final Image image;
  final String name;
  final DateTime joined;

  const Team({
    Key key,
    @required this.image,
    @required this.name,
    @required this.joined,
  })  : assert(image != null),
        assert(name != null),
        assert(joined != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: this.image,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                this.name,
                                textScaleFactor: 1.0,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Joined : " +
                                    new DateFormat()
                                        .add_yMMM()
                                        .format(this.joined),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TeamRoute extends StatelessWidget {
  const TeamRoute();

  @override
  Widget build(BuildContext context) {
    final categories = [];

    final images = [
      "assets/owen_chung.jpg",
      "assets/paul_borg.jpg",
      "assets/steve_mactaggart.jpg",
      "assets/trent_hornibrook.jpg"
    ];

    final names = [
      "Owen Chung",
      "Paul Borg",
      "Steve Mactaggart",
      "Trent Hornibrook"
    ];

    for (var i = 0; i < 35; i++) {
      categories.add(
        Center(
          child: InkWell(
            onTap: () {
              print("clicked");
            },
            child: Card(
              color: Colors.white,
              child: Team(
                name: names[i % 4],
                joined: DateTime.now(),
                image: new Image(
                    image: new AssetImage(images[i % 4]),
                    fit: BoxFit.contain,
                    width: 50.0),
              ),
            ),
          ),
        ),
      );
    }

    final listView = Container(
      color: Colors.orangeAccent,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => categories[index],
        itemCount: categories.length,
      ),
    );

    final appBar = AppBar(
      elevation: 0.0,
      leading: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new InkWell(
          child: new Image(
              image: new AssetImage("assets/Cevo-PNG-orange.png"),
              fit: BoxFit.contain),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Text(
        'Team Cevo',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      actions: <Widget>[
//        IconButton(
//          icon: Icon(Icons.settings),
//          tooltip: 'Settings',
//          onPressed: () {
//            _goLogin(context);
//          },
//        ),
      ],
      centerTitle: true,
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}
