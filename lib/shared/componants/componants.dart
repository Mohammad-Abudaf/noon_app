import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
}) =>
    ElevatedButton(
      onPressed: onPressed,
      child: Container(
        height: 50,
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