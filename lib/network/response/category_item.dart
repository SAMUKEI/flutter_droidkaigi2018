class CategoryItem {
  final int id;
  final String name;
  final int sort;

  static CategoryItem parse(dynamic json) {
    return new CategoryItem(
        id: json['id'],
        name: json['name'],
        sort: json['sort']
    );
  }

  CategoryItem({
    this.id,
    this.name,
    this.sort
  });
}