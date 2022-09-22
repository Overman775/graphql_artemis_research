import 'package:flutter/material.dart';

import '../../../api/api.query.graphql.dart';
import '../data/home_repository.dart';

class HomePage extends StatefulWidget {
  final HomeRepository repository;

  const HomePage({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Accounts$Query$Account> accounts = [];

  @override
  void initState() {
    _updateAccounts();
    super.initState();
  }

  void _updateAccounts() async {
    final result = await widget.repository.fetchAccounts();
    setState(() {
      accounts = result;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (BuildContext context, int index) {
            final account = accounts[index];
            return ListTile(
              title: Text(account.name),
              subtitle: Column(
                children: [
                  for (final card in accounts[index]
                          .cards
                          ?.whereType<Accounts$Query$Account$Card>() ??
                      <Accounts$Query$Account$Card>[])
                    Text(card.name)
                ],
              ),
            );
          },
        ),
      );
}
