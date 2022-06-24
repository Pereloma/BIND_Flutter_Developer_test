import 'package:bind_flutter_developer_test/data/model/rate.dart';
import 'package:bind_flutter_developer_test/domain/transactions_bloc/transactions_bloc.dart';
import 'package:bind_flutter_developer_test/presentation/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsMenu extends StatelessWidget {
  const TransactionsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0e0e10),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: BlocBuilder<TransactionsBloc, TransactionsState>(
          buildWhen: (previous, current) {
            if (current.runtimeType == TransactionsLoad) {
              return false;
            } else if (previous.runtimeType == TransactionsLoad) {
              return true;
            }
            previous as TransactionsInitial;
            current as TransactionsInitial;
            return previous.selectCompanies != current.selectCompanies || previous.selectRate != current.selectRate;},
          builder: (context, state) {
            state as TransactionsInitial;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Transactions History",
                      style: TextStyles.standard),
                  const SizedBox(height: 18),
                  DropdownButtonFormField<Rate>(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(color: Color(0xFF333333))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(color: Color(0xFF333333))),
                    ),
                    focusColor: Colors.amber,
                    style: TextStyles.standard,
                    icon: Image.asset("images/dropdown.png"),
                    dropdownColor: Colors.black,
                    onChanged: (value) =>
                        BlocProvider.of<TransactionsBloc>(context)
                            .add(SelectRateEventTransactions(value!)),
                    isExpanded: true,
                    value: state.selectRate,
                    items: state.rates
                        .map((e) => DropdownMenuItem<Rate>(
                            value: e, child: Text(e.currency)))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                borderSide:
                                    BorderSide(color: Color(0xFF333333))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                borderSide:
                                    BorderSide(color: Color(0xFF333333))),
                          ),
                          focusColor: Colors.amber,
                          style: TextStyles.standard,
                          icon: Image.asset("images/dropdown.png"),
                          dropdownColor: Colors.black,
                          onChanged: (value) {
                            BlocProvider.of<TransactionsBloc>(context)
                                .add(SelectCompaniesEventTransactions(value!));
                          },
                          isExpanded: true,
                          value: state.selectCompanies,
                          items: state.companies
                              .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e)))
                              .toList(),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            border: Border.all(color: const Color(0xFF333333))),
                        child: InkWell(
                          onTap: () async {
                            DateTime now = DateTime.now();
                            DateTime? first = await showDatePicker(
                                helpText: "Select first date",
                                context: context,
                                lastDate: now,
                                initialDate: now,
                                firstDate:
                                    now.add(const Duration(days: -1096)));
                            if (first != null) {
                              DateTime? last = await showDatePicker(
                                  helpText: "Select last date",
                                  context: context,
                                  lastDate: now,
                                  initialDate: now,
                                  firstDate: first);
                              if (last != null) {
                                BlocProvider.of<TransactionsBloc>(context)
                                    .add(SetDateEventTransactions(first, last));
                              }
                            }
                          },
                          child: Image.asset(
                            "images/calendar.png",
                            width: 32,
                            height: 32,
                          ),
                        ),
                      )
                    ],
                  )
                ]);
          },
        ),
      ),
    );
  }
}
