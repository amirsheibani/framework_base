import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

enum PasswordStrength { weak, medium, strong }

enum PasswordCriteria { hasMinLength, hasUppercase, hasNumber, hasSymbol }

class PasswordCheckResult {
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasNumber;
  final bool hasSymbol;
  final PasswordStrength strength;

  PasswordCheckResult({required this.hasMinLength, required this.hasUppercase, required this.hasNumber, required this.hasSymbol, required this.strength});
}

class PasswordHelper extends StatelessWidget {
  const PasswordHelper({
    super.key,
    required this.passwordValue,
    this.passwordCriteria = const {PasswordCriteria.hasMinLength: 'حداقل هشت کاراکتر', PasswordCriteria.hasUppercase: 'حداقل یک حرف بزرگ', PasswordCriteria.hasNumber: 'حداقل یک عدد', PasswordCriteria.hasSymbol: 'حداقل یک علامت'},
  });

  final String passwordValue;
  final Map<PasswordCriteria, String>? passwordCriteria;

  @override
  Widget build(BuildContext context) {
    final result = evaluatePassword(passwordValue);
    List<Color> stepperColor = [Theme.of(context).backgroundSurface.raised, Theme.of(context).backgroundSurface.raised, Theme.of(context).backgroundSurface.raised, Theme.of(context).backgroundSurface.raised];
    String scoreMessage = 'رمز عبور باید شامل موارد زیر باشد:';
    int score = -1;
    if(result.hasMinLength) score++;
    if(result.hasUppercase) score++;
    if(result.hasNumber) score++;
    if(result.hasSymbol) score++;

    if(score == 0) {
      stepperColor = [Theme.of(context).backgroundFunc.destructive, Theme.of(context).backgroundSurface.raised, Theme.of(context).backgroundSurface.raised, Theme.of(context).backgroundSurface.raised];
      scoreMessage = 'رمز عبور بسیار ضعیف است؛ رمز عبور باید شامل موارد زیر باشد:';
    } else if(score == 1) {
      stepperColor = [Theme.of(context).backgroundFunc.destructive, Theme.of(context).backgroundFunc.destructive, Theme.of(context).backgroundSurface.raised, Theme.of(context).backgroundSurface.raised];
      scoreMessage = 'ضعیف؛ رمز عبور باید شامل موارد زیر باشد:';
    } else if(score == 2) {
      stepperColor = [Theme.of(context).backgroundFunc.warning, Theme.of(context).backgroundFunc.warning, Theme.of(context).backgroundFunc.warning, Theme.of(context).backgroundSurface.raised];
      scoreMessage = 'متوسط؛ رمز عبور باید شامل موارد زیر باشد:';
    } else if(score >= 3) {
      stepperColor = [Theme.of(context).backgroundFunc.success, Theme.of(context).backgroundFunc.success, Theme.of(context).backgroundFunc.success, Theme.of(context).backgroundFunc.success];
      scoreMessage = 'قوی؛ رمز عبور شما امن است.';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSize.xsmall.gapHeight,
        Row(
          children: [
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(color: stepperColor[0], borderRadius: BorderRadius.circular(2)),
              ),
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(color: stepperColor[1], borderRadius: BorderRadius.circular(2)),
              ),
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(color: stepperColor[2], borderRadius: BorderRadius.circular(2)),
              ),
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(color: stepperColor[3], borderRadius: BorderRadius.circular(2)),
              ),
            ),
          ],
        ),
        AppSize.xsmall.gapHeight,
        AppText(scoreMessage, style: Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.subtle)),
        AppSize.xsmall.gapHeight,
        Row(
          children: [
            HugeIcon(icon: result.hasMinLength ? HugeIconsStrokeRounded.checkmarkCircle02 : HugeIconsStrokeRounded.cancelCircle , color: result.hasMinLength ? Theme.of(context).backgroundFunc.success : Theme.of(context).text.subtle,size: 16,),
            AppSize.xxsmall.gapWidth,
            AppText(passwordCriteria![PasswordCriteria.hasMinLength]!, style: Theme.of(context).textSRegular.copyWith(color: result.hasMinLength ? Theme.of(context).backgroundFunc.success : Theme.of(context).text.subtle)),
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          children: [
            HugeIcon(icon: result.hasUppercase ? HugeIconsStrokeRounded.checkmarkCircle02 : HugeIconsStrokeRounded.cancelCircle, color: result.hasUppercase ? Theme.of(context).backgroundFunc.success : Theme.of(context).text.subtle,size: 16,),
            AppSize.xxsmall.gapWidth,
            AppText(passwordCriteria![PasswordCriteria.hasUppercase]!, style: Theme.of(context).textSRegular.copyWith(color: result.hasUppercase ? Theme.of(context).backgroundFunc.success : Theme.of(context).text.subtle)),
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          children: [
            HugeIcon(icon: result.hasNumber ? HugeIconsStrokeRounded.checkmarkCircle02 : HugeIconsStrokeRounded.cancelCircle, color: result.hasNumber ? Theme.of(context).backgroundFunc.success : Theme.of(context).text.subtle,size: 16,),
            AppSize.xxsmall.gapWidth,
            AppText(passwordCriteria![PasswordCriteria.hasNumber]!, style: Theme.of(context).textSRegular.copyWith(color: result.hasNumber ? Theme.of(context).backgroundFunc.success : Theme.of(context).text.subtle)),
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          children: [
            HugeIcon(icon: result.hasSymbol ? HugeIconsStrokeRounded.checkmarkCircle02 : HugeIconsStrokeRounded.cancelCircle, color: result.hasSymbol ? Theme.of(context).backgroundFunc.success : Theme.of(context).text.subtle,size: 16,),
            AppSize.xxsmall.gapWidth,
            AppText(passwordCriteria![PasswordCriteria.hasSymbol]!, style: Theme.of(context).textSRegular.copyWith(color: result.hasSymbol ? Theme.of(context).backgroundFunc.success : Theme.of(context).text.subtle)),
          ],
        ),
      ],
    );
  }

  PasswordCheckResult evaluatePassword(String password) {
    final hasMinLength = password.length >= 8;
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSymbol = RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=/\\\[\]]').hasMatch(password);

    // تعداد شروطی که پسورد پاس کرده
    int score = 0;
    if (hasMinLength) score++;
    if (hasUppercase) score++;
    if (hasNumber) score++;
    if (hasSymbol) score++;

    PasswordStrength strength;

    if (score <= 2) {
      strength = PasswordStrength.weak;
    } else if (score == 3) {
      strength = PasswordStrength.medium;
    } else {
      strength = PasswordStrength.strong;
    }

    return PasswordCheckResult(hasMinLength: hasMinLength, hasUppercase: hasUppercase, hasNumber: hasNumber, hasSymbol: hasSymbol, strength: strength);
  }
}
