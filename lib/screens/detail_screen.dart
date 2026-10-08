import 'package:coffee_shop_ui/models/product.dart';
import 'package:coffee_shop_ui/models/size_option_model.dart';
import 'package:coffee_shop_ui/screens/widgets/background.dart';
import 'package:coffee_shop_ui/screens/widgets/display_image.dart';
import 'package:coffee_shop_ui/screens/widgets/size_option.dart';
import 'package:coffee_shop_ui/utils/colors.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedSize = 2;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar(context),
      body: Stack(
        children: [
          Background(),
          Positioned(
            left: 20,
            right: 20,
            child: Column(
              children: [
                Hero(
                  tag: widget.product.name,
                  child: SizedBox(
                    width: size.width * 0.81,
                    height: size.height * 0.5,
                    child: DisplayImage(product: widget.product),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(
                      width: size.width / 1.5,
                      child: Text(
                        widget.product.name,
                        style: TextStyle(
                          fontWeight: .bold,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '\$${widget.product.price}0',
                          maxLines: 2,
                          textAlign: .center,
                          style: const TextStyle(
                            fontWeight: .w900,
                            fontSize: 30,
                            color: firstColor,
                          ),
                        ),
                        Text(
                          'Best Sale',
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: .bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Size Options',
                      style: const TextStyle(
                        fontWeight: .bold,
                        fontSize: 17,
                        color: Colors.black38,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(sizeOptions.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = index;
                            });
                          },
                          child: SizeOptionItem(
                            index: index,
                            selected: selectedSize == index ? true : false,
                            sizeOption: sizeOptions[index],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity--;
                              }
                            });
                          },
                          child: Container(
                            padding: .all(4),
                            decoration: BoxDecoration(
                              color: secondColor,
                              shape: .circle,
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontWeight: .bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          child: Container(
                            padding: .all(4),
                            decoration: BoxDecoration(
                              color: secondColor,
                              shape: .circle,
                            ),
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: secondColor,
                          borderRadius: .circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            'Add to Order',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
      title: const Text(
        "Details",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
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
}
