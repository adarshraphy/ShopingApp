import 'package:ecommerce/models/hive_cartmodel.dart';
import 'package:ecommerce/screens/payment_page.dart';
import 'package:ecommerce/widgets/widget_button.dart';
import 'package:ecommerce/widgets/widget_image.dart';
import 'package:ecommerce/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:razorpay_web/razorpay_web.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}
bool isLoading = true;
class _CartPageState extends State<CartPage> {
  Box<HiveCartmodel>? cartBox;
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    _openCartBox();

    razorpay = Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, errorHandler);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, successHandler);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletHandler);

  }

  void openCheckout() {
    var options = {
      "key":"rzp_test_waeUUkXGdhnmoe" ,
      "amount":
      ((getTotalAmount() + getTaxAmount()) * 100).toString()
      ,
      "name": "Shopista",
      "description": "Payment for cart items",
      "timeout": "180",
      "currency": "INR",
      "prefill": {
        "contact": "",
        "email": "test@abc.com",
      }
    };
    razorpay.open(options);
  }
  void externalWalletHandler(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: WidgetText(
          text: 'External wallet used: ${response.walletName}',
          color: Colors.white, size: 20, weight: FontWeight.bold,
        ),
        backgroundColor: Colors.green,
        ));}

  void errorHandler(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:WidgetText(
        text: response.message ?? 'Payment error',
        color: Colors.white, size: 10, weight: FontWeight.bold,
      ),
      backgroundColor: Colors.red,
    ));
  }

  void successHandler(PaymentSuccessResponse response) {
    cartBox?.clear();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const PaymentPage(),
        ),
    );
    }

  Future<void> _openCartBox() async {
    final box = await Hive.openBox<HiveCartmodel>('cartBox');
    setState(() {
      cartBox=box;
      isLoading=false;
    });
  }

  double getTotalAmount() {
    double totalPrice = 0;
    for (int i = 0; i < cartBox!.length; i++) {
      final item = cartBox!.getAt(i);
      if (item != null) {
        totalPrice += item.totalValue;
      }
    }
    return totalPrice;
  }

  double getFullAmount() {
    double totalAmount = getTotalAmount();
    return totalAmount + (totalAmount * 0.18);
  }
  double getTaxAmount() {
    return getFullAmount() - getTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const WidgetText(
          text: "My Cart",
          color: Colors.black,
          size: 23,
          weight: FontWeight.bold,
        ),
      ),
      body: cartBox == null || cartBox!.isEmpty
          ? isLoading?Center(child: CircularProgressIndicator()):Center(
        child: WidgetText(
          text: "Your cart is empty",
          color: Colors.black,
          size: 18,
          weight: FontWeight.bold,
        ),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 500,
              height: 350,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartBox!.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = cartBox!.getAt(index);
                  if (item == null) return const SizedBox.shrink();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
                    child: Container(
                      width: 350,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child:Container(
                              width: 70,
                              height: 70,
                              child: WidgetImage(imgurl: item.product, height: 50, width: 50),
                            )
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20, bottom: 10),
                                child: SizedBox(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: WidgetText(
                                      text: item.name,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black,
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: WidgetText(
                                  text: "\$${item.totalValue.toStringAsFixed(2)}",
                                  color: Colors.black,
                                  size: 18,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  WidgetButton(
                                    icon: const Icon(Icons.remove_circle),
                                    color: Colors.black,
                                    iconsize: 20,
                                    onpressed: () {
                                      setState(() {
                                        if (item.quantity > 1) {
                                          double pricePerItem =
                                              item.totalValue / item.quantity;
                                          item.quantity -= 1;
                                          item.totalValue -= pricePerItem;
                                          cartBox!.putAt(index, item);
                                        }
                                      });
                                    },
                                  ),
                                  WidgetText(
                                    text: "${item.quantity}",
                                    color: Colors.black,
                                    size: 20,
                                    weight: FontWeight.bold,
                                  ),
                                  WidgetButton(
                                    icon: const Icon(Icons.add_circle),
                                    color: Colors.black,
                                    iconsize: 20,
                                    onpressed: () {
                                      setState(() {
                                        double pricePerItem =
                                            item.totalValue / item.quantity;
                                        item.quantity += 1;
                                        item.totalValue += pricePerItem;
                                        cartBox!.putAt(index, item);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          WidgetButton(
                            onpressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const WidgetText(
                                      text: "Delete",
                                      color: Colors.black,
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                    content: const WidgetText(
                                      text: "Are you sure  to delete this item from the cart?",
                                      color: Colors.black,
                                      size: 15,
                                      weight: FontWeight.w400,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          "No",
                                          style: TextStyle(
                                              color: Colors.blueAccent),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text(
                                          "Yes",
                                          style: TextStyle(
                                              color: Colors.blueAccent),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            cartBox!.deleteAt(index);
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            iconsize: 25,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ExpansionTile(
              title: WidgetText(
                text: "Total Amount: \$${getFullAmount().toStringAsFixed(2)}",
                color: Colors.black,
                size: 18,
                weight: FontWeight.bold,
              ),
              subtitle: const WidgetText(
                text: "Expand this to see price details",
                color: Colors.black,
                size: 15,
                weight: FontWeight.w400,
              ),
              children: [
                ListTile(
                  dense: true,
                  title: WidgetText(
                    text: "Goods & Service Tax (18%)",
                    color: Colors.black,
                    size: 14,
                    weight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  dense: true,
                  title: WidgetText(
                    text: "CGST (9%): \$${(getTaxAmount() / 2).toStringAsFixed(2)}",
                    color: Colors.black,
                    size: 12,
                    weight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  dense: true,
                  title: WidgetText(
                    text: "SGST/UTGST (9%): \$${(getTaxAmount() / 2).toStringAsFixed(2)}",
                    color: Colors.black,
                    size: 12,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed:
                  () => openCheckout(),
              child: const WidgetText(
                text: "Place Order",
                color: Colors.white,
                size: 18,
                weight: FontWeight.bold,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
