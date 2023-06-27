import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/models/docbook_app/getdoctormodel.dart';
import 'package:ramdan_proj/models/docbook_app/login_model.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/network/remote/dio_helper/dio_helper.dart';
import '../../../../models/docbook_app/getusermodel.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
class DocLoginCubit extends Cubit<DocLoginStates> {
  DocLoginCubit() : super(DocLoginInitialState());
  static DocLoginCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(DocChangePasswordVisibilityState());
  }
  IconData suffixPasswordConfirmVisible=Icons.visibility_outlined;
  bool passwordConfirmVisible=true;
  void changeConfirmPasswordVisibility(){
    passwordConfirmVisible=!passwordConfirmVisible;
    suffixPasswordConfirmVisible=passwordConfirmVisible?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ConfirmPasswordVisibilityState());
  }

  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final allergiesController=TextEditingController();
  final heightController=TextEditingController();
  final weightController=TextEditingController();
  final bloodController=TextEditingController();
  final martialController=TextEditingController();
  final ageController=TextEditingController();
  final smokerController=TextEditingController();
  final aboutMeController=TextEditingController();
  final specialtyController=TextEditingController();
  final doctorNameController=TextEditingController();
  final doctorPriceController=TextEditingController();
  final aboutDoctorController=TextEditingController();
  String radioValue='';
  void changeRadio(value){
    radioValue=value;
    emit(ChangeRadioState());
  }



  LoginModel? loginModel;
  void userLogin({required String email,required String password}) async {
    emit(DocLoginLoadingState());
    await DioHelper.postData(
        url: "auth/loginUser",
        data:{
          'email':email,
          'password':password,
        }
    ).then((value) {
      loginModel=LoginModel.fromJson(value.data);
      emit(DocLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(DocLoginErrorState(error.toString()));
    });
  }

  void doctorLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await DioHelper.postData(
        url: "auth/loginDoctor",
        data:{
          'email':email,
          'password':password,
        }
    ).then((value) {
      loginModel=LoginModel.fromJson(value.data);
      print(loginModel!.role);
      print(loginModel!.userId);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState());
    });
  }

  GetUserModel? userModel;
  void getUserData(String id)async{
    emit(DocBookLoadingUserDataState());
    await DioHelper.getData(
      url: 'user/account/profile/$id',
      token:token,
    ).then((value) {
      userModel = GetUserModel.fromJson(value.data);
      print(userModel!.userName);
      print(userModel!.birthDate);
      print(userModel!.sId);
      emit(DocBookSuccessUserDataState(userModel!));
    }).catchError((error){
      if(error is DioError){
        print(error.toString());
      }
      print(error.toString());
      emit(DocBookErrorUserDataState(error.toString()));
    });
  }


  getDoctorModel? doctorModel;
  void getDoctorData(String id)async{
    emit(GetDoctorDataLoadingState());
    await DioHelper.getData(
        url: 'doctor/account/profile/$id',
        token: token,
    ).then((value) {
      doctorModel= getDoctorModel.fromJson(value.data);
      print(token);
      print(doctorModel!.photo);
      print(doctorModel!.sId);
      print(doctorModel!.birthDate);
      print(doctorModel!.userName);
      print(doctorModel!.raiting);
      emit(GetDoctorDataSuccessState());
    }).catchError((error){
      if(error is DioError){
        print(error.toString());
      }
      print(token);
      print(id);
      emit(GetDoctorDataErrorState(error.toString()));
    });
  }


  void getProfileData(String id){
    if(doctor==true){
      getDoctorData(id);
    }else{
      getUserData(id);
    }
  }

  void updateUser({
    String? id,
    String? maritalStatus,
    String? allergies,
    String? blood,
    String? smoking,
    String? height,
    String? weight,
  })async {
    emit(DocBookUpdateUserDataLoadingState());
    await DioHelper.putData(
        url: 'user/account/profile/$id',
        token: token,
        data: {
          'maritalstatus':maritalStatus,
          'allergies':allergies,
          'blood':blood,
          'smoking':smoking,
          'height':height,
          'weight':weight,
    }).then((value) {
      getUserData(id.toString());
      showToast(
          text: 'Update Successfully',
          state: ToastStates.SUCCESS,
      );
      emit(DocBookUpdateUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DocBookUpdateUserDataErrorState());
      // print(error);
    });
  }

  void updateDoctor({
    String? id,
    String? userName,
    String? price,
    String? aboutMe,
    String? specialty,
  })async {
    emit(DoctorUpdateDataLoadingState());
    await DioHelper.putData(
        url: 'doctor/account/profile/$id',
        token: token,
        data: {
          'userName':userName,
          'price':price,
          'aboutme':aboutMe,
          'specialty':specialty
        }).then((value) {
      getDoctorData(id.toString());
      showToast(
        text: 'Update Successfully',
        state: ToastStates.SUCCESS,
      );
      emit(DoctorUpdateDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DoctorUpdateDataErrorState());
      // print(error);
    });
  }

  void updateUserPassword({
    String? id,
    String? password,
    String? confirmPassword,
  }) {
    emit(DocBookUpdatePasswordLoadingState());
    DioHelper.putData(
        url: 'user/account/changePassword/$id',
        token: token,
        data: {
          'password':password,
          'confirmPassword':confirmPassword,
        }).then((value) {
      getUserData(id.toString());
      showToast(
        text: 'Update Successfully',
        state: ToastStates.SUCCESS,
      );
      emit(DocBookUpdatePasswordSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DocBookUpdatePasswordErrorState());
    });
  }

  void updateDoctorPassword({
    String? id,
    String? password,
    String? confirmPassword,
  }) {
    emit(DoctorUpdatePasswordLoadingState());
    DioHelper.putData(
        url: '{doctor/account/changePassword/$id',
        token: token,
        data: {
          'password':password,
          'confirmPassword':confirmPassword,
        }).then((value) {
      getUserData(id.toString());
      showToast(
        text: 'Update Successfully',
        state: ToastStates.SUCCESS,
      );
      emit(DoctorUpdatePasswordSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DoctorUpdatePasswordErrorState());
    });
  }

}
