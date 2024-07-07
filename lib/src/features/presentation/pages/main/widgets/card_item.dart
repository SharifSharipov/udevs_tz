import 'package:flutter/material.dart';
import 'package:udevs_tz/src/core/extentions/space.dart';
import 'package:udevs_tz/src/core/extentions/text_styles.dart';
import 'package:udevs_tz/src/core/helper/helper.dart';
import 'package:udevs_tz/src/features/data/models/todo/todo_model.dart';
import 'package:udevs_tz/src/features/widgets/icon_with_text.dart';
import '../../../../../core/icons/icons.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.onTap,
    required this.todoModel,
  });

  final VoidCallback onTap;
  final TodoModel todoModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Helper.hexToColor(todoModel.priorityColor).withOpacity(.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      color: Helper.hexToColor(todoModel.priorityColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todoModel.eventName,
                        style: context.displayMedium?.copyWith(
                          color: Helper.hexToColor(todoModel.priorityColor),
                        ),
                      ),
                      Text(
                        todoModel.eventDesc,
                        style: context.displaySmall?.copyWith(
                          fontSize: 8.0,
                          color: Helper.hexToColor(todoModel.priorityColor),
                        ),
                      ),
                      10.ph,
                      Row(
                        children: [
                          IconWithText(
                            icon: AppIcons.hour,
                            text: todoModel.eventTime,
                            itemsColor: Helper.hexToColor(todoModel.priorityColor),
                          ),
                          IconWithText(
                            icon: AppIcons.location,
                            text: todoModel.eventLocation,
                            itemsColor: Helper.hexToColor(todoModel.priorityColor),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
