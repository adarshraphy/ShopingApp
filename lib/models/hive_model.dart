import 'package:hive/hive.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveModel {
  @HiveField(0)
  final String product;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String rating;

  @HiveField(3)
   int quantity;

  @HiveField(4)
  double totalValue;

  @HiveField(5)
    int totalPrice;

  HiveModel(
      this.product,
      this.name,
      this.rating,
      this.quantity,
      this.totalValue,
      this.totalPrice,

      );
}
