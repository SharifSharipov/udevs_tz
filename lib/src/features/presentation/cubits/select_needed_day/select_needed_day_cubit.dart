import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_needed_day_state.dart';

class SelectNeededDayCubit extends Cubit<SelectNeededDayState> {
  SelectNeededDayCubit()
      : super(
          SelectNeededDayState(
            dateTime: DateTime.now(),
          ),
        );

  void selectDate(DateTime dateTime) {
    emit(
      state.copyWith(dateTime: dateTime),
    );
  }
}
