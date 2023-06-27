
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/models/docbook_app/searchmodel.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_search_screen/cubit/states.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/network/remote/dio_helper/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  searchModel? model;
  void search(String? userName){
    emit(SearchLoadingState());
    DioHelper.getData(
        url: 'home/doctor',

    ).then((value) {
      model=searchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}