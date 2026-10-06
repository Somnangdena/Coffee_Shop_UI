import 'package:coffee_shop_ui/models/product.dart';
import 'package:coffee_shop_ui/utils/colors.dart';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final Product product;
  const DisplayImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        return SizedBox(
          height: constrain.maxHeight * 1.25,
          width: constrain.maxWidth,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                width: constrain.maxHeight,
                height: constrain.maxWidth * 0.9,
                decoration: BoxDecoration(color: thirdColor, shape: .circle),
              ),
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(constrain.maxWidth * 0.45),
                ),
                child: SizedBox(
                  width: constrain.maxWidth * 0.9,
                  height: constrain.maxWidth * 2,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Positioned(
                        bottom: -60,
                        width: constrain.maxWidth * 0.9,
                        height: constrain.maxWidth * 1.5,
                        child: Image.asset(
                          "assets/images/${product.image}",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
