import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition:state is! ShopLoadingGetFavoriteState ,
          builder: (context)=>SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ListView.separated(
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => buildListProduct(
                  ShopCubit.get(context).favoritesModel!.data!.data![index].product,context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
            ),
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {},
    );
  }


}
