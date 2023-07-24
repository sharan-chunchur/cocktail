
import 'package:cocktail/services/http_get_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/drink.dart';

abstract class DrinksState{}

class InitialDrinksState extends DrinksState{}

class LoadingDrinksState extends DrinksState{}

class LoadedDrinksState extends DrinksState{
  List<Drink> drinks;
  LoadedDrinksState({required this.drinks});
}

class ErrorState extends DrinksState{
  String msg;
  ErrorState({required this.msg});
}

class DrinkNotifier extends StateNotifier<DrinksState>{
  DrinkNotifier(): super(InitialDrinksState());

  void fetchDrinks(String categoryType) async{
    final getDrinksData = HttpGetServices();
    try{
      state = LoadingDrinksState();
      List<Drink> drinksList = await getDrinksData.getDrinksLists(categoryType);
      state = LoadedDrinksState(drinks: drinksList);
    }catch(e){
      state = ErrorState(msg: e.toString());
    }
  }
}

final drinksProvider = StateNotifierProvider<DrinkNotifier, DrinksState>((ref) => DrinkNotifier());