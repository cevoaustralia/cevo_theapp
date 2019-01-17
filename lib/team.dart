import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

// @required is defined in the meta.dart package

// We use an underscore to indicate that these variables are private.
// See https://www.dartlang.org/guides/language/effective-dart/design#libraries
final _rowHeight = 100.0;

class TeamMember {
  final String name;
  final String image;
  final DateTime joined;

  TeamMember({
    @required this.name,
    this.image,
    @required this.joined,
  });

  factory TeamMember.fromJson(YamlMap json) {
    String image;
    if (json["avatar"] != null) {
      image = "assets/" + json['avatar'];
    }

    DateTime joined = DateTime.now();
    if (json["sort"] != null) {
      print(json['sort']);
      try {
        joined = DateTime.parse(json['sort'] + " 13:27:00");
      } catch (e) {
        print(e);
        joined = DateTime.now();
      }
    }

    return TeamMember(name: json['name'], image: image, joined: joined);
  }
}

class TeamMemberPanel extends StatelessWidget {
  final Image image;
  final String name;
  final DateTime joined;

  const TeamMemberPanel({
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

  _loadTeam(BuildContext context) async {
    final data =
        await DefaultAssetBundle.of(context).loadString("assets/team.yaml");

    var teamYaml = loadYaml(data);

    var team = teamYaml["people"].map((yaml) {
      return TeamMember.fromJson(yaml);
    }).toList();

    // How do we sort the list?
//    team.sort((a, b) => a.joined.compareTo(b.joined));

    return team;
  }

  Widget _buildPage(List teamMembers) {
    return ListView(
        shrinkWrap: true,
        primary: false,
        children: teamMembers.map((teamMember) {
          var image;
          if (teamMember.image == null) {
            image = new AssetImage("assets/DEFAULT_PERSON.jpg");
          } else {
            try {
              image = new AssetImage(teamMember.image);
            } catch (e) {
              print(e);
              image = new AssetImage("assets/DEFAULT_PERSON.jpg");
            }
          }

          return Center(
            child: InkWell(
              onTap: () {
                print("clicked");
              },
              child: Card(
                color: Colors.white,
                child: TeamMemberPanel(
                  name: teamMember.name,
                  joined: teamMember.joined,
                  image:
                      new Image(image: image, fit: BoxFit.contain, width: 50.0),
                ),
              ),
            ),
          );
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    final listView = Container(
        color: Colors.orangeAccent,
        child: ListView.builder(itemBuilder: (context, pageNumber) {
          return FutureBuilder(
            future: this._loadTeam(context),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 2,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: CircularProgressIndicator()),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var pageData = snapshot.data;

                    return this._buildPage(pageData);
                  }
              }
            },
          );
        }));

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
