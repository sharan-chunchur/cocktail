
import 'package:cocktail/presentation/resources/string_manager.dart';
import 'package:cocktail/view/categories_list_screen.dart';
import 'package:cocktail/view/drink_details_screen.dart';
import 'package:cocktail/view/drink_steps_screen.dart';
import 'package:cocktail/view/drinks_list_screen.dart';
import 'package:flutter/material.dart';

import '../splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String categoriesListRoute = '/categories';
  static const String drinksListScreenRoute = '/drinksListScreen';
  static const String drinkDetailsScreenRoute = '/drinkDetailsScreen';
  static const String drinkStepsScreenRoute = '/drinkStepsScreen';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.categoriesListRoute:
        return MaterialPageRoute(builder: (_) => const CategoriesListPage());
      case Routes.drinksListScreenRoute:
        return MaterialPageRoute(builder: (_) => const DrinksListScreen());
      case Routes.drinkDetailsScreenRoute:
        return MaterialPageRoute(builder: (_) => const DrinkDetailsScreen());
      case Routes.drinkStepsScreenRoute:
        return MaterialPageRoute(builder: (_) => const DrinkStepsScreen());

      // case Routes.routeName:
      //   return MaterialPageRoute(builder: (context) => const DrinksListScreen());
      // case Routes.routeName:
      //   return MaterialPageRoute(builder: (context) => const DrinkDetailsScreen());
      // case Routes.routeName:
      //   return MaterialPageRoute(builder: (context)=> const DrinkStepsScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.noRouteFound,
          ),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}

