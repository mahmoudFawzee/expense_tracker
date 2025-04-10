class Category {
  final int? _id;
  final String imgUrl;
  final String title;
  const Category(
     {int? id,
    required this.title,
    required this.imgUrl,
  }) : _id = id;
  int? get id => _id;
}
