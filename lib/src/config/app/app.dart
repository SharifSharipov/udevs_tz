import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udevs_tz/src/config/theme/theme.dart';
import '../../features/presentation/blocs/events_for_calendar/event_for_calendar_bloc.dart';
import '../../features/presentation/blocs/get_events/get_events_bloc.dart';
import '../../features/presentation/cubits/select_needed_day/select_needed_day_cubit.dart';
import '../../features/presentation/pages/locator.dart';
import '../routes/routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var neededDayCubit = BlocProvider.of<SelectNeededDayCubit>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => EventsForCalendarBloc(locator())
              ..add(EventsForCalendarEvent())),
        BlocProvider(
          create: (BuildContext context) => GetEventsBloc(locator())
            ..add(
              GetTodosEvent(neededDayCubit.state.dateTime.toString()),
            ),
        )
      ],
      child: MaterialApp(
        theme: AppTheme.lighTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
