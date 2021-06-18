import 'package:flutter/material.dart';
import '../models/coin_data.dart';

import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import '/controllers/apikey_acceess.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurency = 'USD';
  var btcJasonData;
  var ethJasonData;
  var ltcJasonData;
  var btcValue = '0';
  var ethValue = '0';
  var ltcValue = '0';
  AccessApiData aacc = AccessApiData();

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurency,
      items: dropDownItems,
      onChanged: (value) {
        print(value);
        setState(() {
          selectedCurency = value!;
          print(value);
          // jasonData = aacc.fetchApi(selectedCurency);
          // print(jasonData);
          getLocationWeather();
        });
      },
    );
  }

  CupertinoPicker iOsPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationWeather();
  }

  Future<dynamic> getLocationWeather() async {
    try {
      btcJasonData = await aacc.fetchApi(selectedCurency, 'BTC');
      btcValue = await btcJasonData['rate'].toStringAsFixed(0);

      ethJasonData = await aacc.fetchApi(selectedCurency, 'ETH');
      ethValue = await ethJasonData['rate'].toStringAsFixed(0);

      ltcJasonData = await aacc.fetchApi(selectedCurency, 'LTC');
      ltcValue = await ltcJasonData['rate'].toStringAsFixed(0);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // getApiData();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CoinCard(
              baseCoin: 'BTC',
              btcValue: btcValue,
              selectedCurency: selectedCurency),
          CoinCard(
              baseCoin: 'ETH',
              btcValue: ethValue,
              selectedCurency: selectedCurency),
          CoinCard(
              baseCoin: 'LTC',
              btcValue: ltcValue,
              selectedCurency: selectedCurency),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOsPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  const CoinCard({
    Key? key,
    required this.baseCoin,
    required this.btcValue,
    required this.selectedCurency,
  }) : super(key: key);

  final String btcValue;
  final String selectedCurency;
  final String baseCoin;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      // padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $baseCoin = $btcValue $selectedCurency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
