import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuto_riverpod8/models/data_model.dart';

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});
