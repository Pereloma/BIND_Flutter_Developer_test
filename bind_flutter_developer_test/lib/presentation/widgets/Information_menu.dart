import 'package:bind_flutter_developer_test/domain/transactions_bloc/transactions_bloc.dart';
import 'package:bind_flutter_developer_test/presentation/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InformationMenu extends StatelessWidget {
  const InformationMenu({Key? key}) : super(key: key);
  static NumberFormat format = NumberFormat("###,###.0#");

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<TransactionsBloc, TransactionsState>(
          buildWhen: (previous, current) {
            if (current.runtimeType == TransactionsLoad) {
              return false;
            } else if (previous.runtimeType == TransactionsLoad) {
              return true;
            }
            previous as TransactionsInitial;
            current as TransactionsInitial;
            return previous.image != current.image || previous.balance != current.balance || previous.selectRate != current.selectRate;
          },
          builder: (context, state) {
            state as TransactionsInitial;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 58),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(state.image ??
                              "images/rates/${state.selectRate.charCode}.png"),
                          onError: (exception, stackTrace) {
                            BlocProvider.of<TransactionsBloc>(context)
                                .add(SetImageDefaultEventTransactions());
                          },
                        ),
                        shape: BoxShape.circle),
                  ),
                  const SizedBox(height: 22),
                  Center(
                      child: Text("${state.selectRate.charCode} Account",
                          style: TextStyles.account)),
                  const SizedBox(height: 28),
                  Center(
                      child: Text(
                          "${state.selectRate.currencySymbol} ${format.format(state.balance)}",
                          style: TextStyles.money)),
                  const SizedBox(height: 73),
                ]);
          },
        ),
        Positioned.fill(
          child: Align(
              alignment: const Alignment(0.9, 0.0),
              child: OutlinedButton(
                onPressed: () => BlocProvider.of<TransactionsBloc>(context)
                    .add(SetHideEventTransactions(true)),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    side: const BorderSide(
                        color: Color(0xFF333333))),
                child: const Text(
                  "Hide",
                  style: TextStyles.buttonText,
                ),
              )),
        )
      ],
    );
  }
}
