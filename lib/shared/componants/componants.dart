import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultFormField({
  @required TextEditingController controller,
  @required String label,
  Function validator,
  bool obscure = false,
  IconData prefix,
  IconData suffix,
  IconData pressedSuffix,
  Function onEditingComplete,
  Function onChange,
  TextInputType inputType,
  Function onFieldSubmitted,
  Function onTap,
  Function suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
      keyboardType: inputType,
      obscureText: obscure,
      onEditingComplete: onEditingComplete,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
    );

Widget defaultButton({
  @required Function onPressed,
  @required String label,
  double fontSize = 25.0,
  FontWeight fontWeight = FontWeight.normal,
  Color colors = Colors.white,
  Color buttonColor = defaultColor,
  double borderRadius = 0,
  double height = 50,
}) =>
    ElevatedButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          //color: buttonColor,
        ),
        height: height,
        width: double.infinity,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: colors,
            ),
          ),
        ),
      ),
    );

Widget defaultTextButton({
  @required Function onPressed,
  @required String label,
  double fontSize = 25.0,
  FontWeight fontWeight = FontWeight.normal,
  Color colors,
}) =>
    TextButton(
        onPressed: onPressed,
        child: Container(
          margin: EdgeInsetsDirectional.only(end: 20),
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: colors,
            ),
          ),
        ));

void showToast({
  @required String massage,
  Color color,
}) => Fluttertoast.showToast(
    msg: massage,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0
);


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          AppCubit.get(context).changeFavorite(model.id);
                        },
                        icon: AppCubit.get(context).isFavorite[model.id]? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_outline, color: defaultColor,)
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
