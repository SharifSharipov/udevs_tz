part of 'event_for_calendar_bloc.dart';

sealed class GetEventState extends Equatable {
  const GetEventState();

  @override
  List<Object> get props => [];
}

final class EventsForCalendarLoading extends GetEventState {
  const EventsForCalendarLoading();
}

final class EventsForCalendarSuccess extends GetEventState {
  final List<TodoModel> todoModel;
  const EventsForCalendarSuccess(this.todoModel);
  @override
  List<Object> get props => [todoModel];
}

final class EventsForCalendarFailure extends GetEventState {
  final String errorMessage;
  const EventsForCalendarFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
