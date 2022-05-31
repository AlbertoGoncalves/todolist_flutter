import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  void validacaoOK(String text) {
    print('validacaoOK $text');
    // String text = todoController.text;
    setState(
      () {
        Todo newTodo = Todo(
          title: text,
          dateTime: DateTime.now(),
        );
        todos.add(newTodo);
        todoController.clear();
      },
    );
  }

  void add_list(String text) {
    print('add_list $text');
    setState(() {
      Todo newTodo = Todo(
        title: text,
        dateTime: DateTime.now(),
      );
      todos.add(newTodo);
      todoController.clear();
    });
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(
      () {
        todos.remove(todo);
      },
    );

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(
          'Tarefa: ${todo.title} foi removida',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white70,
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
          },
        ),
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
      print('deleteAllTodos');
    });
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar tudo?'),
        content: const Text('Tem certeza que deseja limpar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTodos();
            },
            style: TextButton.styleFrom(primary: Colors.red),
            child: const Text('Limpar Tudo'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                        labelText: 'Adicione uma Tarefa',
                        hintText: 'Ex. Estudar Flutter',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: validacaoOK,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      String text = todoController.text;
                      add_list(text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: const EdgeInsets.all(12),
                      //fixedSize: Size(50, 200),
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                  // SizedBox(width: 8),
                  // ElevatedButton(
                  //   onPressed: null,
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.blue,
                  //     //fixedSize: Size(50, 200),
                  //   ),
                  //   child: Icon(
                  //     Icons.add,
                  //   ),
                  // )
                ],
              ),
              const SizedBox(height: 12),
              Flexible(
                child: ListView(
                  shrinkWrap: true, //Minimo espaço necessario
                  children: [
                    for (Todo todo in todos)
                      TodoListItem(
                        todo: todo,
                        onDelete: onDelete,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Você possui ${todos.length} tarefas pendentes',
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: showDeleteTodosConfirmationDialog,
                    child: Text('Limpar Tudo'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      //fixedSize: Size(50, 200),
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
}



// class TodoListPage extends StatelessWidget {
//   TodoListPage({Key? key}) : super(key: key);

//   final TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   labelText: 'E-mail',
//                   hintText: 'exemplo@gmail.com',
//                   border: InputBorder.none,
//                 ),
//                 onChanged: validacaoDigitacao,
//                 onSubmitted: validacaoOK,
//               ),
//               ElevatedButton(
//                 onPressed: login,
//                 child: Text('Entrar'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void login() {
//     String text = emailController.text;
//     print(text);
//     emailController.clear();
//   }

//   void validacaoDigitacao(String text) {
//     print(text);
//   }

//   void validacaoOK(String text) {
//     print('validacaoOK $text');
//   }
// }

//Exemplos de formatação de Campos de texto
// class _MyHomePageState1 extends State<TodoListPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'E-mail',
//                 hintText: 'exemplo@gmail.com',
//                 labelStyle: TextStyle(
//                   fontSize: 35,
//                 ),
//                 border: OutlineInputBorder(),
//                 //border: InputBorder.none,
//                 //errorText: 'Campo Obrigatorio',
//               ),
//               // obscureText: true, //para Senhas
//               // obscuringCharacter: 'x',
//               keyboardType: TextInputType.emailAddress,
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 color: Colors.blue,
//               ),
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Senha',
//                 hintText: 'exemplo@gmail.com',
//                 border: OutlineInputBorder(),
//                 //border: InputBorder.none,
//                 //errorText: 'Campo Obrigatorio',
//               ),
//               obscureText: true, //para Senhas
//               obscuringCharacter: '*',
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   labelText: 'Valor',
//                   hintText: 'Campo valor',
//                   border: OutlineInputBorder(),
//                   //prefixText: 'R\$ '
//                   suffixText: 'R\$ '

//                   //border: InputBorder.none,
//                   //errorText: 'Campo Obrigatorio',
//                   ),
//               //obscureText: true, //para Senhas
//               //obscuringCharacter: '*',
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
