import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:udevs_tz/src/core/colors/colors.dart';
import 'package:udevs_tz/src/core/constants/constants.dart';
import 'package:udevs_tz/src/core/extentions/space.dart';
import 'package:udevs_tz/src/core/extentions/text_styles.dart';
import 'package:udevs_tz/src/core/helper/helper.dart';
import 'package:udevs_tz/src/core/icons/icons.dart';
import 'package:udevs_tz/src/features/data/repository/event_repository.dart';
import 'package:udevs_tz/src/features/presentation/blocs/get_events/get_events_bloc.dart';
import 'package:udevs_tz/src/features/presentation/pages/locator.dart';
import '../../../../../data/models/todo/todo_model_key.dart';
import '../../../../blocs/events_for_calendar/event_for_calendar_bloc.dart';
import '../../../../blocs/get_location/get_location_bloc.dart';
import '../../../../cubits/event_data/event_data_cubit.dart';
import '../../../../cubits/select_needed_day/select_needed_day_cubit.dart';
import 'widgets/event_field_with_title.dart';

class AddEventPage extends StatelessWidget {
  const AddEventPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventDataCubit(),
        ),
        BlocProvider(
          create: (context) => GetLocationBloc(locator()),
        ),
      ],
      child: AddEventView(
        eventRepository: locator(),
      ),
    );
  }
}

class AddEventView extends StatefulWidget {
  const AddEventView({
    super.key,
    required this.eventRepository,
  });
  final EventRepository eventRepository;

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  late TextEditingController _eventNameController;
  late TextEditingController _eventDescController;
  late TextEditingController _eventLocationController;
  late TextEditingController _eventTimeController;
  late EventDataCubit dataCubit;
  late GetLocationBloc locationBloc;
  late SelectNeededDayCubit selectNeededDayCubit;

  @override
  void initState() {
    _eventDescController = TextEditingController();
    _eventLocationController = TextEditingController();
    _eventNameController = TextEditingController();
    _eventTimeController = TextEditingController();
    dataCubit = BlocProvider.of<EventDataCubit>(context);
    locationBloc = BlocProvider.of<GetLocationBloc>(context);
    selectNeededDayCubit = BlocProvider.of<SelectNeededDayCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetLocationBloc, GetLocationState>(
      listener: (context, state) {
        if (state is GetLocationLoading) {
          //Show Dialog
          Helper.showDismissableDialog(context);
        } else if (state is GetLocationSuccess) {
          //Successfully fetched location
          Navigator.pop(context);
          writeLocationToCubitAndTextcontroller(state);
        } else if (state is GetLocationFailure) {
          //Show Error Message
          Navigator.pop(context);
          Helper.showErrorSnackbar(
            context: context,
            errorMessage: state.errorMessage,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.0,
        ),
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: BlocBuilder<EventDataCubit, EventDataState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.ph,
                        EventFieldWithTitle(
                          controller: _eventNameController,
                          title: 'Event name',
                          onChanged: (value) {
                            dataCubit.updateTodoData(
                                TodoModelKey.eventName, value);
                          },
                        ),
                        16.ph,
                        EventFieldWithTitle(
                          controller: _eventDescController,
                          title: 'Event description',
                          maxLine: 3,
                          onChanged: (value) {
                            dataCubit.updateTodoData(
                                TodoModelKey.eventDesc, value);
                          },
                        ),
                        16.ph,
                        EventFieldWithTitle(
                          readOnly: true,
                          onTap: getLocation,
                          controller: _eventLocationController,
                          title: 'Event location',
                          suffixIcon: AppIcons.location,
                        ),
                        16.ph,
                        DropdownButton(
                          value:
                              Helper.hexToColor(state.todoModel.priorityColor),
                          items: AppConstants.colors
                              .map(
                                (color) => DropdownMenuItem(
                                  value: color,
                                  child: ColoredBox(
                                    color: color,
                                    child: const SizedBox(
                                      height: 20.0,
                                      width: 20.0,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            dataCubit.updateTodoData(
                              TodoModelKey.priorityColor,
                              value.toString().substring(6, 16),
                            );
                          },
                        ),
                        16.ph,
                        EventFieldWithTitle(
                          readOnly: true,
                          onTap: getTime,
                          controller: _eventTimeController,
                          title: 'Event Time',
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: addEvent,
                          child: SizedBox(
                            height: 54.0,
                            width: double.infinity,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.C_009FEE,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Add',
                                  style: context.displayMedium?.copyWith(
                                    color: AppColors.C_FFFFFF,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        28.ph,
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void writeLocationToCubitAndTextcontroller(GetLocationSuccess state) {
    if (state.currentLocation.name.isNotEmpty) {
      _eventLocationController.text = state.currentLocation.name;
      dataCubit.updateTodoData(
        TodoModelKey.eventLocation,
        state.currentLocation.name,
      );
    } else {
      String splittedAdress =
          '${state.currentLocation.displayName.split(',')[2]},${state.currentLocation.displayName.split(',')[3]}';
      _eventLocationController.text = splittedAdress;
      dataCubit.updateTodoData(
        TodoModelKey.eventLocation,
        splittedAdress,
      );
    }
  }

//WRITE TIME TO CUBIT AND TEXTCONTROLLER
  void getTime() async {
    await getEventTime().then((selectedTime) {
      _eventTimeController.text = '${selectedTime.$1} - ${selectedTime.$2}';
      dataCubit.updateTodoData(
          TodoModelKey.eventTime, '${selectedTime.$1} - ${selectedTime.$2}');
    });
  }

  //GET LOCATION
  void getLocation() async {
    var geo = await _determinePosition();
    locationBloc.add(GetCurrentLocationEvent(
      lat: geo.latitude,
      lon: geo.longitude,
    ));
  }

//ADD EVENT
  void addEvent() async {
    List<String> eventDate = [selectNeededDayCubit.state.dateTime.toString()];
    dataCubit.updateTodoData(
      TodoModelKey.eventDate,
      eventDate.join(','),
    );
    var registerChecker = dataCubit.canAdd(dataCubit.state.todoModel);
    if (registerChecker.$1 == true) {
      BlocProvider.of<GetEventsBloc>(context).add(AddTodoEvent(
        todoModel: dataCubit.state.todoModel,
        selectedDate: selectNeededDayCubit.state.dateTime.toString(),
      ));
      BlocProvider.of<EventsForCalendarBloc>(context)
          .add(EventsForCalendarEvent());
      Navigator.pop(context);
    } else {
      Helper.showErrorSnackbar(
        context: context,
        errorMessage: registerChecker.$2,
      );
    }
  }

//GET EVENT TIME
  Future<(String, String)> getEventTime() async {
    TimeOfDay? startTime;
    TimeOfDay? endTime;
    Helper.showMessage('Please choose a start time');
    startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).whenComplete(() async {
      Helper.showMessage('Please choose a end time');
      endTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    });

    return (startTime!.format(context), endTime!.format(context));
  }

//GET LAT AND LON
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && mounted) {
      Helper.showErrorSnackbar(
          context: context, errorMessage: 'Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && mounted) {
        Helper.showErrorSnackbar(
            context: context, errorMessage: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever && mounted) {
      Helper.showErrorSnackbar(
          context: context,
          errorMessage:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void dispose() {
    _eventDescController.dispose();
    _eventTimeController.dispose();
    _eventLocationController.dispose();
    _eventNameController.dispose();
    super.dispose();
  }
}
