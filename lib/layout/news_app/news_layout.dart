import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/news_app/cubit/news_cubit.dart';
import 'package:ramdan_proj/shared/components/components.dart';

import '../../modules/news_app/search/search_screen.dart';
import '../../shared/todo_cubit/cubit.dart';
import 'cubit/news_states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  )),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(
                    Icons.brightness_2_rounded,
                  ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.curIndex,
            onTap: (index){
              cubit.changeIndex(index);
            },
          ),
          body: cubit.screens[cubit.curIndex],
        );
      },
    );
  }
}
