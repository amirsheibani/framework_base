
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/registry/section/section_registry.dart';

import '../core/field_type.dart';
import '../core/form_section/section_type.dart';
import '../core/validation/rules/custom_rule.dart';
import '../core/validation/rules/email_rule.dart';
import '../core/validation/rules/max_length_rule.dart';
import '../core/validation/rules/max_value_rule.dart';
import '../core/validation/rules/min_length_rule.dart';
import '../core/validation/rules/min_value_rule.dart';
import '../core/validation/rules/pattern_rule.dart';
import '../core/validation/rules/phone_rule.dart';
import '../core/validation/rules/required_rule.dart';
import '../core/validation/validation_registry.dart';

import '../fields/app_text/app_text_renderer.dart';
import '../fields/app_text_form_field/app_text_field_renderer.dart';
import '../registry/field/field_registry.dart';
import '../core/validation/rule_type.dart';
import '../section/container/container_renderer.dart';
import '../section/column/column_renderer.dart';
import '../section/expanded/expanded_renderer.dart';
import '../section/field/field_section_renderer.dart';
import '../section/flexible/flexible_renderer.dart';
import '../section/padding/padding_renderer.dart';
import '../section/row/row_renderer.dart';
import '../section/sizedbox/sizedbox_renderer.dart';
import '../section/spacer/spacer_renderer.dart';



class FormEngine {
  static void initialize() {
    ValidationRegistry.register(RuleFieldType.required, (cfg) => RequiredRule(cfg));
    ValidationRegistry.register(RuleFieldType.minLength, (cfg) => MinLengthRule(cfg));
    ValidationRegistry.register(RuleFieldType.maxLength, (cfg) => MaxLengthRule(cfg));
    ValidationRegistry.register(RuleFieldType.minValue, (cfg) => MinValueRule(cfg));
    ValidationRegistry.register(RuleFieldType.maxValue, (cfg) => MaxValueRule(cfg));
    ValidationRegistry.register(RuleFieldType.pattern, (cfg) => PatternRule(cfg));
    ValidationRegistry.register(RuleFieldType.email, (cfg) => EmailRule(cfg));
    ValidationRegistry.register(RuleFieldType.phone, (cfg) => PhoneRule(cfg));
    ValidationRegistry.register(RuleFieldType.custom, (cfg) => CustomRule(cfg));

    FieldRegistry.register(FieldType.appTextFormField, AppTextFieldRenderer());
    FieldRegistry.register(FieldType.appText, AppTextRenderer());
    // FieldRegistry.register(FieldType.appButton, NumberFieldRenderer());
    // FieldRegistry.register(FieldType.appSwitch, DropdownFieldRenderer());
    // FieldRegistry.register(FieldType.appRadio, CheckboxFieldRenderer());
    // FieldRegistry.register(FieldType.appGap, RadioFieldRenderer());
    // FieldRegistry.register(FieldType.appAvatar, DateFieldRenderer());
    // FieldRegistry.register(FieldType.appText, DateTimeFieldRenderer());
    // FieldRegistry.register(FieldType.time, TimeFieldRenderer());
    // FieldRegistry.register(FieldType.file, FileFieldRenderer());
    // FieldRegistry.register(FieldType.email, EmailFieldRenderer());
    // FieldRegistry.register(FieldType.phone, PhoneFieldRenderer());

    SectionRegistry.register(SectionType.field,(child) => FieldSectionRenderer(child));
    SectionRegistry.register(SectionType.sizedBox,(child) => SizedBoxSectionRenderer(child));
    SectionRegistry.register(SectionType.container,(child) => ContainerSectionRenderer(child));
    SectionRegistry.register(SectionType.padding,(child) => PaddingSectionRenderer(child));
    SectionRegistry.register(SectionType.row,(child) => RowSectionRenderer(child));
    SectionRegistry.register(SectionType.column,(child) => ColumnSectionRenderer(child));
    SectionRegistry.register(SectionType.expanded,(child) => ExpandedSectionRenderer(child));
    SectionRegistry.register(SectionType.flexible,(child) => FlexibleSectionRenderer(child));
    SectionRegistry.register(SectionType.spacer,(child) => SpacerSectionRenderer(child));

  }
}
