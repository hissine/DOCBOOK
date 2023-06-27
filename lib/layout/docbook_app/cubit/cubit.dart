
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/states.dart';
import 'package:ramdan_proj/layout/docbook_app/doctor_home_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_calendar_screen/docbook_calendar_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_home_screen/docbook_home_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_profile_screen/docbook_profile_screen.dart';
import '../../../modules/docbook_app/docbook_messages_screen/docbook_messages_screen.dart';
import '../../../modules/docbook_app/docbook_profile_screen/doctor_profile.dart';

class DocBookCubit extends Cubit<DocBookStates>{
  DocBookCubit() : super(DocBookInitialState());

  static DocBookCubit get(context)=>BlocProvider.of(context);

  int curIndex = 0;

  List<Widget> screensOnBottom=[
    DoctorHomeScreen(),
    DocBookMessagesScreen(),
    DoctorProfile(),
  ];
  List<Widget> bottomScreens= [
    DocBookHomeScreen(),
    DocBookMessagesScreen(),
    const DocBookCalendarScreen(),
    const DocBookProfileScreen(),
  ];
  void changeBottom(int index){
    curIndex=index;
    emit(DocBookChangeBottomNavState());
  }
  File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future getProfileImage(
      ImageSource source,
      ) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image == null) {
      return;
    }
    profileImage = File(image.path);
      emit(UploadImageSuccessState());
  }



}