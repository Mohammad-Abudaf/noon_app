import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/app_modle/categories_model.dart';
import 'package:shop_app/models/app_modle/home_model.dart';
import 'package:shop_app/models/favorite_model/favorite_modle.dart';
import 'package:shop_app/models/favorite_screen_model/favorite_screen_model.dart';
import 'package:shop_app/models/login_screen/login_model.dart';
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
  List<String> screensName = ['Home', 'Categories', 'Favorite', 'Settings'];
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeScreen(int index) {
    screenIndex = index;
    emit(ChangeBottomNavBarScreen());
  }

  HomeModel homeData;
  String token = CacheHelper.getData(key: 'token');

  Map<int, bool> isFavorite = {};

  void getHomeData() {
    emit(HomeLoadingScreenState());
    DioHelper.getData(url: 'home', authorization: token).then((value) {
      homeData = HomeModel.fromJson(value.data);
      homeData.data.products.forEach((element) {
        isFavorite.addAll({
          element.id: element.inFavorites
        });
      });
      print(isFavorite.toString());
      emit(HomeSuccessScreenState());
    }).catchError((error) {
      print('error when getting data! ${error.toString()}');
      emit(HomeErrorScreenState(error.toString()));
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    emit(CategoriesLoadingScreenState());
    DioHelper.getData(url: 'categories', authorization: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessScreenState());
    }).catchError((error) {
      print('error when getting data! ${error.toString()}');
      emit(CategoriesScreenState(error.toString()));
    });
  }

  void changeFavorite(int id) {
    isFavorite[id] = !isFavorite[id];
    emit(ChangeFavoriteState());
    DioHelper.postData(url: 'favorites', data: {
      'product_id' : id
    },
    authorization: token,
    ).then((value) {
      if (!isFavorite[id]){
        isFavorite[id] = !isFavorite[id];
      }
      emit(ChangeFavoriteSuccess());
    }).catchError(
        (error){
          if(isFavorite[id]){
            isFavorite[id] = !isFavorite[id];
          }
          emit(ChangeFavoriteError(error.toString()));
        });
  }

  FavoritesModel favoritesModel;
  void getFavorites() {
    emit(LoadingFavScreenState());
    DioHelper.getData(
      url: 'favorites',
      authorization: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(SuccessFavSuccessScreenState());
    }).catchError((error) {
      emit(ErrorFavScreenState(error.toString()));
    });
  }
  
  LoginModel userData;
  // this methode is for getting user data and display it in setting screen,,,, 
  void getUserData(){
    emit(LoadingProfileScreenState());
    DioHelper.getData(url: 'profile', authorization: token).then((value){
      userData = LoginModel.jsonData(value.data);
      emit(SuccessProfileSuccessScreenState());
      print (userData.data.name.toString());
    }).catchError((error){
      emit(ErrorProfileScreenState(error.toString()));
    });
  }
}
