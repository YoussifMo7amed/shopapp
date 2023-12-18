
// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/shared/components.dart/constants.dart';

import '../../../shared/components.dart/components.dart';

class SettengsScreen extends StatelessWidget {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopcubit, shopstates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = shopcubit.get(context).UserModel;
          namecontroller.text = model!.data!.name!;
          emailcontroller.text = model.data!.email!;
          phonecontroller.text = model.data!.phone!;
          return ConditionalBuilder(
            condition: shopcubit.get(context).UserModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  dfaultFormField(
                      controller: namecontroller,
                      type: TextInputType.name,
                      label: 'name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be Empty';
                        } else {
                          return null;
                        }
                      },
                      prefix: Icons.person),
                  const SizedBox(
                    height: 10,
                  ),
                  dfaultFormField(
                    controller: emailcontroller,
                    type: TextInputType.emailAddress,
                    label: 'email',
                    prefix: Icons.email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'email must not be Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  dfaultFormField(
                    controller: phonecontroller,
                    type: TextInputType.phone,
                    label: 'phone',
                    prefix: Icons.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                      function: () {
                        shopcubit.get(context).Updateprofile(
                              email: emailcontroller.text,
                              name: namecontroller.text,
                              phone: phonecontroller.text,
                            );
                      },
                      text: 'UPDATE'),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                      function: () {
                        logout(context);
                      },
                      text: 'LOGOUT'),
                ],
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        });
  }
}
