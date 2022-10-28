import 'package:check_app/components/components.dart';
import 'package:check_app/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/states.dart';
import '../screens/historique.dart';
import '../screens/main_screen.dart';

class HomePage extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                'Check App',
              ),
              backgroundColor: Colors.green[300],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.home
                  ),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive,
                    ),
                    label: 'archive'
                ),
              ],
              currentIndex: cubit.index,
              selectedItemColor: Colors.green[300],
              onTap: (value) => cubit.changeBottomNavBar(value),
            ),
            body: cubit.screens[cubit.index],
          );
        },
      );
  }
}
