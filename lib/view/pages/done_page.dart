import 'package:flutter/cupertino.dart';

import '../../local_data.dart';
import 'item_builder.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.separated(
          separatorBuilder: (context, index)=>
          const SizedBox(height: 10,),
          itemCount: tasksDone.length,
          itemBuilder:(context, index) {
            return ItemBuilder(itemTask: tasksDone[index],);
          }
      ),
    );
  }
}
