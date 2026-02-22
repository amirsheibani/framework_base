//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <platform_detector/platform_detector_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) platform_detector_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PlatformDetectorPlugin");
  platform_detector_plugin_register_with_registrar(platform_detector_registrar);
}
