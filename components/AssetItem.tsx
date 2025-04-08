import React, { FC } from 'react';
import { Image, XStack, YStack, Text, Stack } from 'tamagui';

const Icons = {
  BTC: require('@/assets/images/btc.png'),
  ETH: require('@/assets/images/eth.png'),


  CRO: require('@/assets/images/cronos_icon.png'),
  SOL: require('@/assets/images/sol.jpeg'),
  MATIC: require('@/assets/images/network_polygon.png'),
  ATOM: require('@/assets/images/ic_earn_atom.png'),
  DOGE:require('@/assets/images/doge.png'),
};
const AssetItem: FC<{
  icon: string;
  name: string;
  addRate: string;
  amount: string;
  fiatValue: string
}> = ({
  icon,
  name,
  addRate,
  amount,
  fiatValue,
}) => {

  return (
    <XStack marginHorizontal={12} alignItems={'center'} paddingHorizontal={10} height={48} borderRadius={12} backgroundColor={'#E7EDF2'}>
      <Image source={Icons[icon]} resizeMode={'contain'} width={26} height={26} borderRadius={13}  />
      <YStack marginLeft={6} gap={2}>
        <Text color={'#141A28'} fontSize={13}>{name}</Text>
        <Text color={'#DC5E6D'} fontSize={11}>{addRate}</Text>
      </YStack>
      <Stack flex={1} />
      <YStack alignItems={'flex-end'} gap={2}>
        <Text color={'#141A28'} fontSize={13}>{fiatValue}</Text>
        <Text color={'gray'} fontSize={11}>{amount}</Text>
      </YStack>
    </XStack>
  );
};

export default AssetItem;
