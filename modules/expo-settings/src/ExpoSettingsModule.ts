import { NativeModule, requireNativeModule } from 'expo';

import { ExpoSettingsModuleEvents, FiatType } from './ExpoSettings.types';

declare class ExpoSettingsModule extends NativeModule<ExpoSettingsModuleEvents> {
  getFiat(): FiatType;
  setFiat(value: FiatType): void;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoSettingsModule>('ExpoSettings');
