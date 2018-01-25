import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_droidkaigi2018/network/response/mapping/sessions.dart';

/**
 * DroidKaigi API Client
 */
class DroidKaigiApi {

  static const String _baseUrl = "https://droidkaigi.jp/2018/";

  /**
   * DroidKaigiのSession一覧を取得
   */
  static Future<Sessions> getSessions() async {
    var completer = new Completer();

    final uri = Uri.parse(_baseUrl + "sessionize/all.json");
    await new HttpClient().getUrl(uri)
        .then((request) => request.close())
        .then((response) {
          if (response.statusCode == HttpStatus.OK) {
            var result = "";
            response.transform(UTF8.decoder).listen((contents) {
              result += contents;
            }).onDone(() => completer.complete(Sessions.parse(JSON.decode(result))));
          }
        })
        .catchError((e) {
      print(e);
    });

    return completer.future;
  }

}