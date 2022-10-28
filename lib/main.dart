import 'package:bloc/bloc.dart';
import 'package:check_app/check_app/home_page.dart';
import 'package:check_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'catch_helper/catch_helper.dart';
import 'cubit/cubit.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await CachHelper.init();

  double? amount =CachHelper.getData(key: "montantTotal");

  runApp(MyApp(amount));
}

class MyApp extends StatelessWidget {

  final double? amount;
  MyApp(this.amount);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDB()..totalAmountSaviour(x: amount),
      child:BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
