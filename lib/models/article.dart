class Article {
  String description;
  int quantity;
  double unitPrice;

  Article({this.description = '', this.quantity = 1, this.unitPrice = 0.0});

  double get totalHT => quantity * unitPrice;
}
