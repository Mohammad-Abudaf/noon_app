import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class HomeLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOON',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w800
          ),
        ),
      ),
      body: defaultButton(label: 'logout', onPressed: (){
        CacheHelper.removeData(key: 'token');
        navigateAndFinish(context, LoginScreen());
      }),

    );
  }
}