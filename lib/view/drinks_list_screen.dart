import 'package:cocktail/model/category.dart';
import 'package:cocktail/provider/drinks_provider.dart';
import 'package:cocktail/widgets/drink_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrinksListScreen extends StatelessWidget {
  const DrinksListScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Drinks',
        ),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final drinksState = ref.watch(drinksProvider);
          if(drinksState is LoadedDrinksState){
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2 / 3),
                itemCount: drinksState.drinks.length,
                itemBuilder: (context, index) {
                  return DrinkItem(drinkItem: drinksState.drinks[index],);
                });
          }else if(drinksState is ErrorState){
            return const Center(child: Text('Error'),);
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
