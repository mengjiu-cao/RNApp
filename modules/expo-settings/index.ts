// Reexport the native module. On web, it will be resolved to ExpoSettingsModule.web.ts
// and on native platforms to ExpoSettingsModule.ts
export { default } from './src/ExpoSettingsModule';
export { default as ExpoSettingsView } from './src/ExpoSettingsView';
export * from  './src/ExpoSettings.types';
