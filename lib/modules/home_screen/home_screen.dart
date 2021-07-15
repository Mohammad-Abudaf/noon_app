import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/app_modle/categories_model.dart';
import 'package:shop_app/models/app_modle/home_model.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // if(state is ChangeFavoriteState){
        //   showToast(massage: state.favorite.message.toString());
        // }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: AppCubit.get(context).homeData != null,
            builder: (context) => HomeBuilder(AppCubit.get(context).homeData,
                AppCubit.get(context).categoriesModel, context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget HomeBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 12.0,
                end: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Janna',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoriesItem(categoriesModel.data.data[index]),
                      itemCount: 10,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        width: 10.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Janna',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
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
                  childAspectRatio: 1 / 1.6,
                  children: List.generate(
                      model.data.products.length,
                      (index) => buildProductItem(
                          model.data.products[index], context))),
            )
          ],
        ),
      );

  Widget buildProductItem(ProductModel productModel, context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
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
            Spacer(),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    productModel.price.toString(),
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  if (productModel.discount != 0)
                    Text(
                      productModel.oldPrice.toString(),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      AppCubit.get(context).changeFavorite(productModel.id);
                      print(productModel.id);
                      print ('something');
                    },
                    icon: AppCubit.get(context).isFavorite[productModel.id]? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_outline, color: defaultColor,),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  Widget circle(ProductModel productModel, context) => CircleAvatar(
    radius: 15.0,
    backgroundColor: AppCubit.get(context).isFavorite[productModel.id]? defaultColor: Colors.grey[200],
    child: Icon(Icons.favorite_outline, color: defaultColor,),
  );
  Widget buildCategoriesItem(Data2Model data2model) => Container(
        height: 100,
        width: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(image: NetworkImage(data2model.image)),
            Container(
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              child: Text(
                data2model.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontFamily: 'Janna',
                ),
              ),
            ),
          ],
        ),
      );
}
