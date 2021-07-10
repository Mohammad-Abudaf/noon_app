import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'NOON',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700
                ),
              ),
              actions: [
                IconButton(icon: Icon(Icons.search), onPressed: () {
                  navigateTo(context, SearchSceen());
                }),
                SizedBox(width: 10,)
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap:(index) => cubit.changeScreen(index),
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.screenIndex,
              items: cubit.bottomNavBarItems,
            ),
            body: cubit.screens[cubit.screenIndex],
          );
        },
      ),
    );
  }
}