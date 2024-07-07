

import 'package:udevs_tz/src/features/data/data_source/local/database.dart';
import 'package:udevs_tz/src/features/data/models/todo/todo_model.dart';

class EventRepository {
  final LocalDataBase _localDataBase;
  const EventRepository(this._localDataBase);

  Future<List<TodoModel>> getTodosByDate(String selectedDate) async =>
      await _localDataBase.getTodosByDate(selectedDate);

  Future<List<TodoModel>> getTodos() async => await _localDataBase.getTodos();

  Future<int> deleteTodoById(int id) async =>
      await _localDataBase.deleteById(id);

  Future<int> insertTodo(TodoModel todo) async =>
      await _localDataBase.insertTodo(todo);

  Future<int> editTodo({required TodoModel todo, required int id}) async =>
      await _localDataBase.edit(
        todoModel: todo,
        id: id,
      );
}
