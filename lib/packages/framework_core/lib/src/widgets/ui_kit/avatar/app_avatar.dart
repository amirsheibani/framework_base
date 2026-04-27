import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:framework_base/framework_base.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

enum AppAvatarSize {
  extraLarge(64.0),
  large(48.0),
  medium(40.0),
  small(32.0),
  extraSmall(24.0);

  final double radius;

  const AppAvatarSize(this.radius);
}

// class AppAvatar extends StatelessWidget {
//   const AppAvatar({super.key, required this.size, this.data, this.avatarByte, this.headers, this.baseUrl}) : assert(!(baseUrl == null && headers != null), 'headers cannot be provided when baseUrl is null.');
//
//   final AppAvatarSize size;
//   final String? data;
//   final Uint8List? avatarByte;
//
//   final Map<String, String>? headers;
//   final Uri? baseUrl;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(() {
//         return switch (size) {
//           AppAvatarSize.extraLarge => 1.33,
//           AppAvatarSize.large => 1.0,
//           AppAvatarSize.medium => 1.0,
//           AppAvatarSize.small => 1.0,
//           AppAvatarSize.extraSmall => 1.0,
//         };
//       }()),
//       decoration: BoxDecoration(color: Theme.of(context).border.base, shape: BoxShape.circle),
//       child: CircleAvatar(
//         radius: size.radius / 2,
//         backgroundColor: Theme.of(context).backgroundSurface.base,
//         backgroundImage: (baseUrl != null)
//             ? NetworkImage(baseUrl.toString(), headers: headers,)
//             : avatarByte != null
//             ? MemoryImage(avatarByte!)
//             : null,
//         child: (baseUrl != null || avatarByte != null) ? null : (data != null)
//             ? Text(
//                       data!.characters.first,
//                       style: () {
//                         return switch (size) {
//                           AppAvatarSize.extraLarge => Theme.of(context).textXLRegular,
//                           AppAvatarSize.large => Theme.of(context).textLRegular,
//                           AppAvatarSize.medium => Theme.of(context).textMRegular,
//                           AppAvatarSize.small => Theme.of(context).textSRegular,
//                           AppAvatarSize.extraSmall => Theme.of(context).textXXSRegular,
//                         };
//                       }().copyWith(color: Theme.of(context).text.soft),
//                       textAlign: TextAlign.center,
//                     )
//                   : HugeIcon(
//                       icon: HugeIcons.strokeRoundedUser,
//                       size: () {
//                         return switch (size) {
//                           AppAvatarSize.extraLarge => 32.0,
//                           AppAvatarSize.large => 24.0,
//                           AppAvatarSize.medium => 20.0,
//                           AppAvatarSize.small => 16.0,
//                           AppAvatarSize.extraSmall => 12.0,
//                         };
//                       }(),
//                       color: Theme.of(context).icon.soft,
//                     )
//         ,
//       ),
//     );
//   }
// }


class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.size,
    this.data,
    this.avatarByte,
    this.headers,
    this.baseUrl,
  }) : assert(
  !(baseUrl == null && headers != null),
  'headers cannot be provided when baseUrl is null.',
  );

  final AppAvatarSize size;
  final String? data;
  final Uint8List? avatarByte;

  final Map<String, String>? headers;
  final Uri? baseUrl;

  @override
  Widget build(BuildContext context) {
    final double radius = size.radius / 2;

    Widget? content;

    /// ✅ اگر URL وجود دارد
    if (baseUrl != null) {
      content = ClipOval(
        child: Image.network(
          baseUrl.toString(),
          headers: headers,
          fit: BoxFit.cover,
          width: size.radius,
          height: size.radius,

          /// ✅ نمایش progress دانلود
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            return Center(
              child: SizedBox(
                width: radius * 0.6,
                height: radius * 0.6,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },

          /// ✅ اگر خطا داشت
          errorBuilder: (context, error, stackTrace) {
            return _buildFallback(context);
          },
        ),
      );
    }

    /// ✅ اگر تصویر بایتی وجود دارد
    else if (avatarByte != null) {
      content = ClipOval(
        child: Image.memory(
          avatarByte!,
          fit: BoxFit.cover,
          width: size.radius,
          height: size.radius,
        ),
      );
    }

    /// ✅ اگر هیچ تصویری نبود
    else {
      content = _buildFallback(context);
    }

    return Container(
      padding: EdgeInsets.all(_borderPadding()),
      decoration: BoxDecoration(
        color: Theme.of(context).border.base,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).backgroundSurface.base,
        child: content,
      ),
    );
  }

  double _borderPadding() {
    return switch (size) {
      AppAvatarSize.extraLarge => 1.33,
      _ => 1.0,
    };
  }

  Widget _buildFallback(BuildContext context) {
    if (data != null && data!.isNotEmpty) {
      return AppText(
        data!.characters.first,
        style: switch (size) {
          AppAvatarSize.extraLarge => Theme.of(context).textXLRegular,
          AppAvatarSize.large => Theme.of(context).textLRegular,
          AppAvatarSize.medium => Theme.of(context).textMRegular,
          AppAvatarSize.small => Theme.of(context).textSRegular,
          AppAvatarSize.extraSmall => Theme.of(context).textXXSRegular,
        }.copyWith(color: Theme.of(context).text.soft),
        textAlign: TextAlign.center,
      );
    }

    return HugeIcon(
      icon: HugeIcons.strokeRoundedUser,
      size: switch (size) {
        AppAvatarSize.extraLarge => 32.0,
        AppAvatarSize.large => 24.0,
        AppAvatarSize.medium => 20.0,
        AppAvatarSize.small => 16.0,
        AppAvatarSize.extraSmall => 12.0,
      },
      color: Theme.of(context).icon.soft,
    );
  }
}
