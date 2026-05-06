import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ThemeType { light, dark, system }

enum TextStyleEnum {
  displayXLRegular,
  displayXLMedium,
  displayXLDemiBold,
  displayXLExtraBold,
  displayLRegular,
  displayLMedium,
  displayLDemiBold,
  displayLExtraBold,
  displayMRegular,
  displayMMedium,
  displayMDemiBold,
  displayMExtraBold,
  textXXLRegular,
  textXXLMedium,
  textXXLDemiBold,
  textXXLExtraBold,
  textXLRegular,
  textXLMedium,
  textXLDemiBold,
  textXLExtraBold,
  textLRegular,
  textLMedium,
  textLDemiBold,
  textLExtraBold,
  textMRegular,
  textMMedium,
  textMDemiBold,
  textMExtraBold,
  textSRegular,
  textSMedium,
  textSDemiBold,
  textSExtraBold,
  textXSRegular,
  textXSMedium,
  textXSDemiBold,
  textXSExtraBold,
  textXXSRegular,
  textXXSMedium,
  textXXSDemiBold,
  textXXSExtraBold,
}

extension OnTextStyleEnum on TextStyleEnum {
  TextStyle getStyle(BuildContext context, Color? color) {
    return switch (this) {
      TextStyleEnum.displayXLRegular => Theme.of(context).displayXLRegular.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.displayXLMedium => Theme.of(context).displayXLMedium.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.displayXLDemiBold => Theme.of(context).displayXLDemiBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.displayXLExtraBold => Theme.of(context).displayXLExtraBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.displayLRegular => Theme.of(context).displayLRegular.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.displayLMedium => Theme.of(context).displayLMedium.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.displayLDemiBold => Theme.of(context).displayLDemiBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.displayLExtraBold => Theme.of(context).displayLExtraBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.displayMRegular => Theme.of(context).displayMRegular.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.displayMMedium => Theme.of(context).displayMMedium.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.displayMDemiBold => Theme.of(context).displayMDemiBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.displayMExtraBold => Theme.of(context).displayMExtraBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXXLRegular => Theme.of(context).textXXLRegular.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXXLMedium => Theme.of(context).textXXLMedium.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXXLDemiBold => Theme.of(context).textXXLDemiBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXXLExtraBold => Theme.of(context).textXXLExtraBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXLRegular => Theme.of(context).textXLRegular.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXLMedium => Theme.of(context).textXLMedium.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXLDemiBold => Theme.of(context).textXLDemiBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXLExtraBold => Theme.of(context).textXLExtraBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textLRegular => Theme.of(context).textLRegular.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textLMedium => Theme.of(context).textLMedium.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textLDemiBold => Theme.of(context).textLDemiBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textLExtraBold => Theme.of(context).textLExtraBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textMRegular => Theme.of(context).textMRegular.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textMMedium => Theme.of(context).textMMedium.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textMDemiBold => Theme.of(context).textMDemiBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textMExtraBold => Theme.of(context).textMExtraBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textSRegular => Theme.of(context).textSRegular.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textSMedium => Theme.of(context).textSMedium.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textSDemiBold => Theme.of(context).textSDemiBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textSExtraBold => Theme.of(context).textSExtraBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXSRegular => Theme.of(context).textXSRegular.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXSMedium => Theme.of(context).textXSMedium.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXSDemiBold => Theme.of(context).textXSDemiBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXSExtraBold => Theme.of(context).textXSExtraBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXXSRegular => Theme.of(context).textXXSRegular.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXXSMedium => Theme.of(context).textXXSMedium.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXXSDemiBold => Theme.of(context).textXXSDemiBold.copyWith(color: color ?? Theme.of(context).text.main),
      TextStyleEnum.textXXSExtraBold => Theme.of(context).textXXSExtraBold.copyWith(color: color ?? Theme.of(context).text.main),
    };
  }
}

class PalletColor extends MaterialColor {
  const PalletColor(super.primary, super.swatch);

  Color get active => this[34]!;

  Color get primarySubtle => this[33]!;

  Color get successSubtle => this[32]!;

  Color get infoSubtle => this[31]!;

  Color get warningSubtle => this[30]!;

  Color get destructiveSubtle => this[29]!;

  Color get accentSubtle => this[28]!;

  Color get secondaryForeground => this[27]!;

  Color get foreground => this[26]!;

  Color get soft => this[25]!;

  Color get sub => this[24]!;

  Color get warning => this[23]!;

  Color get warningMedium => this[22]!;

  Color get warningLow => this[21]!;

  Color get destructive => this[20]!;

  Color get destructiveMedium => this[19]!;

  Color get destructiveLow => this[18]!;

  Color get info => this[17]!;

  Color get infoMedium => this[16]!;

  Color get infoLow => this[15]!;

  Color get success => this[14]!;

  Color get successMedium => this[13]!;

  Color get successLow => this[12]!;

  Color get main => this[11]!;

  Color get base => this[10]!;

  Color get subtle => this[9]!;

  Color get raised => this[8]!;

  Color get sunken => this[7]!;

  Color get emphasis => this[6]!;

  Color get inverse => this[5]!;

  Color get primaryLow => this[4]!;

  Color get primaryMedium => this[3]!;

  Color get primary => this[2]!;

  Color get secondary => this[1]!;

  Color get accent => this[0]!;
}

extension OnAppTheme on ThemeData {
  PalletColor get backgroundSurface => brightness == Brightness.light
      ? const PalletColor(0xFFFFFFFF, <int, Color>{
          11: Colors.white,
          10: Color(0xFFF9FAFB),
          9: Color(0xFFF3F4F6),
          8: Color(0xFFE5E7EB),
          7: Color(0xFFD1D5DC),
          6: Color(0xFF6A7282),
          5: Color(0xFF262626),
          4: Color(0xFFFFF7ED),
          3: Color(0xFFFFD6A8),
          2: Color(0xFFF54900),
          1: Color(0xFFD1D5DC),
          0: Color(0xFF2B7FFF),
        })
      : const PalletColor(0xFF000000, <int, Color>{
          11: Color(0xFF0A0A0A),
          10: Color(0xFF171717),
          9: Color(0xFF262626),
          8: Color(0xFF404040),
          7: Color(0xFF525252),
          6: Color(0xFFA1A1A1),
          5: Color(0xFFFFFFFF),
          4: Color(0xFF441306),
          3: Color(0xFF9F2D00),
          2: Color(0xFFFF6900),
          1: Color(0xFF404040),
          0: Color(0xFF51A2FF),
        });

  PalletColor get backgroundFunc => brightness == Brightness.light
      ? const PalletColor(0xFFFFFFFF, <int, Color>{
          12: Color(0xFFECFDF5),
          13: Color(0xFFA4F4CF),
          14: Color(0xFF009966),
          15: Color(0xFFF0F9FF),
          16: Color(0xFFB8E6FE),
          17: Color(0xFF0084D1),
          18: Color(0xFFFEF2F2),
          19: Color(0xFFFFC9C9),
          20: Color(0xFFE7000B),
          21: Color(0xFFFEFCE8),
          22: Color(0xFFFFF085),
          23: Color(0xFFD08700),
        })
      : const PalletColor(0xFF000000, <int, Color>{
          12: Color(0xFF002C22),
          13: Color(0xFF006045),
          14: Color(0xFF00BC7D),
          15: Color(0xFF052F4A),
          16: Color(0xFF00598A),
          17: Color(0xFF00A6F4),
          18: Color(0xFF460809),
          19: Color(0xFF9F0712),
          20: Color(0xFFFB2C36),
          21: Color(0xFF432004),
          22: Color(0xFF894B00),
          23: Color(0xFFF0B100),
        });

  PalletColor get text => brightness == Brightness.light
      ? const PalletColor(0xFFFFFFFF, <int, Color>{
          11: Color(0xFF030712), //main
          9: Color(0xFF4A5565), //subtle
          24: Color(0xFF6A7282), //sub
          25: Color(0xFF99A1AF), //soft
          5: Color(0xFFFFFFFF), //inverse
          26: Color(0xFFFFFFFF), //foreground
          2: Color(0xFFF54900), //primary
          14: Color(0xFF009966), //success
          17: Color(0xFF0084D1), //info
          23: Color(0xFFD08700), //warning
          20: Color(0xFFE7000B), //destructive
          0: Color(0xFF2B7FFF), //accent
          27: Color(0xFF1E2939), //secondaryForeground
        })
      : const PalletColor(0xFF000000, <int, Color>{
          11: Color(0xFFFFFFFF), //main
          9: Color(0xFFA1A1A1), //subtle
          24: Color(0xFF737373), //sub
          25: Color(0xFF525252), //soft
          5: Color(0xFF262626), //inverse
          26: Color(0xFFFFFFFF), //foreground
          2: Color(0xFFFF6900), //primary
          14: Color(0xFF00BC7D), //success
          17: Color(0xFF00A6F4), //info
          23: Color(0xFFF0B100), //warning
          20: Color(0xFFFB2C36), //destructive
          0: Color(0xFF51A2FF), //accent
          27: Color(0xFFE5E5E5), //secondaryForeground
        });

  PalletColor get icon => brightness == Brightness.light
      ? const PalletColor(0xFFFFFFFF, <int, Color>{
          11: Color(0xFF030712), //main
          9: Color(0xFF4A5565), //subtle
          24: Color(0xFF6A7282), //sub
          25: Color(0xFF99A1AF), //soft
          5: Color(0xFFFFFFFF), //inverse
          26: Color(0xFFFFFFFF), //foreground
          2: Color(0xFFF54900), //primary
          14: Color(0xFF009966), //success
          17: Color(0xFF0084D1), //info
          23: Color(0xFFD08700), //warning
          20: Color(0xFFE7000B), //destructive
          0: Color(0xFF2B7FFF), //accent
          27: Color(0xFF1E2939), //secondaryForeground
        })
      : const PalletColor(0xFF000000, <int, Color>{
          11: Color(0xFFFFFFFF), //main
          9: Color(0xFFA1A1A1), //subtle
          24: Color(0xFF737373), //sub
          25: Color(0xFF525252), //soft
          5: Color(0xFF262626), //inverse
          26: Color(0xFFFFFFFF), //foreground
          2: Color(0xFFFF6900), //primary
          14: Color(0xFF00BC7D), //success
          17: Color(0xFF00A6F4), //info
          23: Color(0xFFF0B100), //warning
          20: Color(0xFFFB2C36), //destructive
          0: Color(0xFF51A2FF), //accent
          27: Color(0xFFE5E5E5), //secondaryForeground
        });

  PalletColor get border => brightness == Brightness.light
      ? const PalletColor(0xFFFFFFFF, <int, Color>{
          10: Color(0xFFE5E7EB), //base
          9: Color(0xFFD1D5DC), //subtle
          8: Color(0xFF99A1AF), //raised
          33: Color(0xFFFFB86A), //primary-subtle
          2: Color(0xFFF54900), //primary
          32: Color(0xFF5EE9B5), //success-subtle
          14: Color(0xFF009966), //success
          31: Color(0xFF74D4FF), //info-subtle
          17: Color(0xFF0084D1), //info
          30: Color(0xFFFFDF20), //warning-subtle
          23: Color(0xFFD08700), //warning
          29: Color(0xFFFFA2A2), //destructive-subtle
          20: Color(0xFFE7000B), //destructive
          28: Color(0xFF8EC5FF), //accent-subtle
          0: Color(0xFF2B7FFF), //accent
        })
      : const PalletColor(0xFF000000, <int, Color>{
          10: Color(0xFF262626), //base
          9: Color(0xFF404040), //subtle
          8: Color(0xFF525252), //raised
          33: Color(0xFFCA3500), //primary-subtle
          2: Color(0xFFFF6900), //primary
          32: Color(0xFF007A55), //success-subtle
          14: Color(0xFF00BC7D), //success
          31: Color(0xFF0069A8), //info-subtle
          17: Color(0xFF00A6F4), //info
          30: Color(0xFFA65F00), //warning-subtle
          23: Color(0xFFF0B100), //warning
          29: Color(0xFFC10007), //destructive-subtle
          20: Color(0xFFFB2C36), //destructive
          28: Color(0xFF1447E6), //accent-subtle
          0: Color(0xFF51A2FF), //accent
        });

  PalletColor get shadow => brightness == Brightness.light
      ? const PalletColor(0xFFFFFFFF, <int, Color>{
          34: Color(0x66F54900), //active
          25: Color(0x40E5E7EB), //soft
          //accent
        })
      : const PalletColor(0xFF000000, <int, Color>{
          34: Color(0x66F54900), //active
          25: Color(0x40E5E7EB), //soft
        });

  PalletColor get hover => const PalletColor(0x1A000000, <int, Color>{});

  PalletColor get press => const PalletColor(0x26000000, <int, Color>{});

  TextStyle get displayXLRegular => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 64.0, fontWeight: FontWeight.w400, height: 0.66, letterSpacing: 0);

  TextStyle get displayXLMedium => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 64.0, fontWeight: FontWeight.w500, height: 0.66, letterSpacing: 0);

  TextStyle get displayXLDemiBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 64.0, fontWeight: FontWeight.w600, height: 0.66, letterSpacing: 0);

  TextStyle get displayXLExtraBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 64.0, fontWeight: FontWeight.w800, height: 96, letterSpacing: 0);

  TextStyle get displayLRegular => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 48.0, fontWeight: FontWeight.w400, height: 0.75, letterSpacing: 0);

  TextStyle get displayLMedium => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 48.0, fontWeight: FontWeight.w500, height: 0.75, letterSpacing: 0);

  TextStyle get displayLDemiBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 48.0, fontWeight: FontWeight.w600, height: 0.75, letterSpacing: 0);

  TextStyle get displayLExtraBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 48.0, fontWeight: FontWeight.w800, height: 0.75, letterSpacing: 0);

  TextStyle get displayMRegular => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 40.0, fontWeight: FontWeight.w400, height: 0.62, letterSpacing: 0);

  TextStyle get displayMMedium => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 40.0, fontWeight: FontWeight.w500, height: 0.62, letterSpacing: 0);

  TextStyle get displayMDemiBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 40.0, fontWeight: FontWeight.w600, height: 0.62, letterSpacing: 0);

  TextStyle get displayMExtraBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 40.0, fontWeight: FontWeight.w800, height: 0.62, letterSpacing: 0);

  TextStyle get textXXLRegular => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 32.0, fontWeight: FontWeight.w400, height: 0.66, letterSpacing: 0);

  TextStyle get textXXLMedium => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 32.0, fontWeight: FontWeight.w500, height: 0.66, letterSpacing: 0);

  TextStyle get textXXLDemiBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 32.0, fontWeight: FontWeight.w600, height: 0.66, letterSpacing: 0);

  TextStyle get textXXLExtraBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 32.0, fontWeight: FontWeight.w800, height: 48, letterSpacing: 0);

  TextStyle get textXLRegular => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 24.0, fontWeight: FontWeight.w400, height: 1.33, letterSpacing: 0);

  TextStyle get textXLMedium => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 24.0, fontWeight: FontWeight.w500, height: 1.33, letterSpacing: 0);

  TextStyle get textXLDemiBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 24.0, fontWeight: FontWeight.w600, height: 1.33, letterSpacing: 0);

  TextStyle get textXLExtraBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 24.0, fontWeight: FontWeight.w800, height: 1.33, letterSpacing: 0);

  TextStyle get textLRegular => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 20.0, fontWeight: FontWeight.w400, height: 1.6, letterSpacing: 0);

  TextStyle get textLMedium => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 20.0, fontWeight: FontWeight.w500, height: 1.6, letterSpacing: 0);

  TextStyle get textLDemiBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 20.0, fontWeight: FontWeight.w600, height: 1.6, letterSpacing: 0);

  TextStyle get textLExtraBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 20.0, fontWeight: FontWeight.w800, height: 1.6, letterSpacing: 0);

  TextStyle get textMRegular => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 16.0, fontWeight: FontWeight.w400, height: 1.5, letterSpacing: 0);

  TextStyle get textMMedium => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 16.0, fontWeight: FontWeight.w500, height: 1.5, letterSpacing: 0);

  TextStyle get textMDemiBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 16.0, fontWeight: FontWeight.w600, height: 1.5, letterSpacing: 0);

  TextStyle get textMExtraBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 16.0, fontWeight: FontWeight.w800, height: 1.5, letterSpacing: 0);

  TextStyle get textSRegular => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 14.0, fontWeight: FontWeight.w400, height: 1.42, letterSpacing: 0);

  TextStyle get textSMedium => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.42, letterSpacing: 0);

  TextStyle get textSDemiBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 14.0, fontWeight: FontWeight.w600, height: 1.42, letterSpacing: 0);

  TextStyle get textSExtraBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 14.0, fontWeight: FontWeight.w800, height: 1.42, letterSpacing: 0);

  TextStyle get textXSRegular => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 12.0, fontWeight: FontWeight.w400, height: 1.3, letterSpacing: 0);

  TextStyle get textXSMedium => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 12.0, fontWeight: FontWeight.w500, height: 1.3, letterSpacing: 0);

  TextStyle get textXSDemiBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 12.0, fontWeight: FontWeight.w600, height: 1.3, letterSpacing: 0);

  TextStyle get textXSExtraBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 12.0, fontWeight: FontWeight.w800, height: 1.3, letterSpacing: 0);

  TextStyle get textXXSRegular => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 10.0, fontWeight: FontWeight.w400, height: 1.6, letterSpacing: 0);

  TextStyle get textXXSMedium => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 10.0, fontWeight: FontWeight.w500, height: 1.6, letterSpacing: 0);

  TextStyle get textXXSDemiBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 10.0, fontWeight: FontWeight.w600, height: 1.6, letterSpacing: 0);

  TextStyle get textXXSExtraBold => textTheme.labelMedium!.copyWith(fontFamily: 'IRANSansXFaNum', color: text.main, fontSize: 10.0, fontWeight: FontWeight.w800, height: 1.6, letterSpacing: 0);
}
