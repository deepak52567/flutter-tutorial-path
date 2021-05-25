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
    Navigator.pushNamed(
      ctx,
      '/category-meals',
      arguments: {
        'id': id,
        'title': title,
        'bgImage': bgImage,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // GestureDetector with ripple effect
    return InkWell(
      splashColor: Theme.of(context).primaryColor.withOpacity(0.7),
      borderRadius: BorderRadius.circular(10),
      onTap: () => selectCategory(context),
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/categories/${bgImage}'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Opacity(
            opacity: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
