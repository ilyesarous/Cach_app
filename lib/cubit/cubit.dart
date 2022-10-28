import 'package:check_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../catch_helper/catch_helper.dart';
import '../screens/historique.dart';
import '../screens/main_screen.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit(): super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  //bottomNavBar :
  int index = 0;
  List<Widget> screens =[
    MainScreen(),
    ArchiveScreen(),
  ];
  // bottomSheet :
  bool isBottomSheetShown = false;
  IconData currentIcon = Icons.add;
  bool isIconAdd = true;

  //DataBase
  late Database database;
  List amount= [];

  void changeBottomNavBar(int currentIndex){
    index = currentIndex;
    emit(AppBottomNavBarChangeState());
  }

//catch helper

  double montantTotal = 0;

  void changeMontant(double x){
    montantTotal = x;
    emit(AppSaveState());
  }

  void totalAmountSaviour({double? x,}) {
    if (x != null) {
      montantTotal = x;
    } else {
      CachHelper.putData(key: 'montantTotal', value: montantTotal).then((
          value) {
        emit(AppSaveState());
      });
    }
  }

  void createDB() async {
    openDatabase(
        'AmountController.db',
        version: 1,
        onCreate: (
            Database database,
            int version) async {
          // When creating the db, create the table
          await database.execute(
              'CREATE TABLE AmountController ('
                  'id INTEGER PRIMARY KEY,'
                  ' amountTotal TEXT,'
                  ' amount TEXT,'
                  ' title TEXT,'
                  ' date TEXT)'
          ).then((value) {
            print('database created');
          });
        },
        onOpen: (database) {
          getDataBase(database);
          print('database opened');
        },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });

  }
  insertDB({
    required String amountTotal,
    required String title,
    required String amount,
    required String date,
  }){
    database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO AmountController(amountTotal, amount, title, date) '
              'VALUES("$amountTotal", "$amount", "$title", "$date")'
      ).then((value){
        print("$value inserted successfuly!");
        emit(AppInsertIntoDataBaseState());
        getDataBase(database);
      });
    });

    return null;
  }

  void getDataBase(database){
    amount = [];
    database.rawQuery('select * from AmountController').then((value){
      value.forEach((element){
        amount.add(element);
      });
      print(amount);
      emit(AppGetFromDataBaseState());
    });
  }

  void deleteData({
    required int id,
  })async{
    database.rawDelete('DELETE FROM AmountController WHERE id = ?', [id]);
    getDataBase(database);
    emit(AppDeleteFromDataBaseState());
  }
}
