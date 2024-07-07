import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:udevs_tz/src/core/extentions/space.dart';
import 'package:udevs_tz/src/core/extentions/text_styles.dart';
import 'package:udevs_tz/src/features/presentation/cubits/select_needed_day/select_needed_day_cubit.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../../core/icons/icons.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      actions: [
        const Spacer(
          flex: 2,
        ),
        BlocBuilder<SelectNeededDayCubit, SelectNeededDayState>(
          builder: (context, state) {
            return Column(
              children: [
                Text(
                  DateFormat('dd MMMM yyyy').format(state.dateTime),
                  style: context.displayMedium,
                ),
                Row(
                  children: [
                    Text(
                      DateFormat('EEEE').format(state.dateTime),
                      style: context.displaySmall?.copyWith(fontSize: 10.0),
                    ),
                    4.pw,
                    SvgPicture.asset(
                      AppIcons.arrowBottom,
                    )
                  ],
                ),
              ],
            );
          },
        ),
        const Spacer(),
        ZoomTapAnimation(
          onTap: () {},
          child: SvgPicture.asset(
            AppIcons.notification,
          ),
        ),
        28.pw,
      ],
    );
  }
}
