import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:firebase_getx_auth_crud/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonCircleImageLayout extends StatelessWidget {
  final double? height, width, padding;
  final Color? color, bColor;
  final File? fileImage;
  final bool isImage, isCircle;
  final Widget? image;
  final String? networkImage;

  const CommonCircleImageLayout(
      {super.key,
      this.height,
      this.width,
      this.color,
      this.padding,
      this.bColor,
      this.isImage = false,
      this.isCircle = false,
      this.fileImage,
      this.image,
      this.networkImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        fileImage != null
            ? Container(
                height: height ?? 111,
                width: width ?? 111,
                decoration: isCircle
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(File(fileImage!.path)),
                            fit: BoxFit.cover),
                        border: bColor != null
                            ? Border.all(color: appTheme.borderColor, width: 3)
                            : null,
                        color: color ?? appTheme.primary.withValues(alpha: .10))
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: FileImage(File(fileImage!.path)),
                            fit: BoxFit.cover),
                        border: bColor != null
                            ? Border.all(color: appTheme.borderColor, width: 3)
                            : null,
                        color:
                            color ?? appTheme.primary.withValues(alpha: .10)),
              )
            : networkImage != "" && networkImage != null
                ? CachedNetworkImage(
                    imageUrl: networkImage!,
                    progressIndicatorBuilder:
                        (context, url, progress) =>
                            Container(
                                height: height ?? 111,
                                width: width ?? 111,
                                decoration:
                                    isCircle
                                        ? BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: bColor != null
                                                ? Border.all(
                                                    color: appTheme.borderColor,
                                                    width: 3)
                                                : null,
                                            color: color ??
                                                appTheme.primary
                                                    .withValues(alpha: .10))
                                        : BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: bColor != null
                                                ? Border.all(
                                                    color: appTheme.borderColor,
                                                    width: 3)
                                                : null,
                                            color:
                                                color ??
                                                    appTheme.primary.withValues(
                                                        alpha: .10)),
                                child: const CircularProgressIndicator()),
                    imageBuilder: (context, imageProvider) => Container(
                      height: height ?? 111,
                      width: width ?? 111,
                      decoration: isCircle
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                              border: bColor != null
                                  ? Border.all(
                                      color: appTheme.borderColor, width: 3)
                                  : null,
                              color: color ??
                                  appTheme.primary.withValues(alpha: .10))
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                              border: bColor != null
                                  ? Border.all(
                                      color: appTheme.borderColor, width: 3)
                                  : null,
                              color: color ??
                                  appTheme.primary.withValues(alpha: .10)),
                    ),
                  )
                : Container(
                    height: height ?? 111,
                    width: width ?? 111,
                    decoration: isCircle
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            border: bColor != null
                                ? Border.all(
                                    color: appTheme.borderColor, width: 3)
                                : null,
                            color: color ??
                                appTheme.primary.withValues(alpha: .10))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: bColor != null
                                ? Border.all(
                                    color: appTheme.borderColor, width: 3)
                                : null,
                            color: color ??
                                appTheme.primary.withValues(alpha: .10)),
                  ),
        if (fileImage == null && (networkImage == null || networkImage == ""))
          Container(
            height: 45,
            width: 45,
            padding: const EdgeInsets.all(11.1),
            decoration: BoxDecoration(
                border: bColor != null
                    ? Border.all(color: appTheme.borderColor, width: 3)
                    : null,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(5.55, 6.66),
                      color: appTheme.black.withValues(alpha: .08),
                      blurRadius: 19)
                ],
                color: color ?? appTheme.white,
                shape: BoxShape.circle),
            child: image ??
                SvgPicture.asset(
                  svgAssets.camera,
                  colorFilter:
                      ColorFilter.mode(appTheme.primary, BlendMode.srcIn),
                ),
          )
      ],
    );
  }
}
