part of 'event_data_cubit.dart';

class EventDataState extends Equatable {
  const EventDataState({
    required this.todoModel,
    required this.error,
  });
  final TodoModel todoModel;
  final String error;

  EventDataState copyWith({
    TodoModel? todoModel,
    String? error,
  }) =>
      EventDataState(
        todoModel: todoModel ?? this.todoModel,
        error: error ?? this.error,
      );

  @override
  List<Object> get props => [
        todoModel,
        error,
      ];
}
