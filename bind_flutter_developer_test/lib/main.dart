import 'package:bind_flutter_developer_test/domain/transactions_bloc/transactions_bloc.dart';
import 'package:bind_flutter_developer_test/presentation/main_page.dart';
import 'package:bind_flutter_developer_test/presentation/widgets/expand_button.dart';
import 'package:bind_flutter_developer_test/presentation/widgets/back_button.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme:  ColorScheme.fromSeed(
              seedColor: Colors.black,
              primary: Colors.black,
              onPrimary: Colors.white),
        appBarTheme: const AppBarTheme(color: Colors.black),
      ),
      home: BlocProvider(
        create: (context) => TransactionsBloc(),
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: const BackButton(),
            actions: [ExpandButton()],
          ),
          body: MainPage(),
        ),
      ),
    );
  }
}
