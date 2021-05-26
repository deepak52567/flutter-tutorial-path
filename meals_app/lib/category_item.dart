import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final String bgImage;

  const CategoryItem(this.id, this.title, this.color, this.bgImage, {Key? key})
      : super(key: key);

  void selectCategory(BuildContext ctx) {
    // Navigator is a class which helps to navigate between screen and needs to be connected with context
    // Navigator.of(ctx).push(MaterialPageRoute(
    //   builder: (_) {
    //     return CategoryMealsScreen(id, title);
    //   },
    // ));
    // Named Routes
    Timer(Duration(milliseconds: 100), () {
      Navigator.pushNamed(
        ctx,
        '/category-meals',
        arguments: {
          'id': id,
          'title': title,
          'bgImage': bgImage,
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // GestureDetector with ripple effect
    return Material(
      clipBehavior: Clip.antiAlias,
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/categories/${bgImage}'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Opacity(
            opacity: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    color.withOpacity(0.5),
                    color.withOpacity(0.3),
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 6.0,
            left: 6.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 19.2,
                  sigmaX: 19.2,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                onTap: () => selectCategory(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
