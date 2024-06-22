import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo62/local_data.dart';
import 'package:todo62/view/widgets/default_text.dart';

import '../constant.dart';
import '../widgets/default_form_field.dart';

class BuilderUpdate extends StatelessWidget {
  Map taskModel;
   BuilderUpdate({super.key ,required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[400],
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 350,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DefaultText(text: "Update" , fontWeight: FontWeight.bold,
              fontSize: 19,),
              const SizedBox(height: 10,),
              DefaultFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter valid task";
                  }
                  return null;
                },
                controller: taskController,
                keyboardType: TextInputType.text,
                hintText: "Add Your Task",
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter valid time";
                  }
                  return null;
                },
                controller: timeController,
                keyboardType: TextInputType.text,
                hintText: "Time",
                suffixIcon: const Icon(Icons.alarm),
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    timeController.text = value!.format(context);
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter valid date";
                  }
                  return null;
                },
                controller: dateController,
                keyboardType: TextInputType.text,
                hintText: "Date",
                suffixIcon: const Icon(Icons.calendar_month),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025, 2, 4),
                  ).then((value) {
                    if (value != null) {
                      dateController.text = DateFormat.yMMMd().format(value);
                    }
                  });
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(onPressed: (){
                    updateDataBase(
                      task: taskController.text,
                     time: timeController.text,
                      date: dateController.text,
                      id: taskModel['id']
                    );
                    Fluttertoast.showToast(
                        msg: "Updated",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pop(context);
                  },
                      child: DefaultText(text: "Save", fontSize: 16,fontWeight: FontWeight.w600,)),
                  TextButton(onPressed: (){
                  Navigator.pop(context);
                  },
                      child: DefaultText(text: "cancel",fontSize: 16,fontWeight: FontWeight.w600,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
