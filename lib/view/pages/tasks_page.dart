import 'package:flutter/cupertino.dart';
import '../../local_data.dart';
import 'item_builder.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.separated(
          separatorBuilder: (context, index)=>
              const SizedBox(height: 10,),
          itemCount: itemTasks.length,
          itemBuilder:(context, index) {
             return ItemBuilder(itemTask: itemTasks[index],);
          }
      ),
    );
  }
}
