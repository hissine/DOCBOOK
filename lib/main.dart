import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/cubit.dart';
import 'package:ramdan_proj/layout/shop_app/cubit/cubit.dart';
import 'package:ramdan_proj/layout/shop_app/shop_layout.dart';
import 'package:ramdan_proj/modules/shop_app/login/shop_login_screen.dart';
import 'package:ramdan_proj/modules/shop_app/onboarding/onboarding_screen.dart';
import 'package:ramdan_proj/shared/bloc_observer/bloc_observer.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/network/local/cashe_helper.dart';
import 'package:ramdan_proj/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:ramdan_proj/shared/styles/themes.dart';
import 'package:ramdan_proj/shared/todo_cubit/cubit.dart';
import 'layout/news_app/cubit/news_cubit.dart';
import 'shared/todo_cubit/states.dart';

void main() async {
  //el method de btdmn en el await ytnfz b3den y3ml run
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();
  //bool? isDark = CasheHelper.getData(key: 'isDark');
  Widget widget;
  bool? onBoarding = CasheHelper.getData(key: 'onBoarding');
  token = CasheHelper.getData(key: 'token');
  print(token);
  if(onBoarding != null){
    if(token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  }else{
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(
   // isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  //final bool? isDark;
  final Widget startWidget;
  const MyApp({super.key,
    //this.isDark,
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsCubit()
                ..getBusiness()
                ..getSports()
                ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              //fromShared: isDark,
            ),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData(),
        ),
        BlocProvider(
            create: (BuildContext context)=>DocBookCubit()
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
               // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
