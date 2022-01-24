import 'package:demo_bloc/business_logic/cubits/counter_cubit.dart';
import 'package:demo_bloc/presentation/pages/counter/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CounterCubit(), child: const CounterView());
  }
}
