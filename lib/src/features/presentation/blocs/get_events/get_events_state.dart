part of 'get_events_bloc.dart';

sealed class GetEventsState extends Equatable {
  const GetEventsState();

  @override
  List<Object> get props => [];
}

final class GetEventsLoading extends GetEventsState {
  const GetEventsLoading();
  @override
  List<Object> get props => [];
}

final class GetEventsSuccess extends GetEventsState {
  const GetEventsSuccess({
    required this.todosByDateModel,
    this.todos,
  });
  final List<TodoModel> todosByDateModel;
  final List<TodoModel>? todos;

  @override
  List<Object> get props => [
        todosByDateModel,
        todos!,
      ];
}

final class GetEventsFailure extends GetEventsState {
  const GetEventsFailure(this.errorMessage);
  final String errorMessage;
  @override
  List<Object> get props => [
        errorMessage,
      ];
}
