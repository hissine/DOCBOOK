
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/modules/shop_app/login/shop_login_screen.dart';
import 'package:ramdan_proj/modules/shop_app/register/cubit/cubit.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/network/local/cashe_helper.dart';

import '../../../shared/components/components.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key? key}) : super(key: key);
  var formKey= GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (BuildContext context, state) {
          if(state is ShopRegisterSuccessState){
            if(state.loginModel.status!){
              print(state.loginModel.data!.token);
              print(state.loginModel.message);
              CasheHelper.saveData(key: 'token', value:state.loginModel.data!.token).then((value) {
                token=state.loginModel.data!.token!;
                navigateAndFinish(context, ShopLoginScreen());
              });
            }else{
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign up',
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Register now to browse our hot offers',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color:Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (value){
                                if(value!.isEmpty)
                                {
                                  return 'Please Enter Your Name!';
                                }else{
                                  return null;
                                }
                              },
                              label: 'User Name',
                              prefix: Icons.person,

                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value){
                                if(value!.isEmpty)
                                {
                                  return 'Please Enter Your email';
                                }else{
                                  return null;
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                validate: (value){
                                  if(value!.isEmpty){
                                    return 'password must not be empty';
                                  }
                                  return null;
                                },
                                label: 'Password',
                                prefix: Icons.lock_outline,
                                isPassword: ShopRegisterCubit.get(context).isPassword,
                                suffix: ShopRegisterCubit.get(context).suffix,
                                suffixPressed:(){
                                  ShopRegisterCubit.get(context).changeRegisterPasswordVisibility();
                                },
                                onSubmit: (value){
                                  if(formKey.currentState!.validate()){
                                    ShopRegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text
                                    );
                                  }
                                }
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value){
                                if(value!.isEmpty)
                                {
                                  return 'Please Enter Your phone';
                                }else{
                                  return null;
                                }
                              },
                              label: 'Phone',
                              prefix: Icons.phone,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopRegisterLoadingState,
                              builder: (BuildContext context) =>
                                  defaultButton(
                                    function: (){
                                      if(formKey.currentState!.validate()){
                                        ShopRegisterCubit.get(context).userRegister(
                                          email:emailController.text ,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text
                                        );
                                      }
                                    },
                                    text: 'Register',
                                    isUpperCase: true,
                                    radius: 5.0,
                                  ),
                              fallback: (BuildContext context)=>
                              const Center(
                                  child:
                                  CircularProgressIndicator()
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account'),
                                defaultTextButton(
                                  function: (){
                                    navigateTo(
                                      context,
                                      ShopLoginScreen(),
                                    );
                                  },
                                  text: 'login',
                                ),
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
