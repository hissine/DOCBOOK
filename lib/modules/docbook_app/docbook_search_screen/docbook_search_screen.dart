import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/models/docbook_app/searchmodel.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_home_screen/doctor_page.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_search_screen/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_search_screen/cubit/states.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  final searchController=TextEditingController();
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: defColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Doctors',
                style: TextStyle(
                  color: defColor,
                ),
              ),
              centerTitle: true,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value){
                        if(value!.isEmpty){
                          return 'enter text to search';
                        }
                        return null;
                      },
                      label: 'Search',
                      prefix: Icons.search,
                      onSubmit: (String text){
                        SearchCubit.get(context).search(text);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    if(state is SearchSuccessState)
                     Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>buildSearchItem(
                            context,
                            SearchCubit.get(context).model!,
                        ),
                        separatorBuilder: (context,index)=>const SizedBox(height: 20,),
                        itemCount: SearchCubit.get(context).model!.doctors.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
Widget buildSearchItem(context,searchModel model)=>Container(
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          spreadRadius: 3,
          blurRadius: 7,

        )
      ]
  ),
  padding: const EdgeInsets.all(20),
  height: 130,
  width: double.infinity,
  child: InkWell(
    onTap: (){
      navigateTo(context,const DoctorScreen());
    },
    child: Row(
      children: [
        const CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage('assets/images/doc2.png'),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dr Zahraa Magdy',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: defColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Expanded(
                child: Text(
                  'Consultant Specializing in children and newborns',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    '150 reviews',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      color: defColor,
                      borderRadius:BorderRadius.circular(10),
                    ),
                    child:const Center(
                      child: Text(
                        'Prize : 50\$',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
