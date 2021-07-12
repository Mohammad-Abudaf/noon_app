import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/app_modle/app_model.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: AppCubit.get(context).homeData != null,
            builder: (context) => HomeBuilder(AppCubit.get(context).homeData),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget HomeBuilder(HomeModel model) => SingleChildScrollView(
        child: Column(
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
                )),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.white,
              child: GridView.count(
                mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.45,
                  children: List.generate(
                      model.data.products.length,
                      (index) => buildProductItem(model.data.products[index]))),
            )
          ],
        ),
      );
  Widget buildProductItem(ProductModel productModel) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children :
          [
            Image(
            image: NetworkImage(productModel.image),
            width: double.infinity,
            height: 200.0,
          ),
            if (productModel.discount != 0)
              Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  'Discount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                  ),
                ),
              ),
            ),
    ],
        ),
        Column(
          children: [
            Text(
              productModel.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: 'Janna',
              ),
            ),
            Row(
              children: [
                Text(
                  productModel.price.toString(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 20.0,),
                if(productModel.discount != 0)
                  Text(
                    productModel.oldPrice.toString(),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                    ),
                  )
              ],
            )
          ],
        )
      ]),
    );
  }
}
