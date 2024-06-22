import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo62/local_data.dart';
import 'package:todo62/view/widgets/default_text.dart';

import 'builder_update.dart';

class ItemBuilder extends StatefulWidget {
  Map itemTask;

  ItemBuilder({super.key, required this.itemTask});

  @override
  State<ItemBuilder> createState() => _ItemBuilderState();
}

class _ItemBuilderState extends State<ItemBuilder> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (dismiss){
         deleteDataBase(id: widget.itemTask['id']);
         Fluttertoast.showToast(
            msg: "Delete",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      },
      child: InkWell(
        onTap: (){
          Fluttertoast.showToast(
              msg: "When swap task deleted , on long press task updated,   ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        },
        onLongPress: (){
          showDialog(context: context,
              builder: (context)=>BuilderUpdate(taskModel:widget.itemTask ,)
          );
        },
        child: Container(
            height: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
            child:
                // ListTile(
                //   leading: DefaultText(text: itemTask['time'], fontSize: 12,),
                //   title: DefaultText(text: itemTask['task'],fontSize: 12,),
                //   subtitle: DefaultText(text: itemTask['date'],fontSize: 12,),
                //   trailing:
                //
                //         IconButton(onPressed: (){}, icon: Icon(Icons.update)),
                //
                //     ),
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DefaultText(
                  text: widget.itemTask['time'],
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultText(
                      text: widget.itemTask['task'],
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    DefaultText(
                      text: widget.itemTask['date'],
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                Visibility(
                  visible: widget.itemTask['status'] == 'Done',
                  replacement: IconButton(
                      onPressed: () {
                          updateStatus("Done", widget.itemTask['id']);
                      },
                      icon: const Icon(
                        Icons.update,
                        color: Colors.grey,
                      )),
                  child: IconButton(
                      onPressed: () {
                          updateStatus('NotDone', widget.itemTask['id']);
                      },
                      icon: const Icon(
                        Icons.update,
                        color: Colors.blue,
                      )),
                ),
                IconButton(onPressed: () {
                  deleteDataBase(id: widget.itemTask['id']);
                }, icon: Icon(Icons.delete)),
              ],
            )),
      ),
    );
  }
}
