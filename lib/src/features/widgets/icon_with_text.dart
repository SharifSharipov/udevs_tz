import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:udevs_tz/src/core/extentions/space.dart';
import 'package:udevs_tz/src/core/extentions/text_styles.dart';


class IconWithText extends StatelessWidget {
  const IconWithText({
    super.key,
    required this.icon,
    required this.text,
    required this.itemsColor,
    this.onTap,
  });
  final String icon;
  final String text;
  final Color itemsColor;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              fit: BoxFit.none,
              color: itemsColor,
            ),
            4.pw,
            Expanded(
              child: Text(
                text,
                style: context.displaySmall?.copyWith(
                  color: itemsColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
