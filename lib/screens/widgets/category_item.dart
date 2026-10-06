import 'package:coffee_shop_ui/models/product.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Container(
          height: 75,
          width: 75,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white, shape: .circle),
          child: Image.asset("assets/images/${category.image}"),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          category.name.toUpperCase(),
          style: TextStyle(
            fontWeight: .w900,
            fontSize: 13,
            color: Colors.white
          ),
          
        )
      ],
    );
  }
}
