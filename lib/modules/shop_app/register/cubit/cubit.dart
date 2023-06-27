
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/models/shop_app/login_model.dart';
import 'package:ramdan_proj/modules/shop_app/register/cubit/states.dart';
import 'package:ramdan_proj/shared/network/end_points.dart';
import 'package:ramdan_proj/shared/network/remote/dio_helper/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit(): super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;
  void changeRegisterPasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordState());
  }
}