
// ignore_for_file: camel_case_types

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/models/Home/home_model.dart';
import 'package:shopapp/models/categories/categories_model.dart';
import 'package:shopapp/shared/components.dart/components.dart';

class productsScreen extends StatelessWidget {
  const productsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopcubit, shopstates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState)
        {
          if(!state.favoritesModel.status!)
          {
            showToast(msg: state.favoritesModel.message,state: ToastState.Error);
          }
        
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: shopcubit.get(context).homemodel != null &&
              shopcubit.get(context).categoriesmodel != null,
          builder: (context) => productwidget(shopcubit.get(context).homemodel!,
              shopcubit.get(context).categoriesmodel!,context),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget productwidget(Homemodel model, Categoriesmodel categoriesmodel,context) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model.data!.banners
                .map(
                  (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover),
                )
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            )),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 100.0,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoriesmodel.data!.data[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 10.0,
                        ),
                    itemCount: categoriesmodel.data!.data.length),
              ),
              const Text(
                'New Products',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            shrinkWrap: true,
            childAspectRatio: 1 / 1.51,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(model.data!.products.length,
                (index) => buildGridproduct(model.data!.products[index],context)),
          ),
        )
      ],
    ),
  );
}

Widget buildCategoryItem(Datamodel model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image!),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
            width: 100.0,
            color: Colors.black.withOpacity(0.6),
            child: Text(
              model.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ))
      ],
    );

Widget buildGridproduct(ProductsModel model,context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(
                  model.image!,
                ),
                height: 200,
                width: double.infinity,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: const Text(
                    'Discount',
                    style: TextStyle(fontSize: 14.0),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 14.0, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(
                          fontSize: 12, color: Colors.blue, height: 1.3),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.old_price.round()}',
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            height: 1.3),
                      ),
                    const Spacer(),
                    CircleAvatar(
                      
                      backgroundColor: shopcubit.get(context).favorites[model.id]!&&shopcubit.get(context).favorites[model.id]!=null?Colors.red:Colors.grey,
                      child: IconButton(
                      color: Colors.white,
                          onPressed: () {
                             shopcubit.get(context).ChangeFavorites(model.id);
                          },
                          icon: const Icon(
                            Icons.favorite_border_outlined,
                          )),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
