import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/models/products_responce_model.dart';
import 'package:ecommerce/screens/description_page.dart';
import 'package:ecommerce/widgets/widget_icon.dart';
import 'package:ecommerce/widgets/widget_image.dart';
import 'package:ecommerce/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:dio/dio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

List<Widget> imageList = [
  Image.asset("assets/images/banner1.jpg"),
  Image.asset("assets/images/banner2.jpg"),
  Image.asset("assets/images/banner3.jpg"),
  Image.asset("assets/images/banner4.jpg"),
];

int? choicechip;

Future<void> main() async {
  runApp(const MyApp());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MainPageState();
}

class _MainPageState extends State<HomePage> {
  GetProductResponceModel? getProductResponceModel;
  bool isloading = true;
  final dio = Dio();
  final TextEditingController searchController = TextEditingController();

  Future<void> fetchProducts({String? searchTerm}) async {
    setState(() {
      isloading = true;
    });

    final response = await dio.get(
        "https://dummyjson.com/products/search",
        queryParameters: {"q": searchTerm ?? ""}
    );
    if (response.statusCode == 200) {
      getProductResponceModel = GetProductResponceModel.fromJson(response.data);
    }
    setState(() {
      isloading = false;
    });

  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
    searchController.addListener(() {
      fetchProducts(searchTerm: searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WidgetText(text: "Shopista", color: Color(0xFFd45030), size: 25, weight: FontWeight.bold),
            Image.asset("assets/images/applogo.png",height: 30,width: 30,),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2, left: 20, right: 20),
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: "Search product",
                  suffixIcon: WidgetIcon(
                    icon: Icons.search_rounded,
                    color: Color(0xFFd45030),
                    size: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 360,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent),
              child:CarouselSlider(
                  items: imageList,
                  options: CarouselOptions(
                    height: 240.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 500),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                    },
                  ),
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 200,bottom: 5),
              child: WidgetText(
                  text: "Trending Items",
                  color: Colors.black,
                  size: 17,
                  weight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
              child: Center(
                child: isloading
                    ? LoadingAnimationWidget.horizontalRotatingDots(
                    color: Colors.grey, size: 50)
                    : GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: getProductResponceModel!.products!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    String? imageUrl = getProductResponceModel?.products![index]
                        .images?.isNotEmpty == true
                        ? getProductResponceModel?.products![index].images![0]
                        : null;
                    return GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white)),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: WidgetImage(
                                    imgurl: imageUrl.toString(),
                                    height: 100,
                                    width: 120)
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: WidgetText(
                                  text: getProductResponceModel!
                                      .products![index].title.toString(),
                                  color: Colors.black,
                                  size: 12,
                                  weight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  WidgetIcon(
                                      icon: Icons.attach_money_rounded,
                                      color: Colors.black,
                                      size: 18),
                                  WidgetText(
                                      text: getProductResponceModel!
                                          .products![index].price.toString(),
                                      color: Colors.black,
                                      size: 15,
                                      weight: FontWeight.bold),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Row(
                                children: [
                                  WidgetIcon(
                                    icon: Icons.star,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  WidgetText(
                                      text: getProductResponceModel!
                                          .products![index].rating.toString(),
                                      color: Colors.green,
                                      size: 12,
                                      weight: FontWeight.bold),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DescriptionPage(
                                  image: getProductResponceModel!
                                      .products![index].images![0],
                                  intex: index,
                                  title: getProductResponceModel!
                                      .products![index].title.toString(),
                                  price: getProductResponceModel!
                                      .products![index].price.toString(),
                                  description: getProductResponceModel!
                                      .products![index].description.toString(),
                                ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
