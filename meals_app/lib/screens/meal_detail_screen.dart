import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meals_app/models/dummy_data.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  // Sets a fixed string which can be used over the other widget
  static const routeName = '/meal-detail';

  Widget buildSectionTitle(BuildContext ctx, String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20),
      child: Text(
        title,
        style: Theme.of(ctx).textTheme.headline5,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      width: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // To get route arguments
    final routeArgs = ModalRoute.of(context)?.settings.arguments as String;
    final mealID = routeArgs;
    final Meal mealDetail =
        DUMMY_MEALS.firstWhere((element) => element.id == mealID);

    return Material(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actionsIconTheme: IconTheme.of(context),
          actions: [
            IconButton(
              icon: mealDetail.isBookmarked
                  ? Icon(Icons.bookmark)
                  : Icon(Icons.bookmark_outline),
              color: mealDetail.isBookmarked
                  ? Theme.of(context).primaryIconTheme.color
                  : Theme.of(context).accentIconTheme.color,
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(mealDetail.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaY: 19.2,
                          sigmaX: 19.2,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        'https://manskkp.lv/assets/images/users/4.jpg'),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Recipe By',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Renata Moe',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildSectionTitle(context, mealDetail.title),
              buildContainer(
                ListView.builder(
                  // shrinkWrap & NeverScrollableScrollPhysics to avoid internal scroll in listview
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: mealDetail.ingredients.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Card(
                        child: Text(
                          '${mealDetail.ingredients[index]}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    );
                  },
                ),
              ),
              buildContainer(ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        mealDetail.steps[index],
                      ),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: mealDetail.steps.length,
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.delete),
          // Kind of work as backbutton, removes current screen from stack
          // Can also pass data back to stack
          onPressed: () => Navigator.of(context).pop(mealDetail.id),
        ),
      ),
    );
  }
}
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
