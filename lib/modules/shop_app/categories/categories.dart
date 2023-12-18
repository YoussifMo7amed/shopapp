
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/models/categories/categories_model.dart';
import 'package:shopapp/shared/components.dart/components.dart';

class categoriesScreen extends StatelessWidget {
  const categoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopcubit, shopstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCat(shopcubit.get(context).categoriesmodel!.data!.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: shopcubit.get(context).categoriesmodel!.data!.data.length);
      },
    );
  }
}

Widget buildCat(Datamodel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
              image: NetworkImage(
model.image!
)),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            model.name!,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
