import 'package:flutter_droidkaigi2018/network/response/category_item.dart';

class Category {
  final int id;
  final String title;
  final List<CategoryItem> items;

  static Category parse(dynamic json) {
    return new Category(
        id: json['id'],
        title: json['title'],
        items: json['items'].map((h) => CategoryItem.parse(h)).toList()
    );
  }

  Category({
    this.id,
    this.title,
    this.items
  });
}
