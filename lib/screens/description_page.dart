import 'package:ecommerce/models/hive_cartmodel.dart';
import 'package:ecommerce/models/hive_model.dart';
import 'package:ecommerce/widgets/widget_button.dart';
import 'package:ecommerce/widgets/widget_icon.dart';
import 'package:ecommerce/widgets/widget_image.dart';
import 'package:ecommerce/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:toastify_flutter/toastify_flutter.dart';

class DescriptionPage extends StatefulWidget {
  final String image;
  final int intex;
  final String price;
  final String title;
  final String description;

  const DescriptionPage({
    super.key,
    required this.image,
    required this.intex,
    required this.price,
    required this.title,
    required this.description,
  });

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  bool liked = false;
  bool cart = false;
  late Box<HiveModel> wishBox;
  late Box<HiveCartmodel> cartBox;

  @override
  void initState() {
    super.initState();
    _initializeBoxes();
  }

  Future<void> _initializeBoxes() async {
    wishBox = await Hive.openBox<HiveModel>('wishBox');
    cartBox = await Hive.openBox<HiveCartmodel>('cartBox');

    setState(() {
      liked = wishBox.containsKey(widget.title);
      cart = cartBox.containsKey(widget.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: const WidgetIcon(
                icon: Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            WidgetButton(
              icon: Icon(liked ? Icons.favorite : Icons.favorite_border),
              color: Colors.red,
              iconsize: 25,
              onpressed: () {
                setState(() {
                  liked = !liked;
                  if (liked) {
                    wishBox.put(
                      widget.title,
                      HiveModel(
                        widget.image,
                        widget.title,
                        widget.description,
                        1,
                        double.tryParse(widget.price) ?? 0.0,
                        int.tryParse(widget.price) ?? 0,
                      ),
                    );
                    ToastifyFlutter.success(
                      context,
                      message: 'Item added to wishlist successfully',
                      duration: 2,
                      position: ToastPosition.bottom,
                    );
                  } else {
                    wishBox.delete(widget.title);
                    ToastifyFlutter.info(
                      context,
                      message: 'Item removed from wishlist',
                      duration: 2,
                      position: ToastPosition.bottom,
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white),
              ),
              child: WidgetImage(
                imgurl: widget.image,
                height: 300,
                width: 300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 38,left: 20),
            child: WidgetText(
              text: widget.title,
              color: Colors.black,
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                const WidgetIcon(
                  icon: Icons.attach_money_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                WidgetText(
                  text: widget.price,
                  color: Colors.black,
                  size: 20,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 20),
            child: WidgetText(
              text: widget.description,
              color: Colors.black,
              size: 15,
              weight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 150),
          SizedBox(
            width: 190,
            height: 40,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (!cart) {
                    cart = true;
                    cartBox.put(
                      widget.title,
                      HiveCartmodel(
                        widget.image,
                        widget.title,
                        widget.description,
                        1,
                        double.tryParse(widget.price) ?? 0.0,
                        int.tryParse(widget.price) ?? 0,
                      ),
                    );
                    ToastifyFlutter.success(
                      context,
                      message: 'Item added to cart',
                      duration: 2,
                      position: ToastPosition.bottom,
                    );
                  }
                });
              },
              backgroundColor: Colors.blueGrey,
              child: Row(
                children: [
                  const SizedBox(width: 17),
                  WidgetIcon(
                    icon: cart ? Icons.check_circle : Icons.shopping_bag,
                    color: Colors.white,
                    size: 25,
                  ),
                  const SizedBox(width: 12),
                  Center(
                    child: WidgetText(
                      text: cart ? "ADDED TO CART" : "ADD TO CART",
                      color: Colors.white,
                      size: 15,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
