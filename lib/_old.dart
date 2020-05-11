import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          brightness: Brightness.light,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
            )
          ],
        ),
        body: _buildBody(),
      ),
    );
  }
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        _headerImage(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _weatherDescription(),
                Divider(),
                _temperature(),
                Divider(),
                _temperatureForecast(),
                Divider(),
                _footerRatings(),
                Divider(),
                Container(
                  height: 200,
                  child: _listView(),
                ),
                Divider(),
                Container(
                  height: 80,
                  child: _listViewWeather(),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Image _headerImage() {
  return Image(
    image: NetworkImage('https://w.wallhaven.cc/full/ym/wallhaven-ymwvrl.jpg'),
    fit: BoxFit.cover,
  );
}

Column _weatherDescription() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        'Tuesday - May 22',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      Divider(),
      Text(
        'Synthwave (also called outrun, retrowave, or futuresynth) is a genre of electronic music influenced by 1980s film soundtracks and video games. ... In its music and cover artwork, synthwave engages in retrofuturism, emulating 1980s science fiction, action, and horror media, sometimes compared to cyberpunk.',
        style: TextStyle(fontSize: 14, color: Colors.black54),
      ),
    ],
  );
}

Row _temperature() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Column(
        children: <Widget>[
          Icon(
            Icons.wb_sunny,
            color: Colors.red,
          ),
        ],
      ),
      SizedBox(width: 16.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[Text('15` Clear')],
          ),
          Row(
            children: <Widget>[
              Text(
                'Vologodskaya oblast, Vologda',
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    ],
  );
}

Wrap _temperatureForecast() {
  return Wrap(
    spacing: 10.0,
    children: List.generate(8, (int index) {
      return Chip(
        label: Text(
          '${index + 20} `C',
          style: TextStyle(fontSize: 12.0),
        ),
        avatar: Icon(
          Icons.wb_cloudy,
          color: Colors.blue.shade300,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(color: Colors.grey.shade300)),
        backgroundColor: Colors.grey.shade100,
      );
    }),
  );
}

Row _footerRatings() {
  var stars = Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(
        Icons.star,
        size: 15.0,
        color: Colors.yellow[600],
      ),
      Icon(
        Icons.star,
        size: 15.0,
        color: Colors.yellow[600],
      ),
      Icon(
        Icons.star,
        size: 15.0,
        color: Colors.yellow[600],
      ),
      Icon(
        Icons.star,
        size: 15.0,
        color: Colors.grey,
      ),
      Icon(
        Icons.star,
        size: 15.0,
        color: Colors.grey,
      )
    ],
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Text(
        'Info with openweathermap.org',
        style: TextStyle(fontSize: 10),
      ),
      stars
    ],
  );
}

Widget _listViewWeather() {
  return ListView(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    padding: EdgeInsets.all(8.0),
    children: <Widget>[
      ListTile(
        title: Text('Sun'),
        subtitle: Text('Today clear'),
        leading: Icon(Icons.wb_sunny),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        title: Text('Cloudy'),
        subtitle: Text('Today Cloudy'),
        leading: Icon(Icons.wb_cloudy),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        title: Text('Snow'),
        subtitle: Text('Today Snow'),
        leading: Icon(Icons.ac_unit),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    ],
  );
}

Widget _listView() {
  final List<ListItem> items = List<ListItem>.generate(
      100,
      (i) => i % 6 == 0
          ? HeadingItem('Heading $i')
          : MessageItem('Sender $i', 'Message Body $i'));

  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (ctx, i) {
      final item = items[i];
      if (item is HeadingItem) {
        return ListTile(
          title: Text(item.heading, style: Theme.of(ctx).textTheme.headline),
        );
      } else if (item is MessageItem) {
        return ListTile(
          title: Text(item.sender),
          subtitle: Text(item.body),
          leading: Icon(
            Icons.insert_photo,
            color: Colors.red,
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        );
      }
      return null;
    },
  );
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
