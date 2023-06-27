import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/news_app/cubit/news_states.dart';
import 'package:ramdan_proj/shared/network/remote/dio_helper/dio_helper.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List <Widget> screens=[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  List <BottomNavigationBarItem> bottomItems=[
    const BottomNavigationBarItem(
        icon:Icon(
          Icons.business,
        ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];
  int curIndex=0;
  void changeIndex(int index){
    curIndex=index;
    if(index==1) {
      getSports();
    } else if(index==2) {
      getScience();
    }
    emit(NewsChangeBottomNavBarState());
  }
  List<dynamic> business=[];
  List<dynamic> sports=[];
  List<dynamic> science=[];
  void getBusiness(){
    //34an el indicator yelf awl ma ybd' ygeb el data
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'business',
          'apiKey':'814631bc91a7499681bd575352ee0719',
        },
    ).then((value) {
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetBusinessErrorState(error.toString()));
        });
  }
  void getSports(){
    if(sports.length==0){
//34an el indicator yelf awl ma ybd' ygeb el data
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'sports',
          'apiKey':'814631bc91a7499681bd575352ee0719',
        },
      ).then((value) {
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }
  void getScience() {
    if (science.length == 0) {
      //34an el indicator yelf awl ma ybd' ygeb el data
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '814631bc91a7499681bd575352ee0719',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }
  List<dynamic> search=[];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': value,
          'apiKey': '814631bc91a7499681bd575352ee0719',
        },
      ).then((value) {
        search = value.data['articles'];
        print(search[0]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
  }
}