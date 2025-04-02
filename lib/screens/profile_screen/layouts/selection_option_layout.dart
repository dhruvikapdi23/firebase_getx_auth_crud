

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../config.dart';

class SelectOptionLayout extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTap;
  final List? list;
  final int? index;
  const SelectOptionLayout({super.key,this.onTap,this.data,this.list,this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(10),
                  decoration:  BoxDecoration(color: appTheme.primary, shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    data["image"],
                    colorFilter:  ColorFilter.mode(appTheme.white, BlendMode.srcIn),
                  ),
                ),
                 HSpace(15),
                Text(data["title"].toString().tr,style: Get.theme.textTheme.titleSmall!.copyWith(

                    letterSpacing: 1.2,
                    color: appTheme.black),)
              ]
          ),
          if( index != list!.length - 1)
             Divider(height: 1,color: appTheme.greyText.withValues(alpha: .50)).paddingSymmetric(vertical: 20)
        ]
    ).inkWell(onTap: onTap);
  }
}
