import 'package:bind_flutter_developer_test/domain/transactions_bloc/transactions_bloc.dart';
import 'package:bind_flutter_developer_test/presentation/widgets/Information_menu.dart';
import 'package:bind_flutter_developer_test/presentation/widgets/transactions_list.dart';
import 'package:bind_flutter_developer_test/presentation/widgets/transactions_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      buildWhen: (previous, current) {
        if (current.runtimeType == TransactionsLoad || previous.runtimeType == TransactionsLoad){
          return true;
        }
        previous as TransactionsInitial;
        current as TransactionsInitial;
        return previous.hide != current.hide;
      },
      builder: (context, state) {
        if (state.runtimeType == TransactionsInitial) {
          state as TransactionsInitial;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              state.hide ? const SizedBox() : InformationMenu(),
              TransactionsMenu(),
              Expanded(child: TransactionsListMenu()),
            ],
          );
        }
        return Container(
          color: Colors.black,
          child: Center(child: const CircularProgressIndicator(color: Colors.white)),
        );
      },
    );
  }
}
