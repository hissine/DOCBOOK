import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/shop_app/cubit/cubit.dart';
import 'package:ramdan_proj/layout/shop_app/cubit/states.dart';
import 'package:ramdan_proj/shared/components/components.dart';

import '../../modules/shop_app/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
       var cubit = ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: const Text(
              'Salla',
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context,  ShopSearchScreen());
                  },
                  icon: const Icon(Icons.search)
              ),
            ],
          ),
          body: cubit.BottomScreens[cubit.curIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.curIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined
                  ),
                label:'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.category_outlined
                  ),
                  label:'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.favorite_outline
                  ),
                  label:'Favorites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.settings_outlined
                  ),
                  label:'Settings'
              ),

            ],
          ),
        );
      },
    );
  }
}
