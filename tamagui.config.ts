import { createTamagui } from '@tamagui/core';

export const config = createTamagui({
  // act like CSS variables at your root
  tokens: {
    // width="$sm"
    size: { sm: 8, md: 12, lg: 20 },
    // margin="$-sm"
    space: { '-sm': 8 },
    // radius="$none"
    radius: { none: 0, sm: 3 },
    color: { white: '#fff', black: '#000' },
    zIndex: { base: 0, modal: 1000, overlay: 500 }, // Added zIndex property
  },

  themes: {
    light: {
      bg: '#f2f2f2',
      color: '#fff',
    },
    dark: {
      bg: '#111',
      color: '#000',
    },
  },

  shorthands: {
    // <View px={20} />
    px: 'paddingHorizontal',
  },
});

// in other files use this:
// get typescript types on @tamagui/core imports:
type AppConfig = typeof config
declare module '@tamagui/core' {
  interface TamaguiCustomConfig extends AppConfig {}
}
