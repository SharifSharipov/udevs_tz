part of 'select_needed_day_cubit.dart';

class SelectNeededDayState extends Equatable {
  const SelectNeededDayState({
    required this.dateTime,
  });

  final DateTime dateTime;

  SelectNeededDayState copyWith({
    DateTime? dateTime,
  }) =>
      SelectNeededDayState(
        dateTime: dateTime ?? this.dateTime,
      );

  @override
  List<Object> get props => [
        dateTime,
      ];
}
