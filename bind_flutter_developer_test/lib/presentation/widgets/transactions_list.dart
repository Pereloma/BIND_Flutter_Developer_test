import 'package:bind_flutter_developer_test/data/model/transaction.dart';
import 'package:bind_flutter_developer_test/domain/transactions_bloc/transactions_bloc.dart';
import 'package:bind_flutter_developer_test/presentation/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsListMenu extends StatelessWidget {
  const TransactionsListMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        state as TransactionsInitial;
        List<Transaction> transactions = state.transactions
            .where((element) =>
        (state.firstDate != null && state.lastDate != null ?
          element.date.isAfter(state.firstDate!) &&
          element.date.isBefore(state.lastDate!):
        true) && (state.selectCompanies != "All" ?
          element.name == state.selectCompanies :
        true)).toList();

        if (transactions.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Not found transactions",
              style: TextStyles.money,
            ),
          );
        }
        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                index > 0 &&
                        (transactions[index].date.day ==
                                transactions[index - 1].date.day &&
                            transactions[index].date.month ==
                                transactions[index - 1].date.month &&
                            transactions[index].date.year ==
                                transactions[index - 1].date.year)
                    ? Container(
                        color: const Color(0xFFebebeb),
                        height: 1.5,
                      )
                    : _Separator(transactions[index].date),
                _TransactionCard(transactions[index])
              ],
            );
          },
        );
      },
    );
  }
}

class _Separator extends StatelessWidget {
  final DateTime date;

  const _Separator(this.date);

  @override
  Widget build(BuildContext context) {
    const List<String> daysOfTheWeek = [
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun"
    ];
    const List<String> month = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    final now = DateTime.now();
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
      color: const Color(0xFFcccccc),
      child: (now.day == date.day &&
              now.month == date.month &&
              now.year == date.year)
          ? const Text("Yesterday")
          : now.year == date.year
              ? Text(
                  "${daysOfTheWeek[date.weekday - 1]}, ${month[date.month - 1]} ${date.day}")
              : Text(
                  "${date.year} ${daysOfTheWeek[date.weekday - 1]}, ${month[date.month - 1]} ${date.day}"),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const _TransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
      color: const Color(0xFFffffff),
      child: Row(
        children: [
          transaction.image == null
              ? Image.asset(
                  transaction.amount < 0
                      ? "images/default_minus.png"
                      : "images/default_plus.png",
                  width: 30,
                  height: 30)
              : Image.asset(transaction.image!, width: 30, height: 30),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(transaction.name),
                    Text("${transaction.amount} ${transaction.rate.charCode}"),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                    "${transaction.date.hour.toString().padLeft(2, '0')}:${transaction.date.minute.toString().padLeft(2, '0')}"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
