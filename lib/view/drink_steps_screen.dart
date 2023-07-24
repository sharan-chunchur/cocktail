import 'package:cocktail/provider/drinks_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/drink_details.dart';

class DrinkStepsScreen extends ConsumerWidget {

  const DrinkStepsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drinkDetailsState = ref.read(drinkDetailsProvider);
    final DrinkDetail? drinkDetail;
    final List<String> steps;
    if (drinkDetailsState is LoadedDrinkDetailsState) {
      drinkDetail = drinkDetailsState.drinks.first;
      steps = drinkDetail.strInstructions!.split('.');
    } else {
      drinkDetail = null;
      steps = [];
    }
    return Scaffold(
      body: drinkDetail == null
          ? const Center(
              child: Text('unavailable'),
            )
          : Column(
              children: [
                Image.network(
                  drinkDetail.strDrinkThumb,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Steps',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(
                        height: 220,
                        child: Scrollbar(
                          thumbVisibility: true,
                          trackVisibility: true,
                          child: ListView.builder(
                            itemCount: steps.length - 1,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Text(
                                  (index + 1).toString(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                title: Text(steps[index],
                                    style: Theme.of(context).textTheme.bodySmall),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
