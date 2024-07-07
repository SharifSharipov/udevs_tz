import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:udevs_tz/src/core/constants/constants.dart';
import 'package:udevs_tz/src/core/extentions/space.dart';
import 'package:udevs_tz/src/core/extentions/text_styles.dart';
import 'package:udevs_tz/src/features/data/models/todo/todo_model.dart';
import '../../../../../../../core/colors/colors.dart';
import '../../../../../../../core/icons/icons.dart';
import '../../../../../../data/repository/event_repository.dart';
import '../../../../../../widgets/icon_with_text.dart';

class LargeAppBar extends StatelessWidget {
  const LargeAppBar({
    super.key,
    required this.eventRepository,
    required this.todoModel,
  });
  final TodoModel todoModel;
  final EventRepository eventRepository;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      elevation: 0.0,
      toolbarHeight: 230,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            color: AppColors.C_009FEE,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
        ),
        titlePadding: const EdgeInsets.only(bottom: 22.0),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.ph,
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: Material(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.pop(context),
                        icon: SvgPicture.asset(
                          AppIcons.arrowLeft,
                          fit: BoxFit.cover,
                          height: 15.0,
                          width: 15.0,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  IconWithText(
                    icon: AppIcons.edit,
                    text: 'Edit',
                    itemsColor: AppColors.C_FFFFFF,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppConstants.editEventPage,
                        arguments: todoModel,
                      );
                    },
                  )
                ],
              ),
              10.ph,
              Text(
                todoModel.eventName,
                style: context.displayMedium?.copyWith(
                  color: AppColors.C_FFFFFF,
                  fontSize: 26.0,
                ),
              ),
              Text(
                todoModel.eventDesc.length > 3
                    ? '${todoModel.eventDesc..substring(0, 3)}...'
                    : todoModel.eventDesc,
                style: context.displaySmall?.copyWith(
                  color: AppColors.C_FFFFFF,
                ),
              ),
              12.ph,
              IconWithText(
                icon: AppIcons.hour,
                text: todoModel.eventTime,
                itemsColor: AppColors.C_FFFFFF,
              ),
              12.ph,
              IconWithText(
                icon: AppIcons.location,
                text: todoModel.eventLocation,
                itemsColor: AppColors.C_FFFFFF,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
