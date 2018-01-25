class Room {
  final int id;
  final String name;
  final int sort;

  static Room parse(dynamic json) {
    return new Room(
      id: json['id'],
      name: json['name'],
      sort: json['sort']
    );
  }

  Room({
    this.id,
    this.name,
    this.sort
  });
}