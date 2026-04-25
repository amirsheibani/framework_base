
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
import '../fields/checkbox/checkbox_field_renderer.dart';
import '../fields/date/date_field_renderer.dart';
import '../fields/datetime/datetime_field_renderer.dart';
import '../fields/dropdown/dropdown_field_renderer.dart';
import '../fields/email/email_field_renderer.dart';
import '../fields/file/file_field_renderer.dart';
import '../fields/number/number_field_renderer.dart';
import '../fields/phone/phone_field_renderer.dart';
import '../fields/radio/radio_field_renderer.dart';
import '../fields/text/text_field_renderer.dart';
import '../fields/time/time_field_renderer.dart';
import '../registry/field/field_registry.dart';
import '../core/validation/rule_type.dart';
import '../section/container/container_renderer.dart';
import '../section/padding/padding_renderer.dart';
import '../section/sizedbox/sizedbox_renderer.dart';



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

    FieldRegistry.register(FieldType.text, TextFieldRenderer());
    FieldRegistry.register(FieldType.number, NumberFieldRenderer());
    FieldRegistry.register(FieldType.dropdown, DropdownFieldRenderer());
    FieldRegistry.register(FieldType.checkbox, CheckboxFieldRenderer());
    FieldRegistry.register(FieldType.radio, RadioFieldRenderer());
    FieldRegistry.register(FieldType.date, DateFieldRenderer());
    FieldRegistry.register(FieldType.datetime, DateTimeFieldRenderer());
    FieldRegistry.register(FieldType.time, TimeFieldRenderer());
    FieldRegistry.register(FieldType.file, FileFieldRenderer());
    FieldRegistry.register(FieldType.email, EmailFieldRenderer());
    FieldRegistry.register(FieldType.phone, PhoneFieldRenderer());

    SectionRegistry.register(SectionType.sizedBox,(child) => SizedBoxSectionRenderer(child));
    SectionRegistry.register(SectionType.container,(child) => ContainerSectionRenderer(child));
    SectionRegistry.register(SectionType.padding,(child) => PaddingSectionRenderer(child));

  }
}



