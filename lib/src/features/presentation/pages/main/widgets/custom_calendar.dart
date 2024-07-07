import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_calendar_picker.dart';

class CustomCalendar extends StatefulWidget {
  CustomCalendar({
    super.key,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.selectableDayPredicate,
    this.cancelText,
    this.confirmText,
    this.helpText,
    this.initialCalendarMode = DatePickerMode.day,
    this.errorFormatText,
    this.errorInvalidText,
    this.fieldHintText,
    this.fieldLabelText,
    this.keyboardType,
    this.restorationId,
    this.onDatePickerModeChange,
    this.switchToInputEntryModeIcon,
    this.switchToCalendarEntryModeIcon,
    required this.savedDates,
  })  : initialDate = DateUtils.dateOnly(initialDate),
        firstDate = DateUtils.dateOnly(firstDate),
        lastDate = DateUtils.dateOnly(lastDate),
        currentDate = DateUtils.dateOnly(currentDate ?? DateTime.now()) {
    assert(
      !this.lastDate.isBefore(this.firstDate),
      'lastDate ${this.lastDate} must be on or after firstDate ${this.firstDate}.',
    );
    assert(
      !this.initialDate.isBefore(this.firstDate),
      'initialDate ${this.initialDate} must be on or after firstDate ${this.firstDate}.',
    );
    assert(
      !this.initialDate.isAfter(this.lastDate),
      'initialDate ${this.initialDate} must be on or before lastDate ${this.lastDate}.',
    );
    assert(
      selectableDayPredicate == null ||
          selectableDayPredicate!(this.initialDate),
      'Provided initialDate ${this.initialDate} must satisfy provided selectableDayPredicate',
    );
  }
  final List<String> savedDates;

  final DateTime initialDate;

  final DateTime firstDate;

  final DateTime lastDate;

  final DateTime currentDate;

  final DatePickerEntryMode initialEntryMode;

  final SelectableDayPredicate? selectableDayPredicate;

  final String? cancelText;

  final String? confirmText;

  final String? helpText;

  final DatePickerMode initialCalendarMode;

  final String? errorFormatText;

  final String? errorInvalidText;

  final String? fieldHintText;

  final String? fieldLabelText;

  final TextInputType? keyboardType;

  final String? restorationId;

  final ValueChanged<DatePickerEntryMode>? onDatePickerModeChange;

  final Icon? switchToInputEntryModeIcon;

  final Icon? switchToCalendarEntryModeIcon;

  @override
  State<CustomCalendar> createState() => _DatePickerDialogState();
}

class _RestorableAutovalidateMode extends RestorableValue<AutovalidateMode> {
  _RestorableAutovalidateMode(
    AutovalidateMode defaultValue,
  ) : _defaultValue = defaultValue;

  final AutovalidateMode _defaultValue;

  @override
  AutovalidateMode createDefaultValue() => _defaultValue;

  @override
  void didUpdateValue(AutovalidateMode? oldValue) {
    assert(debugIsSerializableForRestoration(value.index));
    notifyListeners();
  }

  @override
  AutovalidateMode fromPrimitives(Object? data) =>
      AutovalidateMode.values[data! as int];

  @override
  Object? toPrimitives() => value.index;
}

class _RestorableDatePickerEntryMode
    extends RestorableValue<DatePickerEntryMode> {
  _RestorableDatePickerEntryMode(
    DatePickerEntryMode defaultValue,
  ) : _defaultValue = defaultValue;

  final DatePickerEntryMode _defaultValue;

  @override
  DatePickerEntryMode createDefaultValue() => _defaultValue;

  @override
  void didUpdateValue(DatePickerEntryMode? oldValue) {
    assert(debugIsSerializableForRestoration(value.index));
    notifyListeners();
  }

  @override
  DatePickerEntryMode fromPrimitives(Object? data) =>
      DatePickerEntryMode.values[data! as int];

  @override
  Object? toPrimitives() => value.index;
}

class _DatePickerDialogState extends State<CustomCalendar>
    with RestorationMixin {
  late final RestorableDateTime _selectedDate =
      RestorableDateTime(widget.initialDate);

  final _RestorableAutovalidateMode _autovalidateMode =
      _RestorableAutovalidateMode(AutovalidateMode.disabled);

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_autovalidateMode, 'autovalidateMode');
  }

  final GlobalKey _calendarPickerKey = GlobalKey();

  void _handleDateChanged(DateTime date) {
    setState(() {
      _selectedDate.value = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomCalendarDatePicker calendarDatePicker() {
      return CustomCalendarDatePicker(
        key: _calendarPickerKey,
        initialDate: _selectedDate.value,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        currentDate: widget.currentDate,
        onDateChanged: _handleDateChanged,
        selectableDayPredicate: widget.selectableDayPredicate,
        savedDates: widget.savedDates,
      );
    }

    final Widget picker;

    picker = calendarDatePicker();

    return SizedBox(
      height: 360,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[picker],
      ),
    );
  }
}
