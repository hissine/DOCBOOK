// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/shop_app/cubit/states.dart';
import 'package:ramdan_proj/models/shop_app/categories_model.dart';
import 'package:ramdan_proj/models/shop_app/change_favorites_model.dart';
import 'package:ramdan_proj/models/shop_app/favorites_model.dart';
import 'package:ramdan_proj/models/shop_app/profile_model.dart';
import 'package:ramdan_proj/modules/shop_app/categories/categories_screen.dart';
import 'package:ramdan_proj/modules/shop_app/favorites/favorites_screen.dart';
import 'package:ramdan_proj/modules/shop_app/products/products_screen.dart';
import 'package:ramdan_proj/modules/shop_app/settings/settings_screen.dart';
import 'package:ramdan_proj/shared/components/constants.dart';

import '../../../models/shop_app/home_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int curIndex=0;

  List<Widget>BottomScreens=[
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
     SettingsScreen(),
  ];

  void changeBottom(int index){
    curIndex=index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int?,bool?>favorites= { };

  void getHomeData(){
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(
        url: HOME,
        token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //printFullText(homeModel.toString());
      //print(homeModel!.status);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorite,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataStates());
    }).catchError((error){
      emit(ShopErrorHomeDataStates(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      //printFullText(categoriesModel.toString());
      //print(categoriesModel!.status);
      emit(ShopSuccessCategoriesDataStates());
    }).catchError((error){
      emit(ShopErrorCategoriesDataStates(error));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int? productId)
  {
    favorites[productId]= !(favorites[productId]??false);
    emit(ShopChangeFavoritesStates());

    DioHelper.postData(
        token: token,
        url: FAVORITES,
        data: {
          'product_id': productId,
        },
    ).then((value) {

      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(changeFavoritesModel!.status==false)
      {
        favorites[productId] = !(favorites[productId]==false);
      }else{
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel!));
    }).catchError((error){
      favorites[productId]=!(favorites[productId]??false);
      emit(ShopErrorChangeFavoritesStates(error));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData(){
    emit(ShopLoadingGetFavoriteState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(categoriesModel.toString());
      print(categoriesModel!.status);
      emit(ShopSuccessGetFavoriteState());
    }).catchError((error){
      emit(ShopErrorGetFavoriteState());
    });
  }




  ProfileModel? profileModel;
  void getUserData() {
    emit(ShopLoadingUserDataStates());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      printFullText(profileModel!.data!.name!);
      emit(ShopSuccessUserDataStates(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataStates(error.toString()));
    });
  }

  void updateUserDate({
    required name,
    required phone,
    required email,
}){
    emit(ShopLoadingUpdateUserStates());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name':name,
          'phone':phone,
          'email':email,
    }).then((value) {
      profileModel =ProfileModel.fromJson(value.data);
      print(profileModel!.data!.name);
      emit(ShopSuccessUpdateUserStates(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserStates(error));
    });
    
  }
}