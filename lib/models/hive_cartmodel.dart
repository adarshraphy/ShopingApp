import 'package:hive/hive.dart';
part 'hive_cartmodel.g.dart';

@HiveType(typeId: 1)
class HiveCartmodel {
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

  HiveCartmodel(
      this.product,
      this.name,
      this.rating,
      this.quantity,
      this.totalValue,
      this.totalPrice,

      );
}
