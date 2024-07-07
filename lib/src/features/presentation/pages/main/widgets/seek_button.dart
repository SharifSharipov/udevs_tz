import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../../core/colors/colors.dart';

class SeekButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  const SeekButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: SizedBox(
        height: 23.0,
        width: 23.0,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.C_EFEFEF,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.none,
          ),
        ),
      ),
    );
  }
}
