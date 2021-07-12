import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/app_modle/app_model.dart';
import 'package:shop_app/modules/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/favorites_screen/favorite_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/settings_screen/setting_screen.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

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
  HomeModel homeData;
  String token = CacheHelper.getData(key: 'token');
  //token = CacheHelper.getData(key: 'token');

  void getHomeData(){
    emit(HomeLoadingScreenState());
    DioHelper.getData(url: 'home', authorization: 'b676yF4HQTAGtP9bYNM2kjAw3VZ6vd63Ar7dr7jQvhISokVKIK5K3Emr4tiPctOBgBlZhV').then((value){
      homeData = HomeModel.fromJson(value.data);
      emit(HomeSuccessScreenState());
    }).catchError((error){
      print ('error when getting data! ${error.toString()}');
      emit(HomeErrorScreenState(error.toString()));
    });
  }
}
