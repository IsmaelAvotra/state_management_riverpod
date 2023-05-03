import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class Todo {
  final String id;
  final String title;
  final String description;
  final bool completed;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier()
      : super([
          const Todo(
            id: '1',
            title: 'Title 1',
            description: 'Description 1',
            completed: false,
          ),
          const Todo(
            id: '2',
            title: 'Title 2',
            description: 'Description 2',
            completed: false,
          ),
          const Todo(
            id: '3',
            title: 'Title 3',
            description: 'Description 3',
            completed: false,
          ),
        ]);

  void add(Todo todo) {
    state = [...state, todo];
  }

  void remove(String todoId) {
    state = state.where((t) => t.id != todoId).toList();
  }

  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(completed: !todo.completed)
        else
          todo
    ];
  }
}
