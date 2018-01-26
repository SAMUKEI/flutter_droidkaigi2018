import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi2018/network/droidkaigi_api.dart';
import 'package:flutter_droidkaigi2018/network/response/mapping/sessions.dart';

class SessionsPage extends StatefulWidget {
  SessionsPage({Key key, this.title}) : super(key: key);

  // アプリのタイトル
  final String title;

  @override
  _SessionsPageState createState() => new _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new FutureBuilder<Sessions>(
          future: DroidKaigiApi.getSessions(),
          builder: (BuildContext context, AsyncSnapshot<Sessions> snapshot) {
            if (!snapshot.hasData) {
              return new Container();
            }

            var map = new Map<DateTime, List<SessionValueObject>>();
            // 日時でセクションを作る
            snapshot.data.sessions.forEach((session) {
              if (map[session.startsAt] == null) {
                map[session.startsAt] = new List<SessionValueObject>();
              }
              map[session.startsAt].add(session);
            });

            var items = new List<StatelessWidget>();
            map.forEach((date, sessions) {
              items.add(new _SectionItem(date));
              sessions.forEach((session) => items.add(new _SessionItem(session)));
            });

            return new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) => items[index]
            );
          }
      ),
    );
  }
}

class _SectionItem extends StatelessWidget {
  const _SectionItem(this.date);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final dateFormat = new DateFormat('MM月dd日hh時mm分');
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [new Container(
          decoration: new BoxDecoration(color: Colors.lightGreen),
          child: new Center(
            child: new Text(dateFormat.format(date)),
          ),
        )]
    );
  }
}

class _SessionItem extends StatelessWidget {
  const _SessionItem(this.session);

  final SessionValueObject session;

  @override
  Widget build(BuildContext context) {
    var children = <Widget> [
      new Container(
          padding: new EdgeInsets.only(left: 0.0, top: 10.0, bottom: 0.0, right: 0.0)),
      new Text(session.title)];
    session.speakers.map((h) => new Text(h.fullName + " -- " + session.room.name )).forEach((h) => children.add(h));

    // ボーダーを設定
    children.add(new Container(
      padding: new EdgeInsets.only(left: 0.0, top: 10.0, bottom: 0.0, right: 0.0),
      child: new Container(
          decoration: new BoxDecoration(
            border: new Border.all(width: 0.5, color: Colors.black38),
          )),
    ));

    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
    );
  }
}
