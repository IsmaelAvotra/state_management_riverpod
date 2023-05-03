import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/data_model.dart';
import '../providers/todos_provider.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // reconstruire le widget lorsque la liste des tâches change.
    List<Todo> todos = ref.watch(todosProvider);

    // Afficher (render) les todos dans une ListView.
    return ListView(
      children: [
        for (final todo in todos)
          CheckboxListTile(
            value: todo.completed,
            // En appuyant sur le todo, on modifie son état d'achèvement.
            onChanged: (value) =>
                ref.read(todosProvider.notifier).toggle(todo.id),
            title: Text(todo.title),
            subtitle: Text(todo.description),
            secondary: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => ref.read(todosProvider.notifier).remove(todo.id),
            ),
          ),
        ElevatedButton(
            onPressed: () {
              ref.read(todosProvider.notifier).add(const Todo(
                    id: '4',
                    title: 'Title 4',
                    description: 'Description 4',
                    completed: false,
                  ));
            },
            child: const Text('Add Todo')),
      ],
    );
  }
}
