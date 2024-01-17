import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  final void Function() onTap;

   CustomIconButton({

    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Material(
        // color: const Color(0xff00F0FF),
        color: color,
        child: InkWell(
          // onTap: () {},
          onTap: onTap,
          child: SizedBox(
            height: 33.h,
            width: 33.w,
            child: icon,
          ),
        ),
      ),
    );
  }
}
