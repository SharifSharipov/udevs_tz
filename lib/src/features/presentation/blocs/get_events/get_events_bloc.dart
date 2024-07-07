import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udevs_tz/src/features/data/models/todo/todo_model.dart';
import 'package:udevs_tz/src/features/data/repository/event_repository.dart';

part 'get_events_event.dart';
part 'get_events_state.dart';

class GetEventsBloc extends Bloc<GetEventsEvent, GetEventsState> {
  final EventRepository eventRepository;
  GetEventsBloc(this.eventRepository) : super(const GetEventsLoading()) {
    on<GetTodosEvent>(onGetTodosEvent);
    on<AddTodoEvent>(onAddTodoEvent);
    on<RemoveTodoByIdEvent>(onRemoveTodoByIdEvent);
    on<EditTodoById>(onEditTodoByIdEvent);
  }
  void onGetTodosEvent(
      GetTodosEvent event, Emitter<GetEventsState> emit) async {
    emit(const GetEventsLoading());
    try {
      List<TodoModel> todoByDateList =
          await eventRepository.getTodosByDate(event.selectedDate);
      List<TodoModel> todoList = await eventRepository.getTodos();
      emit(
        GetEventsSuccess(
          todosByDateModel: todoByDateList,
          todos: todoList,
        ),
      );
    } catch (e) {
      emit(
        GetEventsFailure(e.toString()),
      );
    }
  }

  void onAddTodoEvent(AddTodoEvent event, Emitter<GetEventsState> emit) async {
    emit(const GetEventsLoading());
    try {
      await eventRepository.insertTodo(event.todoModel);
      List<TodoModel> todoList = await eventRepository.getTodosByDate(
        event.selectedDate,
      );
      emit(
        GetEventsSuccess(
          todosByDateModel: todoList,
        ),
      );
    } catch (e) {
      emit(
        GetEventsFailure(e.toString()),
      );
    }
  }

  void onRemoveTodoByIdEvent(
      RemoveTodoByIdEvent event, Emitter<GetEventsState> emit) async {
    emit(const GetEventsLoading());
    try {
      await eventRepository.deleteTodoById(event.id);
      List<TodoModel> todoList =
          await eventRepository.getTodosByDate(event.selectedDate);
      emit(
        GetEventsSuccess(
          todosByDateModel: todoList,
        ),
      );
    } catch (e) {
      emit(
        GetEventsFailure(e.toString()),
      );
    }
  }

  void onEditTodoByIdEvent(
      EditTodoById event, Emitter<GetEventsState> emit) async {
    emit(const GetEventsLoading());
    try {
      await eventRepository.editTodo(todo: event.todoModel, id: event.id);

      List<TodoModel> todoList =
          await eventRepository.getTodosByDate(event.selectedDate);

      emit(
        GetEventsSuccess(
          todosByDateModel: todoList,
        ),
      );
    } catch (e) {
      emit(
        GetEventsFailure(e.toString()),
      );
    }
  }
}
