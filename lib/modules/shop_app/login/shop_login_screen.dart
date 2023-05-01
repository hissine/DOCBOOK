import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/shop_app/shop_layout.dart';
import 'package:ramdan_proj/modules/shop_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/shop_app/login/cubit/states.dart';
import 'package:ramdan_proj/modules/shop_app/register/shop_register_screen.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/network/local/cashe_helper.dart';

import '../../../shared/components/constants.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status!){
              //print(state.loginModel.data!.token);
              //print(state.loginModel.message);
              CasheHelper.saveData(key: 'token', value:state.loginModel.data!.token).then((value) {
                token=state.loginModel.data!.token!;
                navigateAndFinish(context, const ShopLayout());
              });
            }else{
              //print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message!,
                  state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Salla',
              ),
            ),
            body: Center(
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
                              'Hello.',
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Sign in to buy now !',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color:Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value){
                                if(value!.isEmpty)
                                {
                                  return 'Please Enter Your Email!';
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
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (value){
                                if(value!.isEmpty)
                                {
                                  return 'Please Enter Your Password!';
                                }else{
                                  return null;
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock,
                              isPassword: ShopLoginCubit.get(context).isPassword,
                              suffix: ShopLoginCubit.get(context).suffix,
                              suffixPressed:(){
                                ShopLoginCubit.get(context).changePasswordVisibility();
                              },
                              onSubmit: (value){
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                  );
                                }
                              }
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (BuildContext context) =>
                                defaultButton(
                                  function: (){
                                    if(formKey.currentState!.validate()){
                                      ShopLoginCubit.get(context).userLogin(
                                        email:emailController.text ,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  text: 'join now',
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
                                const Text('Don\'t have account?'),
                                defaultTextButton(
                                  function: (){
                                    navigateTo(
                                      context,
                                      ShopRegisterScreen(),
                                    );
                                  },
                                  text: 'sign up',
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
