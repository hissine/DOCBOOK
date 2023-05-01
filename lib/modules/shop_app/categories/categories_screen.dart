import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/categories_model.dart';
import '../../../shared/components/components.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => buildCatItem(
                  ShopCubit.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount:
              ShopCubit.get(context).categoriesModel!.data!.data.length),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          width: 80.0,
          height: 80.0,
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          '${model.name}',
          style:
          const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
