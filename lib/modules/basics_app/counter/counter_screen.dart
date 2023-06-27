import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/modules/basics_app/counter/cubit/counter_cubit.dart';
import 'package:ramdan_proj/modules/basics_app/counter/cubit/counter_states.dart';

//stateless contain 1 class provide widget
//stateful contain 2 classes
//1.first class provide widget
//2.second class provide state from this widget
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if(state is CounterPlusState) print('Plus State ${state.counter} ');
          if(state is CounterMinusState) print('Minus State ${state.counter} ');
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Counter',
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).minus();
                    },
                    child: const Text(
                        'MINUS'
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0
                    ),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 50.0,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).plus();
                    },
                    child: const Text(
                      'PLUS',
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
  }

