// ignore_for_file: camel_case_types

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';
import '../../../layout/shop_layout/cubit/states.dart';
import '../../../shared/components.dart/components.dart';

class favoritessScreen extends StatelessWidget {
  const favoritessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopcubit, shopstates>(
      listener: (context, state) {},
      builder: (context, state) {
       return ConditionalBuilder(
        condition: state is! ShopLoadingGetFavoritesState,
         builder:(context) =>  ListView.separated(
              itemBuilder: (context, index) => buildListproduct(shopcubit.get(context).favoriteModel!.data!.data![index].product!,context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount:shopcubit.get(context).favoriteModel!.data!.data!.length ),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
       );
     }
);}}
