class Session {
  final String id;
  final bool isServiceSession;
  final bool isPlenumSession;
  final List<String> speakers;
  final String title;
  final String description;
  final DateTime startsAt;
  final DateTime endsAt;
  final int roomId;
  final List<int> categoryItems;

  static Session parse(dynamic json) {
    return new Session(
      id: json['id'],
      isServiceSession: json['isServiceSession'],
      isPlenumSession: json['isPlenumSession'],
      speakers: json['speakers'],
      title: json['title'],
      description: json['description'],
      startsAt: DateTime.parse(json['startsAt']),
      endsAt: DateTime.parse(json['endsAt']),
      roomId: json['roomId'],
      categoryItems: json['categoryItems'].toList(),
    );
  }

  Session({
    this.id,
    this.isServiceSession,
    this.isPlenumSession,
    this.speakers,
    this.title,
    this.description,
    this.startsAt,
    this.endsAt,
    this.roomId,
    this.categoryItems,
  });
}
