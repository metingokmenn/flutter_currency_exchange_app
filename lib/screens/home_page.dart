import 'package:flutter/material.dart';
import 'package:flutter_currency_exchange_app/services/currency_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedValue = 'eur';
  String _secondSelectedValue = 'usd';
  String _currentCurrencyRate = '0';
  late Future currencyFuture;

  @override
  void initState() {
    currencyFuture = CurrencyService().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange'),
      ),
      body: FutureBuilder(
        future: currencyFuture,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 100,
                              child: DropdownButton(
                                  value: _selectedValue,
                                  items: createDropdowns(snapshot.data!),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = value!;
                                    });
                                  }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(snapshot.data![_selectedValue])
                          ],
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: DropdownButton(
                                      value: _secondSelectedValue,
                                      items: createDropdowns(snapshot.data!),
                                      onChanged: (value) {
                                        setState(() {
                                          _secondSelectedValue = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(snapshot.data![_secondSelectedValue])
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      _currentCurrencyRate,
                      style: const TextStyle(fontSize: 36),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          _currentCurrencyRate = (await CurrencyService()
                              .convertCurrency(
                                  _selectedValue, _secondSelectedValue));

                          setState(() {});
                        },
                        child: const Text('Convert!')),
                  ],
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> createDropdowns(Map<String, dynamic> data) {
    List<DropdownMenuItem<String>> itemList = List.generate(
        data.length,
        (index) => DropdownMenuItem(
              value: data.keys.toList()[index],
              child: Text(
                data.keys.toList()[index],
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ));

    return itemList;
  }
}
