class Category {
  final int? _id;
  final String imgUrl;
  final String title;
  final double spendMony;
  const Category({
    int? id,
    required this.title,
    required this.imgUrl,
    required this.spendMony,
  }) : _id = id;
  int? get id => _id;
}
