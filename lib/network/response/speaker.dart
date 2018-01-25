import 'package:flutter_droidkaigi2018/network/response/link.dart';

class Speaker {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final List<String> sessions;
  final String tagLine;
  final bool isTopSpeaker;
  final String bio;
  final String fullName;
  final List<Link> links;

  static Speaker parse(dynamic json) {
    return new Speaker(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        profilePicture: json['profilePicture'],
        sessions: json['sessions'].toList(),
        tagLine: json['tagLine'],
        isTopSpeaker: json['isTopSpeaker'],
        bio: json['bio'],
        fullName: json['fullName'],
        links: json['links'].map((h) => Link.parse(h)).toList(),
    );
  }

  Speaker({
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
