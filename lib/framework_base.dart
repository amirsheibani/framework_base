/// Framework Base - یک نقطه ورود واحد برای تمام ماژول‌های فریمورک
///
/// Single entry point for all framework modules.
library framework_base;

export 'packages/framework_core/lib/core_framework.dart';
export 'packages/framework_utils/lib/utils_framework.dart';
export 'packages/framework_form/lib/form_framework.dart';
export 'packages/framework_service/lib/service_framework.dart';
export 'packages/framework_storage/lib/storage_framework.dart';
export 'packages/framework_mapper/lib/mapper_framework.dart';
export 'di/framework_base_micro.dart';
export 'di/framework_base_micro.module.dart';
export 'packages/framework_enterprise_form_engine/lib/form_enterprise_engine_framework.dart';

