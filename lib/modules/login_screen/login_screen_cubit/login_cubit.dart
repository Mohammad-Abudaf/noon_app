import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/login_screen/login_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(Initial());
  bool isBoard = false;
  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel loginModel;
  void userLogin ({
  @required String email, 
    @required String password, 
}){
    emit(PostDataLoading());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.jsonData(value.data);
      emit(PostDataSuccess(loginModel));
    }).catchError((error){
      print ('the error is ${error.toString()}');
      emit(PostDataError(error.toString()));
    });
  }
}
