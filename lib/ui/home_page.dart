import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:work_in_dio/data/models/currency_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
  final dio = Dio();

  Future<List> getDataFromApi() async {
    var response = await dio.get('https://nbu.uz/en/exchange-rates/json/');
    List currencies = response.data
        .map((current_currency) => Currency.fromJson(current_currency))
        .toList();
    print("maalymat keldi");
    return currencies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getDataFromApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                List data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => Container(
                    margin:const EdgeInsets.all(10.0),
                    height: 50,
                    width: double.infinity,
                    color: Colors.black12,
                    child: Row(
                      children: [
                        CountryFlag.fromCountryCode(
                          data[index].code.substring(0, 2),
                          height: 50,
                          width: 100,
                        ),
                        Text(data[index].title),
                        Text("${data[index].cbPrice} uzb"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return Center(child: Text("maalymat Keldi"));
            }),
      ),
    );
  }
}
