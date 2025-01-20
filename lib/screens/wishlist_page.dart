import 'package:ecommerce/screens/description_page.dart';
import 'package:ecommerce/widgets/widget_button.dart';
import 'package:ecommerce/widgets/widget_image.dart';
import 'package:ecommerce/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/hive_model.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  Box<HiveModel>? wishBox;

  @override
  void initState() {
    super.initState();
    _openWishBox();
  }

  Future<void> _openWishBox() async {
    final box = await Hive.openBox<HiveModel>('wishBox');
    setState(() {
      wishBox = box;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const WidgetText(
          text: "Favorites",
          color: Colors.black,
          size: 23,
          weight: FontWeight.bold,
        ),
      ),
      body: wishBox == null || wishBox!.isEmpty
          ? Center(
        child: WidgetText(
          text: "Your favorites is empty",
          color: Colors.black,
          size: 18,
          weight: FontWeight.bold,
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: wishBox!.length,
        itemBuilder: (BuildContext context, int index) {
          final item = wishBox!.getAt(index);
          if (item == null) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage(
                      image: item.product,
                      intex: index,
                      price: item.totalValue.toString(),
                      title: item.name,
                      description: item.rating,
                    ),
                  ),
                );
              },
              child: Container(
                width: 350,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: WidgetImage(imgurl: item.product, height: 50, width: 50),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetText(
                            text: item.name,
                            color: Colors.black,
                            size: 18,
                            weight: FontWeight.bold,
                          ),
                          WidgetText(
                            text: "\$${item.totalValue.toStringAsFixed(2)}",
                            color: Colors.black,
                            size: 18,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    WidgetButton(
                      onpressed: () {
                        setState(() {
                          wishBox!.deleteAt(index);
                        });
                      },
                      icon: const Icon(Icons.favorite),
                      color: Colors.red,
                      iconsize: 25,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
