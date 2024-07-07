import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:udevs_tz/src/core/extentions/space.dart';
import 'package:udevs_tz/src/core/extentions/text_styles.dart';
import 'package:udevs_tz/src/features/data/models/todo/todo_model.dart';
import 'package:udevs_tz/src/features/data/repository/event_repository.dart';
import '../../../../../../core/colors/colors.dart';
import '../../../../../../core/icons/icons.dart';
import '../../../../blocs/events_for_calendar/event_for_calendar_bloc.dart';
import '../../../../blocs/get_events/get_events_bloc.dart';
import '../../../../cubits/select_needed_day/select_needed_day_cubit.dart';
import 'widgets/large_appbar.dart';

class DetailEventPage extends StatelessWidget {
  const DetailEventPage({
    super.key,
    required this.todoModel,
    required this.eventRepository,
  });
  final TodoModel todoModel;
  final EventRepository eventRepository;

  @override
  Widget build(BuildContext context) {
    var neededDay = BlocProvider.of<SelectNeededDayCubit>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          LargeAppBar(
            todoModel: todoModel,
            eventRepository: eventRepository,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  28.ph,
                  Text(
                    'Reminder',
                    style: context.displayMedium,
                  ),
                  10.ph,
                  Text(
                    todoModel.eventTime,
                    style: context.displayMedium?.copyWith(
                      color: AppColors.C_7C7B7B,
                    ),
                  ),
                  22.ph,
                  Text(
                    'Description',
                    style: context.displayMedium,
                  ),
                  10.ph,
                  Text(
                    todoModel.eventDesc,
                    style: context.displaySmall?.copyWith(
                      color: AppColors.C_7C7B7B,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  10.ph,
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<GetEventsBloc>(context)
                        .add(RemoveTodoByIdEvent(
                      id: todoModel.id,
                      selectedDate: neededDay.state.dateTime.toString(),
                    ));
                    BlocProvider.of<EventsForCalendarBloc>(context)
                        .add(EventsForCalendarEvent());
                    Navigator.pop(context);
                  },
                  child:SizedBox(
                    height: 54.0,
                    child: Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 28.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.C_FEE8E9,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.trash,
                            ),
                            2.pw,
                            Text(
                              'Delete Event',
                              style: context.displayMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                28.ph,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
