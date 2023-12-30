import 'package:flutter/material.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_app_bar.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HomeAppBar(),
          Expanded(
            child: ExchangeTable(),
          ),
          HomeBottomBar(),
        ],
      ),
    );
  }
}
