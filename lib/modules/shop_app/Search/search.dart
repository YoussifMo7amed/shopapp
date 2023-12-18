
// ignore_for_file: must_be_immutable, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_app/Search/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/Search/cubit/states.dart';
import 'package:shopapp/shared/components.dart/components.dart';

class searchScreen extends StatelessWidget {
  var Formkey = GlobalKey<FormState>();
  var textcontroler = TextEditingController();

  searchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, Shopsearchstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: Formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      dfaultFormField(
                        controller: textcontroler,
                        type: TextInputType.text,
                        label: 'Search',
                        prefix: Icons.search,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Text';
                          }
                          return null;
                        },
                        onsubmit: (String Text) {
                          ShopSearchCubit.get(context).GetSearch(Text: Text);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is ShopsearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is ShopsearchSuccesState)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => buildListproduct(
                                  ShopSearchCubit.get(context)
                                      .model!
                                      .data!
                                      .data![index],
                                  context,
                                  isOldprice: false),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount: ShopSearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data!
                                  .length),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
