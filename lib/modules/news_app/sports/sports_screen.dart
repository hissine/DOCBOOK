import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/news_app/cubit/news_cubit.dart';

import '../../../layout/news_app/cubit/news_states.dart';
import '../../../shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context, state){
        var list=NewsCubit.get(context).sports;
        return articleBuilder(list,context);
      },
    );
  }
}
