import 'package:cocktail/model/drink_details.dart';
import 'package:cocktail/provider/drinks_details_provider.dart';
import 'package:cocktail/view/drink_steps_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/resources/routes_manager.dart';

class DrinkDetailsScreen extends ConsumerWidget {


  const DrinkDetailsScreen({super.key});

  List<String> getList(DrinkDetail drinkDetail, String listProperty) {
    final List<String> list = [];
    final drinkJson = drinkDetail.toJson();
    for (int i = 1;; i++) {
      if (drinkJson.containsKey('$listProperty$i') &&
          drinkJson['$listProperty$i'] != null) {
        list.add(drinkJson['$listProperty$i']);
      } else {
        break;
      }
    }
    return list;
  }

  List<String?> getMeasureList(DrinkDetail drinkDetail, int length) {
    final List<String?> list = [];
    final drinkJson = drinkDetail.toJson();
    for (int i = 1; i <= length; i++) {
      list.add(drinkJson['strMeasure$i']);
    }
    return list;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drinkDetailsState = ref.watch(drinkDetailsProvider);
    Widget content;
    if (drinkDetailsState is LoadingDrinkDetailsState) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (drinkDetailsState is LoadedDrinkDetailsState) {
      final DrinkDetail drinkDetail = drinkDetailsState.drinks.first;
      final List<String> ingredients = getList(drinkDetail, 'strIngredient');
      final List<String?> measure =
          getMeasureList(drinkDetail, ingredients.length);

      content = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 350,
            child: Stack(
              children: [
                Image.network(
                  drinkDetail.strDrinkThumb,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.black45,
                    child: Text(
                      drinkDetail.strDrink,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
                const Positioned(
                  top: 0,
                  child: Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 40),
                      child: Icon(
                        Icons.circle,
                        size: 32,
                        color: Colors.white,
                      )),
                ),
                 Positioned(
                  top: 0,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 40),
                        child: Icon(
                          Icons.cancel,
                          size: 32,
                          color: Colors.grey,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.fromLTRB(40,24,40,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: 250,
                  child: Scrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                        itemCount: ingredients.length,
                        itemBuilder: (context, index) {
                          return Text(
                              measure[index] == null
                                  ? ingredients[index]
                                  : '${measure[index]} ${ingredients[index]}',
                              style: const TextStyle(
                                  fontFamily: '.SF UI Display',
                                  color: Colors.grey));
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      content = const Center(
        child: Text('Error'),
      );
    }
    return Scaffold(
      body: content,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: drinkDetailsState is LoadedDrinkDetailsState
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.drinkStepsScreenRoute);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade800,
                    foregroundColor: Colors.white),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 8),
                  child: Text(
                    'Start mixing',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
          ) :const SizedBox.shrink()
    );
  }
}
