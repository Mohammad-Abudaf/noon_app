import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/modules/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/favorites_screen/favorite_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/settings_screen/setting_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  int screenIndex = 0;
  List<String> screensName= ['Home', 'Categories', 'Favorite', 'Settings'];
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  void changeScreen(int index){
    screenIndex = index;
    emit(ChangeBottomNavBarScreen());
  }
}
