part of 'get_events_bloc.dart';

sealed class GetEventsEvent extends Equatable {
  const GetEventsEvent();

  @override
  List<Object> get props => [];
}

final class GetTodosEvent extends GetEventsEvent {
  final String selectedDate;
  const GetTodosEvent(this.selectedDate);
  @override
  List<Object> get props => [
        selectedDate,
      ];
}

final class AddTodoEvent extends GetEventsEvent {
  const AddTodoEvent({
    required this.todoModel,
    required this.selectedDate,
  });
  final TodoModel todoModel;
  final String selectedDate;
  @override
  List<Object> get props => [
        todoModel,
        selectedDate,
      ];
}

final class RemoveTodoByIdEvent extends GetEventsEvent {
  const RemoveTodoByIdEvent({
    required this.id,
    required this.selectedDate,
  });
  final int id;
  final String selectedDate;
  @override
  List<Object> get props => [
        id,
        selectedDate,
      ];
}

final class EditTodoById extends GetEventsEvent {
  const EditTodoById({
    required this.id,
    required this.todoModel,
    required this.selectedDate,
  });

  final TodoModel todoModel;
  final int id;
  final String selectedDate;

  @override
  List<Object> get props => [
        id,
        todoModel,
        selectedDate,
      ];
}
