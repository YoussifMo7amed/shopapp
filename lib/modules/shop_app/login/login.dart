// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/shop_layout.dart';
import 'package:shopapp/modules/shop_app/login/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/login/cubit/states.dart';
import 'package:shopapp/modules/shop_app/register/register.dart';
import 'package:shopapp/network/local/cache.dart';
import 'package:shopapp/shared/components.dart/components.dart';
import 'package:shopapp/shared/components.dart/constants.dart';

class LoginScreen extends StatelessWidget {
  var Formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopLoginSuccesState) {
              if (state.loginModel.status!) {
                casheHealper
                    .saveData(key: 'Token', value: state.loginModel.data!.token)
                    .then((value) {
                  Token = ShopLoginCubit.get(context).loginModel!.data!.token!;
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
                        Text('LOGIN',
                            style: Theme.of(context).textTheme.headlineLarge),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        dfaultFormField(
                          controller: emailcontroller,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          // ignore: dead_code
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
                          sufix: ShopLoginCubit.get(context).suffix,
                          sufixFunction: () {
                            ShopLoginCubit.get(context).changepassword();
                          },
                          ispassword: ShopLoginCubit.get(context).ispassword,
                          onsubmit: (value) {
                            if (Formkey.currentState!.validate()) {
                              ShopLoginCubit.get(context).UserLogin(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                            }
                          },
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
                        ConditionalBuilder(
                            condition: state is! ShopLoginLodingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (Formkey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).UserLogin(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text);
                                  }
                                },
                                text: 'Login',
                                isUpperCase: true,
                                background: Colors.blue),
                            fallback: (context) =>
                                const Center(child: CircularProgressIndicator())),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextButton(
                                onPressed: () {
                                 navigateTo(context, shopRegisterScreen());
                                },
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(fontSize: 16.0),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
