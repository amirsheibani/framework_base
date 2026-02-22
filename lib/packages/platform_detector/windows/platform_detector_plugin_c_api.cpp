#include "include/platform_detector/platform_detector_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "platform_detector_plugin.h"

void PlatformDetectorPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  platform_detector::PlatformDetectorPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
