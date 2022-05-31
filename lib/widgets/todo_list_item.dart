import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/todo.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.todo,
    required this.onDelete,
  }) : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  void delet_todo(BuildContext context) {
    onDelete(todo);
    print('delet_todo');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color.fromARGB(255, 181, 201, 228),
          ),
          padding: const EdgeInsets.all(8),
          // margin: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MM/yyyy - hh:mm a').format(todo.dateTime),
                // todo.dateTime.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600, //negrito
                ),
              ),
            ],
          ),
        ),

        endActionPane: ActionPane(
          extentRatio: 0.22,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: delet_todo,
              // onPressed: (BuildContext context) {
              //   onDelete(todo);
              // },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            // SlidableAction(
            //   onPressed: (BuildContext context) {
            //     onDelete(todo);
            //   },
            //   backgroundColor: Color(0xFF21B7CA),
            //   foregroundColor: Colors.white,
            //   icon: Icons.share,
            //   label: 'Share',
            // ),
          ],
        ),
      ),
    );
  }
}


// ListTile(
//                         subtitle: Text(
//                           todo,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold, //negrito
//                           ),
//                         ),
//                         title: const Text(
//                           '01/01/2022',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                             // fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         leading: Icon(Icons.save),
//                         onTap: () {
//                           print('Tarefa: $todo');
//                         },
//                         onLongPress: () {
//                           print('ação 02');
//                         },
//                       ),