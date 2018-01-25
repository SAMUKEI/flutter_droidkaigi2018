import 'package:flutter_droidkaigi2018/network/response/category.dart';
import 'package:flutter_droidkaigi2018/network/response/room.dart';
import 'package:flutter_droidkaigi2018/network/response/session.dart';
import 'package:flutter_droidkaigi2018/network/response/speaker.dart';
import 'package:flutter_droidkaigi2018/network/response/link.dart';

/**
 * Session一覧
 */
class Sessions {
  final List<SessionValueObject> sessions;
  final List<SpeakerValueObject> speakers;

  static Sessions parse(dynamic json) {
    final sessions = _Sessions.parse(json);

    // Session一覧を使いやすい形にマッピング
    return new Sessions(
      sessions: sessions.sessions.map((h) => SessionValueObject.mapping(h, sessions.speakers, sessions.categories, sessions.rooms)).toList(),
      speakers: sessions.speakers.map((h) => SpeakerValueObject.mapping(h, sessions.sessions)).toList(),
    );
  }

  Sessions({
    this.sessions,
    this.speakers,
  });
}

/**
 * Session一覧を各レスポンス型に格納
 */
class _Sessions {
  final List<Session> sessions;
  final List<Speaker> speakers;
  final List<Category> categories;
  final List<Room> rooms;

  static _Sessions parse(dynamic json) {
    return new _Sessions(
      sessions: json['sessions'].map((h) => Session.parse(h)).toList(),
      speakers: json['speakers'].map((h) => Speaker.parse(h)).toList(),
      categories: json['categories'].map((h) => Category.parse(h)).toList(),
      rooms: json['rooms'].map((h) => Room.parse(h)).toList(),
    );
  }

  _Sessions({
    this.sessions,
    this.speakers,
    this.categories,
    this.rooms,
  });
}

class SessionValueObject {
  final String id;
  final bool isServiceSession;
  final bool isPlenumSession;
  final List<Speaker> speakers;
  final String title;
  final String description;
  final DateTime startsAt;
  final DateTime endsAt;
  final Room room;
  final List<Category> categoryItems;

  static SessionValueObject mapping(Session session, List<Speaker> speakers, List<Category> categories, List<Room> rooms) {
    return new SessionValueObject(
      id: session.id,
      isServiceSession: session.isServiceSession,
      isPlenumSession: session.isPlenumSession,
      speakers: speakers.where((h) => session.speakers.indexOf(h.id) != -1).toList(),
      title: session.title,
      description: session.description,
      startsAt: session.startsAt,
      endsAt: session.endsAt,
      room: rooms.where((h) => session.roomId == h.id).first,
      categoryItems: categories.where((h) => session.categoryItems.indexOf(h.id) != -1).toList(),
    );
  }

  SessionValueObject({
    this.id,
    this.isServiceSession,
    this.isPlenumSession,
    this.speakers,
    this.title,
    this.description,
    this.startsAt,
    this.endsAt,
    this.room,
    this.categoryItems,
  });
}

class SpeakerValueObject {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final List<Session> sessions;
  final String tagLine;
  final bool isTopSpeaker;
  final String bio;
  final String fullName;
  final List<Link> links;

  static SpeakerValueObject mapping(Speaker speaker, List<Session> sessions) {
    return new SpeakerValueObject(
      id: speaker.id,
      firstName: speaker.firstName,
      lastName: speaker.lastName,
      profilePicture: speaker.profilePicture,
      sessions: sessions.where((h) => speaker.sessions.indexOf(h.id) != -1).toList(),
      tagLine: speaker.tagLine,
      isTopSpeaker: speaker.isTopSpeaker,
      bio: speaker.bio,
      fullName: speaker.fullName,
      links: speaker.links,
    );
  }

  SpeakerValueObject({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.sessions,
    this.tagLine,
    this.isTopSpeaker,
    this.bio,
    this.fullName,
    this.links,
  });
}
