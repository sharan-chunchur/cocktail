import 'package:cocktail/provider/drinks_details_provider.dart';
import 'package:cocktail/services/http_get_service.dart';
import 'package:cocktail/view/drink_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/drink.dart';
import '../presentation/resources/routes_manager.dart';

class DrinkItem extends StatelessWidget {
  final Drink drinkItem;
  const DrinkItem({super.key, required this.drinkItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Consumer(builder: (context, ref, child){
        return InkWell(
          onTap: (){
            ref.read(drinkDetailsProvider.notifier).fetchDrinkDetails(drinkItem.idDrink);
            Navigator.pushNamed(context, Routes.drinkDetailsScreenRoute);
          },
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Card(
                      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        drinkItem.strDrinkThumb, fit: BoxFit.fill, height: double.infinity,),
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.favorite_border),
                            SizedBox(width: 8,),
                            Text('187'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(drinkItem.strDrink, maxLines: 1, style: Theme.of(context).textTheme.titleMedium,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, size: 12,),
                  const Icon(Icons.star, size: 12,),
                  const Icon(Icons.star, size: 12,),
                  const Icon(Icons.star_border, size: 12,),
                  const Icon(Icons.star_border, size: 12,),
                  const SizedBox(width: 8,),
                  Text('Light', style: Theme.of(context).textTheme.bodySmall,),
                ],
              ),
            ],
          ),
        );
      },)
    );
  }
}
