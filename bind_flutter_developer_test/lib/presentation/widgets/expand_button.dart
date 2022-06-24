import 'package:bind_flutter_developer_test/domain/transactions_bloc/transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpandButton extends StatelessWidget {
  final GestureTapCallback? onTap;

  const ExpandButton({Key? key, this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => BlocProvider.of<TransactionsBloc>(context).add(SetHideEventTransactions(false)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset("images/expand.png"),
        ),
      ),
    );
  }
}
