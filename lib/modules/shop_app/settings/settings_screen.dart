import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  var emailController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  SettingsScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,states)
      {
       if(states is ShopSuccessUserDataStates) {
         emailController.text = states.profileModel.data!.email!;
         nameController.text = states.profileModel.data!.name!;
         phoneController.text = states.profileModel.data!.phone!;
       }
      },
      builder: (context,states)
      {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).profileModel!=null,
          builder:(context) {
            var model=ShopCubit.get(context).profileModel!;
            nameController.text=model.data!.name!;
            emailController.text=model.data!.email!;
            phoneController.text=model.data!.phone!;

            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(states is ShopLoadingUpdateUserStates)
                      const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String? value){
                          if(value!.isEmpty) {
                            return 'Name must not be null';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value){
                          if(value!.isEmpty) {
                            return 'Email must not be null';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String? value){
                          if(value!.isEmpty) {
                            return 'phone must not be null';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const Spacer(),
                      defaultButton(
                        function: (){
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).updateUserDate(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                            );
                            }
                          },
                        text: 'update',
                      ),
                      const SizedBox(height: 20,),
                      defaultButton(
                        function: (){
                          signOut(context);
                        },
                        text: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context)=>const Scaffold(
            backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}
