import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class NoData extends StatelessWidget {
  final String? text;
  final bool isCompact;
  const NoData({super.key, this.text, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isCompact ? 40.verticalSpace : 80.verticalSpace,
        Image.asset(
          Constants.noData,
          height: isCompact ? 150 : null,
        ),
        isCompact ? 12.verticalSpace : 20.verticalSpace,
        Text(
          text ?? 'No Data',
          style: isCompact
              ? context.textTheme.bodyLarge
              : context.textTheme.displayMedium,
        ),
      ],
    );
  }
}
