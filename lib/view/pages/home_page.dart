import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo62/view/pages/delete_page.dart';
import 'package:todo62/view/pages/done_page.dart';
import 'package:todo62/view/pages/tasks_page.dart';

import '../../local_data.dart';
import '../widgets/default_form_field.dart';
import '../widgets/default_text.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    creteDataBase();
    super.initState();
  }
  int currentIndex= 0  ;
  var taskController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  List<Widget> screens = const [
    TasksPage(),
    DonePage(),
   // DeletePage(),
  ];
   List<String> titles= ["Tasks", "Done"];
   bool isBottomSheet = false;
   IconData iconData = Icons.add;

   // as String  vs to String
  void changeBottomSheet({required IconData icon , required bool isShow}){
    isBottomSheet = isShow;
    icon = iconData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey ,
      appBar: AppBar(
      centerTitle: true,
      title:  DefaultText(text: titles[currentIndex],),
    ),
      // body:     Container(
      //   padding: const EdgeInsets.all(16),
      //   height: 230,
      //   decoration: BoxDecoration(
      //     color: Colors.grey[300],
      //       borderRadius: BorderRadius.circular(10)
      //   ),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       DefaultFormField(
      //         controller: taskController,
      //         keyboardType: TextInputType.text,
      //         hintText: "Add Your Task",
      //       ),
      //     const  SizedBox(height: 10,),
      //       DefaultFormField(
      //         controller: timeController,
      //         keyboardType: TextInputType.text,
      //         hintText: "Time",
      //          suffixIcon: const Icon(Icons.alarm),
      //       ),
      //       const  SizedBox(height: 10,),
      //       DefaultFormField(
      //         controller: dateController,
      //         keyboardType: TextInputType.text,
      //         hintText: "Date",
      //         suffixIcon: const Icon(Icons.calendar_month),
      //       ),
      //     ],
      //   ),
      // ),
      body: screens[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const  CircleBorder(),
        backgroundColor: Colors.teal,
        onPressed: () {
          setState(() {
            if(isBottomSheet){
           if(formKey.currentState!.validate()){
             insertDatabase(task: taskController.text ,
                 time:  timeController.text,
                 date: dateController.text);
             Navigator.pop(context);
           }}else {
              changeBottomSheet(icon:Icons.done  , isShow: true);
            scaffoldKey.currentState!.showBottomSheet((context) =>
                Container(
              padding: const EdgeInsets.all(16),
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "please enter valid task";
                        }
                        return null;
                      },
                      controller: taskController,
                      keyboardType: TextInputType.text,
                      hintText: "Add Your Task",
                    ),
                    const  SizedBox(height: 10,),
                    DefaultFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "please enter valid time";
                        }
                        return null;
                      },
                      controller: timeController,
                      keyboardType: TextInputType.text,
                      hintText: "Time",
                      suffixIcon: const Icon(Icons.alarm),
                      onTap: (){
                        showTimePicker(context: context,
                            initialTime: TimeOfDay.now(),
                        ).then(
                                (value) {
                                  timeController.text =
                                      value!.format(context);
                                });
                      },
                    ),
                    const  SizedBox(height: 10,),
                    DefaultFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "please enter valid date";
                        }
                        return null;
                      },
                      controller: dateController,
                      keyboardType: TextInputType.text,
                      hintText: "Date",
                      suffixIcon: const Icon(Icons.calendar_month),
                      onTap: (){
                        showDatePicker(context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025,2,4),
                        ).then((value) {
                          if (value != null) {
                            dateController.text =
                                DateFormat.yMMMd().format(value);
                          }
                        });},
                    ),
                  ],
                ),
              ),
            ),).closed.then((value) {
              changeBottomSheet(icon: iconData, isShow: false);
            });

            // taskController.clear();
            // timeController.clear();
            // dateController.clear();

          }});
        }, //action
        child:  Icon(iconData , color: Colors.white,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[100],
        currentIndex: currentIndex,
        onTap: (index){
        setState(() {
          currentIndex = index;
        });
        },
        items:  [
          BottomNavigationBarItem(icon:const  Icon(Icons.task), label: titles[0]),
          // BottomNavigationBarItem(icon:const Icon(Icons.done), label: titles[1]),
          BottomNavigationBarItem(icon: const Icon(Icons.delete), label: titles[1])
        ],

      ) ,
    );
  }
}
