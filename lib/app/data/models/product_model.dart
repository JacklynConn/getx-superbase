class ProductModel{
  int id;
  final String name;
  double price;
  final String description;
  final String? image;
  final List<String>? size;
  final List<String>? color;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.image,
    this.size,
    this.color,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
      size: json['size'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'size': size,
      'color': color,
    };
  }
}