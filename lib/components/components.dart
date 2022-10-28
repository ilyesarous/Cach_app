import 'package:check_app/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget defaultInput({
  required String label,
  required IconData prefixIcon,
  required TextEditingController controller,
  var onTap,
  var type,
  var validator,
})=> TextFormField(
  decoration: InputDecoration(
    label: Text(
  label,
  ),
  prefixIcon: Icon(
    prefixIcon,
  ),
  border: OutlineInputBorder(),
  ),
  controller: controller,
  onTap: onTap,
  keyboardType: type,
  validator: validator,
);

Widget ArchiveBuilder(Map model ,context){
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsetsDirectional.only(
                start: 60
            ),
            child: Text(
              '${model['amount']}',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      ],
    ),
    onDismissed: (direction) => AppCubit.get(context).deleteData(id: model['id']),
  );
}

Widget archiveBuilder({
  required List amount,
}) => ConditionalBuilder(
  condition: amount.isNotEmpty,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: ArchiveBuilder(amount[index], context),
    ),
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey[300],
      ),
    ),
    itemCount: amount.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          'No Transactions Yet!',
          style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    ),
  ),
);