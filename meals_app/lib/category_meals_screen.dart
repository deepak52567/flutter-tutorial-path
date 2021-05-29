import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meals_app/models/dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  // Sets a fixed string which can be used over the other widget
  static const routeName = '/category-meals';

  // final String categoryId;
  // final String categoryTitle;
  //
  // const CategoryMealsScreen(this.categoryId, this.categoryTitle, {Key? key})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    // To get route arguments
    final routeArgs =
    ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<String, String>;
    final categoryID = routeArgs['id'];
    final categoryTitle = routeArgs['title'];
    final categoryImage = routeArgs['bgImage'];
    final categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryID))
        .toList();
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: Text(categoryTitle!),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.account_circle)),
            ],
          ),
      ),
    );
  }
}

//
// Container(
// padding: EdgeInsets.only(bottom: 15),
// child: ClipRRect(
// borderRadius: BorderRadius.circular(5.0),
// child: BackdropFilter(
// filter: ImageFilter.blur(
// sigmaY: (1 - (shrinkOffset * 2) / expandedHeight) * 19.2,
// sigmaX: (1 - (shrinkOffset * 2) / expandedHeight) * 19.2,
// ),
// child: Opacity(
// opacity: (1 - shrinkOffset / expandedHeight),
// child: Container(
// padding: const EdgeInsets.symmetric(
// horizontal: 15, vertical: 15),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// CircleAvatar(
// backgroundColor: Colors.white,
// backgroundImage: NetworkImage(
// 'https://manskkp.lv/assets/images/users/4.jpg'),
// ),
// Container(
// padding: EdgeInsets.symmetric(horizontal: 10),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Recipe By',
// style:
// Theme.of(context).textTheme.bodyText2,
// ),
// SizedBox(height: 5),
// Text(
// categoryTitle,
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// fontSize: 16,
// ),
// textAlign: TextAlign.start,
// ),
// ],
// ),
// ),
// ],
// ),
// Icon(
// Icons.arrow_forward_rounded,
// color: Colors.white,
// ),
// ],
// ),
// ),
// ),
// ),
// ),
// ),

// class MealsAppBar extends SliverPersistentHeaderDelegate {
//   final double expandedHeight;
//   final String appBarImage;
//   final String categoryTitle;
//
//   MealsAppBar(
//       {required this.expandedHeight,
//       required this.appBarImage,
//       required this.categoryTitle});
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Stack(
//       clipBehavior: Clip.none,
//       fit: StackFit.expand,
//       children: [
//         Image.asset(
//           'assets/images/categories/${appBarImage}',
//           fit: BoxFit.cover,
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Opacity(
//               opacity: shrinkOffset / expandedHeight,
//               child: Text(
//                 categoryTitle,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 23,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   @override
//   double get maxExtent => expandedHeight;
//
//   @override
//   double get minExtent => SliverAppBar().toolbarHeight + 40;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }
