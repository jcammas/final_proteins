#include "include/proteins/proteins_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "proteins_plugin.h"

void ProteinsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  proteins::ProteinsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
