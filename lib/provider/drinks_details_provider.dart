
import 'package:cocktail/services/http_get_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/drink_details.dart';

abstract class DrinkDetailsState{}

class InitialDrinkDetailsState extends DrinkDetailsState{}

class LoadingDrinkDetailsState extends DrinkDetailsState{}

class LoadedDrinkDetailsState extends DrinkDetailsState{
  List<DrinkDetail> drinks;
  LoadedDrinkDetailsState({required this.drinks});
}

class ErrorDrinkDetailsState extends DrinkDetailsState{
  String msg;
  ErrorDrinkDetailsState({required this.msg});
}

class DrinkDetailsNotifier extends StateNotifier<DrinkDetailsState>{
  DrinkDetailsNotifier(): super(InitialDrinkDetailsState());

  void fetchDrinkDetails(String drinkId) async{
    final getDrinkDetailsData = HttpGetServices();
    try{
      state = LoadingDrinkDetailsState();
      List<DrinkDetail> drinksList = await getDrinkDetailsData.getDrinkDetails(drinkId);
      state = LoadedDrinkDetailsState(drinks: drinksList);
    }catch(e){
      state = ErrorDrinkDetailsState(msg: e.toString());
    }
  }
}

final drinkDetailsProvider = StateNotifierProvider<DrinkDetailsNotifier, DrinkDetailsState>((ref) => DrinkDetailsNotifier());