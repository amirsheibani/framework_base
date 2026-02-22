#ifndef FLUTTER_PLUGIN_PLATFORM_DETECTOR_PLUGIN_H_
#define FLUTTER_PLUGIN_PLATFORM_DETECTOR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace platform_detector {

class PlatformDetectorPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  PlatformDetectorPlugin();

  virtual ~PlatformDetectorPlugin();

  // Disallow copy and assign.
  PlatformDetectorPlugin(const PlatformDetectorPlugin&) = delete;
  PlatformDetectorPlugin& operator=(const PlatformDetectorPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace platform_detector

#endif  // FLUTTER_PLUGIN_PLATFORM_DETECTOR_PLUGIN_H_
