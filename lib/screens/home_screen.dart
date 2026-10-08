import 'dart:math';

import 'package:coffee_shop_ui/models/product.dart';
import 'package:coffee_shop_ui/screens/detail_screen.dart';
import 'package:coffee_shop_ui/screens/widgets/background.dart';
import 'package:coffee_shop_ui/screens/widgets/category_item.dart';
import 'package:coffee_shop_ui/screens/widgets/display_image.dart';
import 'package:coffee_shop_ui/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentCategory = 0;
  int currentProduct = 0;
  PageController? controller;
  double viewPoint = 0.5;
  double? pageOffSet = 1;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 1, viewportFraction: viewPoint)
      ..addListener(() {
        setState(() {
          pageOffSet = controller!.page;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> dataProducts = products
        .where((element) => element.category == categories[currentCategory])
        .toList();
    return Scaffold(
      appBar: myAppBar(),
      body: Stack(
        children: [
          Background(),
          Positioned(
            top: 30,
            left: 40,
            child: Text(
              "Smooth Out\nYour Everyday",
              style: TextStyle(height: 1.2, fontWeight: .w900, fontSize: 35),
            ),
          ),
          Positioned(
            top: 120,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                color: firstColor,
                child: Row(
                  children: List.generate(
                    categories.length,
                    (index) => Container(
                      height: 190,
                      width: 107,
                      color: currentCategory == index
                          ? Colors.amber
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 125,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                color: firstColor,
                child: Row(
                  mainAxisAlignment: .spaceAround,
                  children: List.generate(categories.length, (index) {
                    int decrease = 0;
                    int max = 1;
                    int bottomPadding = 1;

                    // for item display in courve shape
                    for (var i = 0; i < categories.length; i++) {
                      bottomPadding = index > max ? index - decrease++ : index;
                    }
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentCategory = index;
                          dataProducts = products
                              .where(
                                (element) =>
                                    element.category ==
                                    categories[currentCategory],
                              )
                              .toList();
                        });
                      },
                      child: Padding(
                        padding: .only(
                          top: 10,
                          bottom: bottomPadding.abs() * 75,
                        ),
                        child: CategoryItem(category: categories[index]),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.58,
                width: MediaQuery.of(context).size.width,
                color: secondColor,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                ClipPath(
                  clipper: Clip(),
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.58,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: controller,
                      onPageChanged: (value) {
                        setState(() {
                          currentProduct = value % dataProducts.length;
                        });
                      },
                      itemBuilder: (context, index) {
                        double scale = max(
                          viewPoint,
                          (1 - (pageOffSet! - index).abs() + viewPoint),
                        );
                        double angle = 0.0;
                        final items = dataProducts[index % dataProducts.length];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(product: items),
                              ),
                            );
                          },
                          child: Hero(
                            tag: items.name,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 200 - (scale / 1.6 * 170),
                              ),
                              child: Transform.rotate(
                                angle: angle * pi,
                                child: Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  children: [DisplayImage(product: items)],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        children: [
                          Text(
                            dataProducts[currentProduct % dataProducts.length]
                                .name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: .bold,
                              fontSize: 20,
                              height: 1.5,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '\$${dataProducts[currentProduct % dataProducts.length].price}0',
                            maxLines: 2,
                            textAlign: .center,
                            style: const TextStyle(
                              fontWeight: .bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(
                        dataProducts.length,
                        (index) => indicator(index),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer indicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 3,
          color: index == currentProduct
              ? Colors.amberAccent
              : Colors.transparent,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: index == currentProduct ? Colors.white : Colors.white60,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

AppBar myAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    title: Row(
      children: [
        Image.asset(
          "assets/images/coffee-cup.png",
          height: 30,
          color: Colors.amber,
        ),
        SizedBox(width: 5),
        Column(
          children: [
            Text("Qahwa", style: TextStyle(fontWeight: .bold, fontSize: 16)),
            Text("Space", style: TextStyle(fontSize: 15)),
          ],
        ),
      ],
    ),
    actions: [
      Center(
        child: Badge(
          backgroundColor: firstColor,
          smallSize: 8,
          child: Icon(Icons.shopping_cart, color: Colors.amber),
        ),
      ),
      SizedBox(width: 15),
    ],
  );
}

class Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 100);
    path.quadraticBezierTo(size.width / 2, -40, 0, 100);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
