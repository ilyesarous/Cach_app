import 'package:check_app/catch_helper/catch_helper.dart';
import 'package:check_app/cubit/cubit.dart';
import 'package:check_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../check_app/home_page.dart';
import '../components/components.dart';

class MainScreen extends StatelessWidget {

  var amountController = TextEditingController();
  var titleController = TextEditingController();
  var dateController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          double amountTotal = cubit.montantTotal;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(
                            1,
                            5,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        )
                        ], //BoxShadow
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Amount',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            '${cubit.montantTotal}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultInput(
                              label: 'Amount',
                              prefixIcon: Icons.attach_money_outlined,
                              controller: amountController,
                              type: TextInputType.number,
                              validator: (value){
                                if(value.isEmpty){
                                  return 'amount required!';
                                }
                              }
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          defaultInput(
                              label: 'Title',
                              prefixIcon: Icons.title,
                              controller: titleController,
                              type: TextInputType.text,
                              validator: (value){
                                if(value.isEmpty){
                                  return 'title required!';
                                }
                              }
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultInput(
                              label: 'Date',
                              prefixIcon: Icons.calendar_month,
                              controller: dateController,
                              type: TextInputType.datetime,
                              validator: (value){
                                if(value.isEmpty){
                                  return 'date required!';
                                }
                              },
                              onTap: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2026-12-30'),
                                ).then((value) {
                                  dateController.text = DateFormat.yMMMd().format(value!).toString();
                                });
                              }
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                cubit.insertDB(
                                  amountTotal: (amountTotal + double.parse(amountController.text)).toString(),
                                  title: titleController.text,
                                  amount: amountController.text,
                                  date: dateController.text,
                                );
                                cubit.changeMontant(amountTotal + double.parse(amountController.text));
                                titleController.text = '';
                                amountController.text = '';
                                dateController.text = '';
                              }
                            },
                            child: Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.green[300],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                cubit.insertDB(
                                  amountTotal: (amountTotal - double.parse(amountController.text)).toString(),
                                  title: titleController.text,
                                  amount: amountController.text,
                                  date: dateController.text,
                                );
                                cubit.changeMontant(amountTotal - double.parse(amountController.text));
                                titleController.text = '';
                                amountController.text = '';
                                dateController.text = '';
                              }
                            },
                            child: Text(
                              'Min',
                              style: TextStyle(
                                color: Colors.green[300],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
