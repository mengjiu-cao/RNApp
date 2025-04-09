/* eslint-disable react-native/no-inline-styles */
import React, { useCallback, useEffect, useMemo, useState } from 'react';
import { SceneMap, TabBar, TabView } from 'react-native-tab-view';
import { Image, Stack, Text, View, XStack, YStack, useWindowDimensions } from 'tamagui';
import { FlashList } from '@shopify/flash-list';
import { useMemoizedFn } from 'ahooks';
import { Currency } from '@/constants/Currency';
import { FiatRateUSD } from '@/constants/FiatRateUSD';
import { FiatRateHKD } from '@/constants/FiatRateHKD';
import AssetItem from '@/components/AssetItem';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import * as Settings from '@/modules/expo-settings';
import { FiatType } from '@/modules/expo-settings';
import { Platform, Pressable } from 'react-native';

export default function Crypto(): React.JSX.Element {
  const layout = useWindowDimensions();
  const [index, setIndex] = useState(0);
  const insets = useSafeAreaInsets();

  const [fiatType, setFiatType] = useState<FiatType>(Settings.getFiat());

  useEffect(() => {
    const subscription = Settings.addDataListener(({ value }) => {
      console.log('--------------value', value);
      setFiatType(value);
    });

    return () => subscription.remove();
  }, [setFiatType]);

  const list = useMemo(() => {
    console.log('--------------fiatType', fiatType);

    const res = Currency.map((item) => {
      const amount = typeof item.amount === 'bigint' ? Number(item.amount) : item.amount;
      const rate = fiatType === 'USD' ? FiatRateUSD.find(i => i.symbol === item.symbol)?.fiat_rate : FiatRateHKD.find(i => i.symbol === item.symbol)?.fiat_rate;
      return {
        icon: item.symbol,
        name: item.name.charAt(0).toUpperCase() + item.name.slice(1),
        addRate: '-3.24%',
        amount: `${item.amount} ${item.symbol}`,
        fiatValue: `${fiatType === 'USD' ? '$' : 'HK$'} ${amount * Number(rate)}`,
      };
    });
    console.log('res----', res)
    return res
  }, [fiatType]);

  const Gap = useMemoizedFn(() => <View height={6} />);
  const FirstRoute = () => (
    <YStack flex={1}>
      <XStack justifyContent={'space-between'} marginHorizontal={12} marginBottom={12}>
        <Text color={'#141A28'} fontSize={13}>Your Assets</Text>
        <XStack alignItems={'center'} space={2}>
          <Text marginLeft={6} fontSize={13} color={'#3898F9'}>Manage</Text>
          <Image source={require('@/assets/images/Tuning.png')} width={15} height={15} />
        </XStack>
      </XStack>
      <FlashList
        data={list}
        renderItem={(item) => <AssetItem {...item.item} />}
        ItemSeparatorComponent={Gap}
        estimatedItemSize={50}
        keyExtractor={(item) => item.name}
        showsVerticalScrollIndicator={false}
      />
    </YStack>
  );

  const SecondRoute = () => (
    <View backgroundColor={'green'} flex={1} />
  );

  const ThirdRoute = () => (
    <View backgroundColor={'purple'} flex={1} />
  );

  const renderScene = SceneMap({
    first: FirstRoute,
    second: SecondRoute,
    third: ThirdRoute,
  });

  const routes = useMemo(() => {
    return [
      { key: 'first', title: 'Crypto' },
      { key: 'second', title: 'Earn' },
      { key: 'third', title: 'NFTs' },
    ];
  }, []);

  const renderTabBar = useMemoizedFn((props: any) => (
    <TabBar
      {...props}
      indicatorStyle={{ height: 0 }}
      style={{ backgroundColor: 'transparent' }}
      activeColor={'#141A28'}
      inactiveColor={'#A0A6B4'}
    />
  ));

  return (
    <YStack flex={1} paddingTop={insets.top} paddingBottom={Platform.OS === 'ios' ? 80 : 0}>
      <XStack justifyContent={'space-between'} marginLeft={16} marginRight={10}>
        <XStack padding={2} height={32} alignItems={'center'} borderRadius={15} backgroundColor={'#E7EDF2'}>
          <Image source={require('@/assets/images/Image-header.png')} width={26} height={26} borderRadius={13} />
          <Text marginLeft={6} color={'black'}>Wallet 1</Text>
          <Image source={require('@/assets/images/icon_down_arrow.png')} width={14} height={14} marginRight={4} />
        </XStack>

        <XStack alignItems={'center'} gap={2}>
          <Image source={require('@/assets/images/Scanner@3x.svg.png')} width={22} height={22} margin={4} />
          <Image source={require('@/assets/images/clock_24@3x.svg.png')} width={22} height={22} margin={4} />
          <Pressable style={{ padding: 4}} onPress={() => {
            console.log('------------> Settings.toSettingPage()')
            Settings.toSettingPage()
          }}>
            <Image source={require('@/assets/images/Settings@3x.svg.png')} width={22} height={22}  />
          </Pressable>
        </XStack>
      </XStack>
      <YStack alignItems={'center'} marginVertical={20}>
        <XStack alignItems={'center'}>
          <Text marginLeft={6} color={'#A0A6B4'} fontSize={14}>All Mainnets</Text>
          <Image source={require('@/assets/images/ic_down_gray.png')} width={14} height={14} />
        </XStack>
        <Image source={require('@/assets/images/Eye@3x.svg.png')} width={17} height={14} marginTop={14} />
        <XStack alignItems={'center'} gap={8}>
          <Text color={'#gray'} fontSize={14}>--</Text>
          <Stack width={4} height={4} borderRadius={2} backgroundColor={'gray'} />
          <Text color={'#gray'} fontSize={14}>--</Text>
        </XStack>
      </YStack>
      <XStack alignItems={'center'} justifyContent={'space-between'} marginHorizontal={24}>
        <YStack alignItems={'center'}>
          <View width={36} height={36} borderRadius={18} backgroundColor={'#C6E7FE'} alignItems={'center'} justifyContent={'center'}>
            <Image source={require('@/assets/images/ic_tab_buy_selected.png')} width={20} height={20} />
          </View>
          <Text marginTop={4} color={'#3898F9'} fontSize={14}>Buy</Text>
        </YStack>
        <YStack alignItems={'center'}>
          <View width={36} height={36} borderRadius={18} backgroundColor={'#C6E7FE'} alignItems={'center'} justifyContent={'center'}>
            <Image source={require('@/assets/images/iw_send.png')} width={20} height={20} />
          </View>
          <Text marginTop={4} color={'#3898F9'} fontSize={14}>Send</Text>
        </YStack>
        <YStack alignItems={'center'}>
          <View width={36} height={36} borderRadius={18} backgroundColor={'#C6E7FE'} alignItems={'center'} justifyContent={'center'}>
            <Image source={require('@/assets/images/iw_receive.png')} width={20} height={20} />
          </View>
          <Text marginTop={4} color={'#3898F9'} fontSize={14}>Receive</Text>
        </YStack>
        <YStack alignItems={'center'}>
          <View width={36} height={36} borderRadius={18} backgroundColor={'#C6E7FE'} alignItems={'center'} justifyContent={'center'}>
            <Image source={require('@/assets/images/ic_leaf.png')} width={20} height={20} />
          </View>
          <Text marginTop={4} color={'#3898F9'} fontSize={14}>Earn</Text>
        </YStack>
      </XStack>
      <View flex={1} marginTop={12}>
        <TabView
          navigationState={{ index, routes }}
          renderScene={renderScene}
          onIndexChange={setIndex}
          initialLayout={{ width: layout.width }}
          renderTabBar={renderTabBar}
        />
      </View>
      <XStack marginTop={6} margin={12} height={36} alignItems={'center'} borderRadius={12} backgroundColor={'#E7EDF2'}>
        <Image source={require('@/assets/images/search.png')} marginLeft={12} width={14} height={14} />
        <View flex={1} alignItems={'center'} marginRight={26}>
          <Text color={'#A0A6B4'}>Browse Web3</Text>
        </View>
      </XStack>
    </YStack>
  );
}
