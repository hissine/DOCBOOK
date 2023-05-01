import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/shop_app/cubit/cubit.dart';
import 'package:ramdan_proj/layout/shop_app/cubit/states.dart';
import 'package:ramdan_proj/models/shop_app/categories_model.dart';
import 'package:ramdan_proj/models/shop_app/home_model.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesStates){
          if(state.model.status==false){
            showToast(
                text: state.model.message!,
                state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
            cubit.homeModel != null && cubit.categoriesModel!=null,
          builder: (context) => builderWidget(
              cubit.homeModel ,
              cubit.categoriesModel,
              context
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builderWidget(
      HomeModel? model,
      CategoriesModel? categoriesModel,
      context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 200.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(
                  seconds: 3,
                ),
                autoPlayAnimationDuration: const Duration(
                  seconds: 1,
                ),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index)=>
                          buildCategoryItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context,index)=>const SizedBox(
                        width: 10,
                      ),
                      itemCount: categoriesModel!.data!.data.length,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.6,
                  children: List.generate(
                    model.data!.products.length,
                    (index) =>buildGridProduct(
                        model.data!.products[index],
                        context),
                  ),
              ),
            ),
          ],
        ),
  );
  Widget buildCategoryItem([DataModel? model])=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
       Image(
        image: NetworkImage('${model!.image}'),
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100,
        child: Text(
          '${model.name}',
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
  Widget buildGridProduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: double.infinity,
              height: 200,
            ),
            if(model.discount!=0)
              Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
              ),
              child: const Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 8.0,
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
        Padding (
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if(model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: const TextStyle(
                        height: 1.3,
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ) ,
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                      onPressed: (){
                      ShopCubit.get(context).changeFavorites(model.id);
                      print(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor:  ShopCubit.get(context).favorites[model.id]!&&ShopCubit.get(context).favorites!=null?defaultColor:Colors.grey,
                        radius: 15.0,
                        child: const Icon(
                            Icons.favorite_border,
                          size: 12,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
