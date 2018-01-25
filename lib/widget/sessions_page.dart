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
            Sessions content = snapshot.data;
            return new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              itemCount: content.sessions.length,
              itemBuilder: (BuildContext context, int index) => new _SessionItem(content.sessions[index]),
            );
          }
      ),
    );
  }
}

class _SessionItem extends StatelessWidget {
  const _SessionItem(this.session);

  final SessionValueObject session;

  @override
  Widget build(BuildContext context) {

    // １行のデータを設定
    final dateFormat = new DateFormat('MM月dd日hh時mm分');
    var children= <Widget> [
      new Text(dateFormat.format(session.startsAt) + " から " + dateFormat.format(session.endsAt)),
      new Text(session.title),
    ];
    session.speakers.map((h) => new Text(h.fullName)).forEach((h) => children.add(h));
    children.add(new Text(session.room.name));

    // ボーダーとパディングを設定
    children.add(new Container(
      padding: new EdgeInsets.only(left: 0.0, top: 10.0, bottom: 10.0, right: 0.0),
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
