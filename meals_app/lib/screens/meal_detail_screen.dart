import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meals_app/models/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meals_serving_complexity.dart';

class MealDetailScreen extends StatelessWidget {
  // Sets a fixed string which can be used over the other widget
  static const routeName = '/meal-detail';

  final Function(String) toggleBookmarks;
  final bool Function(String mealID) isMealBookmarked;

  MealDetailScreen(this.toggleBookmarks, this.isMealBookmarked);

  Widget buildSectionTitle(BuildContext ctx, String title, int duration,
      Complexity complexity, String mealID) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 7,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(ctx).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    MealsServingComplexity(
                      complexity: complexity,
                      duration: duration,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: IconButton(
                  splashRadius: 20,
                  visualDensity: VisualDensity.compact,
                  icon: isMealBookmarked(mealID)
                      ? Icon(Icons.bookmark)
                      : Icon(Icons.bookmark_outline),
                  color: Theme.of(ctx).primaryIconTheme.color,
                  onPressed: () => toggleBookmarks(mealID),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSectionSubTitle(BuildContext ctx, String title, int count) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(ctx).textTheme.headline6,
          ),
          Text(
            '$count item',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   actionsIconTheme: IconTheme.of(context),
        //   actions: [
        //     IconButton(
        //       icon: isMealBookmarked(mealDetail.id)
        //           ? Icon(Icons.bookmark)
        //           : Icon(Icons.bookmark_outline),
        //       color: isMealBookmarked(mealDetail.id)
        //           ? Theme.of(context).primaryIconTheme.color
        //           : Theme.of(context).accentIconTheme.color,
        //       onPressed: () => toggleBookmarks(mealDetail.id),
        //     )
        //   ],
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       bottom: Radius.circular(10.0),
        //     ),
        //   ),
        // ),
        // body: SingleChildScrollView(
        //   child: Column(
        //     children: <Widget>[
        //       Container(
        //         width: double.infinity,
        //         padding: EdgeInsets.all(15),
        //         height: MediaQuery.of(context).size.height * 0.5,
        //         decoration: BoxDecoration(
        //           gradient: LinearGradient(
        //             colors: [
        //               Colors.white,
        //               Colors.transparent,
        //             ],
        //             begin: Alignment.topCenter,
        //             end: Alignment.center,
        //           ),
        //           image: DecorationImage(
        //             image: NetworkImage(mealDetail.imageUrl),
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        //             ClipRRect(
        //               borderRadius: BorderRadius.circular(10.0),
        //               child: BackdropFilter(
        //                 filter: ImageFilter.blur(
        //                   sigmaY: 19.2,
        //                   sigmaX: 19.2,
        //                 ),
        //                 child: Container(
        //                   padding: const EdgeInsets.symmetric(
        //                       horizontal: 15, vertical: 15),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: [
        //                       Row(
        //                         crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [
        //                           CircleAvatar(
        //                             backgroundColor: Colors.white,
        //                             backgroundImage: NetworkImage(
        //                                 'https://manskkp.lv/assets/images/users/4.jpg'),
        //                           ),
        //                           Container(
        //                             padding:
        //                                 EdgeInsets.symmetric(horizontal: 10),
        //                             child: Column(
        //                               crossAxisAlignment:
        //                                   CrossAxisAlignment.start,
        //                               children: [
        //                                 Text(
        //                                   'Recipe By',
        //                                   style: Theme.of(context)
        //                                       .textTheme
        //                                       .bodyText1,
        //                                 ),
        //                                 SizedBox(height: 5),
        //                                 Text(
        //                                   'Renata Moe',
        //                                   style: TextStyle(
        //                                     color: Colors.white,
        //                                     fontWeight: FontWeight.bold,
        //                                     fontSize: 16,
        //                                   ),
        //                                   textAlign: TextAlign.start,
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       Icon(
        //                         Icons.arrow_forward_rounded,
        //                         color: Colors.white,
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       buildSectionTitle(context, mealDetail.title),
        //       buildContainer(
        //         ListView.builder(
        //           // shrinkWrap & NeverScrollableScrollPhysics to avoid internal scroll in listview
        //           shrinkWrap: true,
        //           physics: NeverScrollableScrollPhysics(),
        //           itemCount: mealDetail.ingredients.length,
        //           itemBuilder: (ctx, index) {
        //             return Padding(
        //               padding: const EdgeInsets.symmetric(
        //                 horizontal: 10,
        //                 vertical: 5,
        //               ),
        //               child: Card(
        //                 child: Text(
        //                   '${mealDetail.ingredients[index]}',
        //                   style: Theme.of(context).textTheme.headline6,
        //                 ),
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //       buildContainer(
        //         ListView.builder(
        //           shrinkWrap: true,
        //           physics: NeverScrollableScrollPhysics(),
        //           itemBuilder: (context, index) => Column(
        //             children: [
        //               ListTile(
        //                 leading: CircleAvatar(
        //                   child: Text('# ${index + 1}'),
        //                 ),
        //                 title: Text(
        //                   mealDetail.steps[index],
        //                 ),
        //               ),
        //               Divider(),
        //             ],
        //           ),
        //           itemCount: mealDetail.steps.length,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.delete),
          // Kind of work as back button, removes current screen from stack
          // Can also pass data back to stack
          onPressed: () => Navigator.of(context).pop(mealDetail.id),
        ),

        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            SliverAppBar(
              stretch: true,
              onStretchTrigger: () {
                // Function callback for stretch
                return Future<void>.value();
              },
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                title: Container(
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaY: 19.2,
                        sigmaX: 19.2,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      'https://manskkp.lv/assets/images/users/4.jpg'),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Recipe By',
                                        style: TextStyle(
                                            color: Colors.white30,
                                            fontSize: 8,
                                            fontFamily: 'RobotoCondensed'),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'Renata Moe',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'Raleway'),
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
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      mealDetail.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.0, 0.5),
                          end: Alignment.center,
                          colors: <Color>[
                            Color(0x60000000),
                            Color(0x00000000),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                    child: buildSectionTitle(
                        context,
                        mealDetail.title,
                        mealDetail.duration,
                        mealDetail.complexity,
                        mealDetail.id),
                  ),
                  buildSectionSubTitle(context, 'Ingredients', mealDetail.ingredients.length),
                  buildContainer(
                    ListView.builder(
                      // shrinkWrap & NeverScrollableScrollPhysics to avoid internal scroll in listview
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: mealDetail.ingredients.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          elevation: 0,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.05),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${mealDetail.ingredients[index]}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  buildSectionSubTitle(context, 'Steps', mealDetail.steps.length),
                  buildContainer(
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                '# ${index + 1}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.05),
                              radius: 18,
                            ),
                            title: Text(
                              mealDetail.steps[index],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            contentPadding: EdgeInsets.all(0),
                          ),
                          Divider(),
                        ],
                      ),
                      itemCount: mealDetail.steps.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
