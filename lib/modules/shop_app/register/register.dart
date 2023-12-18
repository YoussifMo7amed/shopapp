// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_app/register/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/register/cubit/states.dart';
import 'package:shopapp/network/local/cache.dart';

import '../../../layout/shop_layout/shop_layout.dart';
import '../../../shared/components.dart/components.dart';
import '../../../shared/components.dart/constants.dart';

class shopRegisterScreen extends StatelessWidget {
  var Formkey = GlobalKey<FormState>();
    var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
    var phonecontroller = TextEditingController();

  shopRegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return
 Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
            if (state is ShopRegisterSuccesState) {
              if (state.loginModel.status!) {
         
                casheHealper
                    .saveData(key: 'Token', value: state.loginModel.data!.token)
                    .then((value) {
                      Token=ShopRegisterCubit.get(context).loginModel!.data!.token!;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShopLayout(),
                      ),
                      (route) => false);
                });
              } else {
                showToast(
                    msg: state.loginModel.message, state: ToastState.Error);
              }
            }
          },

          builder: (context, state) {
    return Form(
      key: Formkey,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('REGISTER',
                    style: Theme.of(context).textTheme.headlineLarge),
                Text(
                  'Register now to browse our hot offers',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                dfaultFormField(
                  controller: namecontroller,
                  type: TextInputType.name,
                  label: 'User Name',
                  prefix: Icons.person,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter User Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                dfaultFormField(
                  controller: emailcontroller,
                  type: TextInputType.emailAddress,
                  label: 'Email Address',
                  prefix: Icons.email_outlined,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Email must not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                dfaultFormField(
                  controller: passwordcontroller,
                  type: TextInputType.visiblePassword,
                  label: 'Password',
                  prefix: Icons.lock_outline,
                  sufix: ShopRegisterCubit.get(context).suffix,
                  sufixFunction: () {
                    ShopRegisterCubit.get(context).changepassword();
                  },
                  ispassword: ShopRegisterCubit.get(context).ispassword,

                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                dfaultFormField(
                  controller: phonecontroller,
                  type: TextInputType.phone,
                  label: 'Phone Number',
                  prefix: Icons.phone,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter PhoneNumber';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                ConditionalBuilder(
                    condition: state is! ShopRegisterLodingState,
                    builder: (context) => defaultButton(
                        function: () {
                          if (Formkey.currentState!.validate()) {
                            ShopRegisterCubit.get(context).UserRegister(
                              name: namecontroller.text,
                                email: emailcontroller.text,
                                password: passwordcontroller.text,
                                phone: phonecontroller.text
                                );
                          }
                        },
                        text: 'REGISTER',
                        isUpperCase: true,
                        background: Colors.blue),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator())),
                const SizedBox(
                  height: 15.0,
                ),
                    ],
            ),
          ),
        ),
      ),
    );}
 ) )); }}
   

