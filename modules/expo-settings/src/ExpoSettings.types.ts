export type FiatType = 'USD' | 'HKD';

export type ChangeEventPayload = {
  value: FiatType;
};

export type ExpoSettingsModuleEvents = {
  onChange: (params: ChangeEventPayload) => void;
};

