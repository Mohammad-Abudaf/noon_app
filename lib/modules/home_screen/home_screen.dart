import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/app_modle/app_model.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).homeData != null,
          builder: (context) => HomeBuilder(AppCubit.get(context).homeData),
          fallback: (context) => Center(child: CircularProgressIndicator())
        );
      },
    );
  }
  Widget HomeBuilder(HomeModel model) => Column(
    children: [
      CarouselSlider(
          items: model.data.banners
              .map(
                (e) => Image(
              image: NetworkImage(e.image),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          )
              .toList(),
          // items: [
          //   Image(image: NetworkImage('https://student.valuxapps.com/storage/uploads/banners/1619472351ITAM5.3bb51c97376281.5ec3ca8c1e8c5.jpg')),
          //   Image(image: NetworkImage('https://student.valuxapps.com/storage/uploads/banners/1625885444iTFEX.banner')),
          //   Image(image: NetworkImage('https://student.valuxapps.com/storage/uploads/banners/1619472116OYHxC.45b7de97376281.5ec3ca8c1d324.jpg')),
          // ],
          options: CarouselOptions(
            height: 250.0,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          )
      ),
    ],
  );
}