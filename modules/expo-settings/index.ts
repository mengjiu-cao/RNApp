// Reexport the native module. On web, it will be resolved to ExpoSettingsModule.web.ts
// and on native platforms to ExpoSettingsModule.ts

import { EventSubscription } from 'expo-modules-core';
import ExpoSettingsModule from './src/ExpoSettingsModule';
import { ChangeEventPayload, FiatType } from './src/ExpoSettings.types';

export * from  './src/ExpoSettings.types';

export function addDataListener(listener: (event: ChangeEventPayload) => void): EventSubscription {
  return ExpoSettingsModule.addListener('onChange', listener);
}

export function getFiat(): FiatType {
  return ExpoSettingsModule.getFiat();
}

export function toSettingPage(): void {
  return ExpoSettingsModule.toSettingPage();
}

