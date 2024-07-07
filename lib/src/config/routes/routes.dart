import 'package:flutter/cupertino.dart';
import 'package:udevs_tz/src/core/constants/constants.dart';
import 'package:udevs_tz/src/features/data/models/todo/todo_model.dart';
import 'package:udevs_tz/src/features/presentation/pages/locator.dart';
import 'package:udevs_tz/src/features/presentation/pages/main/main_page.dart';
import 'package:udevs_tz/src/features/presentation/pages/main/sub_pages/add_event/add_event_page.dart';
import 'package:udevs_tz/src/features/presentation/pages/main/sub_pages/detail_event/detail_event_page.dart';
import 'package:udevs_tz/src/features/presentation/pages/main/sub_pages/edit_event/edit_event_page.dart';

import '../../features/presentation/pages/error/error_page.dart';

class AppRoutes {
  static CupertinoPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.mainPage:
        return _toPage(const MainPage());
      case AppConstants.addEventPage:
        return _toPage(const AddEventPage());
      case AppConstants.editEventPage:
        return _toPage(EditEventPage(
          todoModel: settings.arguments as TodoModel,
        ));
      case AppConstants.detailEventPage:
        return _toPage(DetailEventPage(
          todoModel: settings.arguments as TodoModel,
          eventRepository: locator(),
        ));
      default:
        return _toPage(
          const ErrorPage(
            errorMessage: 'Something went wrong',
          ),
        );
    }
  }

  static CupertinoPageRoute _toPage(Widget page) {
    return CupertinoPageRoute(
      builder: (context) => page,
    );
  }
}
