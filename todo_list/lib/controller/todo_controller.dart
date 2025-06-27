import 'package:get/get.dart';
import '../model/todo.dart';

class ToDoController extends GetxController {
  var todos = <ToDo>[].obs;

  @override
  void onInit() {
    todos.addAll(ToDo.todoList());
    super.onInit();
  }

  void addToDo(String todoText) {
    if (todoText.trim().isEmpty) return;
    final newToDo = ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: todoText,
    );
    todos.add(newToDo);
  }

  void toggleDone(ToDo todo) {
    todo.isDone = !todo.isDone;
    todos.refresh(); // Notify UI
  }

  void deleteToDo(String id) {
    todos.removeWhere((todo) => todo.id == id);
  }

  void search(String keyword, List<ToDo> originalList) {
    if (keyword.isEmpty) {
      todos.assignAll(originalList);
    } else {
      final results = originalList
          .where(
            (todo) =>
                todo.todoText!.toLowerCase().contains(keyword.toLowerCase()),
          )
          .toList();
      todos.assignAll(results);
    }
  }
}
