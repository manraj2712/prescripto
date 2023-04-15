class ServiceModel {
  final String name;
  final int price;
  final DateTime creationDate;

  ServiceModel(
      {required this.name, required this.price, required this.creationDate});

  ServiceModel copyWith({String? name, int? price}) {
    return ServiceModel(
      name: name ?? this.name,
      price: price ?? this.price,
      creationDate: this.creationDate,
    );
  }
}
