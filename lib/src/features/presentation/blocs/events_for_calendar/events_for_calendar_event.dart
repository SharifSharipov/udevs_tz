part of 'event_for_calendar_bloc.dart';

sealed class GetEventEvent extends Equatable {
  const GetEventEvent();

  @override
  List<Object> get props => [];
}

class EventsForCalendarEvent extends GetEventEvent {}
