import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login_screen/login_screen_cubit/login_cubit.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/componants/componants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isShown = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is PostDataSuccess){
            if (state.loginData.status) {
              print(state.loginData.massage.toString());
              showToast(massage: state.loginData.massage.toString(), color: Colors.green);
              print(state.loginData.data.token);

              CacheHelper.saveData(key: 'token', value: state.loginData.data.token).then((value)
              => navigateAndFinish(context, HomeLayout()));
            } else {
              print(state.loginData.massage.toString());
              showToast(massage: state.loginData.massage.toString(), color: Colors.red);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 50.0,
                              fontFamily: 'Janna',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          'login to get our new hot offers',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17.0,
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        defaultFormField(
                          onFieldSubmitted: (String value) {
                            passwordController.text = '$value';
                          },
                          controller: emailController,
                          label: 'email',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'email must no be empty';
                            }
                            return null;
                          },
                          prefix: Icons.email,
                        ),
                        SizedBox(height: 20.0,),
                        defaultFormField(
                          onFieldSubmitted: (String value) {
                            passwordController.text = '$value';
                          },
                          controller: passwordController,
                          suffixPressed: () {
                            setState(() {
                              isShown = !isShown;
                            });
                          },
                          label: 'password',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          prefix: Icons.lock,
                          suffix: isShown ? Icons.visibility : Icons
                              .visibility_off,
                          inputType: TextInputType.visiblePassword,
                          obscure: isShown,
                        ),
                        SizedBox(height: 20.0,),
                        ConditionalBuilder(
                          condition: state is! PostDataLoading,
                          builder:(context) => defaultButton(
                              label: 'LOGIN',
                              onPressed: () {
                                if(formKey.currentState.validate()){
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              fontWeight: FontWeight.bold
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            defaultTextButton(
                                  label: 'Register Now',
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  fontSize: 17.0,
                                  colors: defaultColor
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}