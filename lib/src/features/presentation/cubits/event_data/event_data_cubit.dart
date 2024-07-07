import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udevs_tz/src/features/data/models/todo/todo_model.dart';
import 'package:udevs_tz/src/features/data/models/todo/todo_model_key.dart';

import '../../../../core/colors/colors.dart';

part 'event_data_state.dart';

class EventDataCubit extends Cubit<EventDataState> {
  EventDataCubit()
      : super(
          EventDataState(
            todoModel: TodoModel(
              eventDesc: '',
              eventLocation: '',
              eventName: '',
              priorityColor: AppColors.C_008000.toString().substring(6, 16),
              eventTime: '',
              id: 0,
              eventDate: '',
            ),
            error: '',
          ),
        );

  void updateTodoData(TodoModelKey todoKey, dynamic value) {
    TodoModel currentTodoModel = state.todoModel;
    switch (todoKey) {
      case TodoModelKey.eventName:
        currentTodoModel = currentTodoModel.copyWith(eventName: value);
        break;
      case TodoModelKey.eventDesc:
        currentTodoModel = currentTodoModel.copyWith(eventDesc: value);
        break;
      case TodoModelKey.eventLocation:
        currentTodoModel = currentTodoModel.copyWith(eventLocation: value);
        break;
      case TodoModelKey.priorityColor:
        currentTodoModel = currentTodoModel.copyWith(priorityColor: value);
        break;
      case TodoModelKey.eventTime:
        currentTodoModel = currentTodoModel.copyWith(eventTime: value);
        break;
      case TodoModelKey.eventDate:
        currentTodoModel = currentTodoModel.copyWith(eventDate: value);
        break;
    }

    emit(state.copyWith(todoModel: currentTodoModel));
  }

  (bool, String) canAdd(TodoModel todoModel) {
    if (todoModel.eventName.isEmpty || todoModel.eventName.length < 3) {
      return (false, 'Event name length must be at least 3');
    }
    if (todoModel.eventDesc.isEmpty || todoModel.eventDesc.length < 3) {
      return (false, 'Event description length must be at least 3');
    }
    if (todoModel.eventLocation.isEmpty) {
      return (false, 'Event location must be empty');
    }
    if (todoModel.eventTime.isEmpty) {
      return (false, 'Event time should not be empyt');
    }
    return (true, '');
  }
}
