import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/modules/login_screen/login_screen_cubit/login_cubit.dart';
import 'package:shop_app/modules/on_board_screen/on_board_screen.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/bloc_observer.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'layout/home_layout.dart';
import 'modules/login_screen/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding =  CacheHelper.getData(key: 'isBoarding') != null;
  Widget widget;
  if(onBoarding){
    if(CacheHelper.sharedPreferences.getString('taken') != null){
      widget = HomeLayout();
    } else{
      widget = LoginScreen();
    }
  }
  return runApp(MyApp(onBoarding: onBoarding, startWidget: widget));
}

class MyApp extends StatelessWidget {

  bool onBoarding = false;
  final Widget startWidget;
  MyApp({@required this.onBoarding, @required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..getHomeData(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: defaultColor,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey[335],
              ),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.white,
                )
              ),
              primaryColor: defaultColor,
              iconTheme: IconThemeData(
                color: defaultColor
              ),
            ),
            darkTheme: ThemeData(),
            themeMode: ThemeMode.light,
          home: onBoarding? HomeLayout(): OnBoardScreen(),
          );
        },
      ),
    );
  }
}
