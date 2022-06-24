import 'dart:async';

import 'package:bind_flutter_developer_test/data/model/rate.dart';
import 'package:bind_flutter_developer_test/data/model/transaction.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transactions_event.dart';

part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsLoad()) {
    on<InitializeStateEventTransactions>(
      (_, emit) => onInitializeStateEventTransactions(emit),
    );

    on<SetHideEventTransactions>(
        (event, emit) => onSetHideEventTransactions(event, emit));
    on<SetImageDefaultEventTransactions>(
        (event, emit) => onSetImageDefaultEventTransactions(event, emit));
    on<SelectRateEventTransactions>(
        (event, emit) => onSelectRateEventTransactions(event, emit));
    on<SetDateEventTransactions>(
        (event, emit) => onSetDateEventTransactions(event, emit));
    on<SelectCompaniesEventTransactions>(
            (event, emit) => onSelectCompaniesEventTransactions(event, emit));


    add(InitializeStateEventTransactions());
  }

  void onInitializeStateEventTransactions(Emitter emit) async {
    String allComp = "All";
    List<Rate> rates = await getRates();
    double balance = await getBalance(rates.first);
    List<Transaction> transactions = await getTransactions(true, rates.first);

    emit(TransactionsInitial(
        rates: rates,
        selectRate: rates.first,
        balance: balance,
        transactions: transactions,
        companies: [allComp, ...transactions.map((e) => e.name).toSet()],
        selectCompanies: allComp));
  }

  void onSetHideEventTransactions(
      SetHideEventTransactions event, Emitter<TransactionsState> emit) {
    if (state.runtimeType == TransactionsInitial) {
      emit((state as TransactionsInitial).copy(hide: event.hide));
    }
  }

  void onSetImageDefaultEventTransactions(
      SetImageDefaultEventTransactions event, Emitter<TransactionsState> emit) {
    if (state.runtimeType == TransactionsInitial) {
      emit((state as TransactionsInitial)
          .copy(image: "images/rates/default.png"));
    }
  }

  void onSelectRateEventTransactions (
      SelectRateEventTransactions event, Emitter<TransactionsState> emit) async {
    if (state.runtimeType == TransactionsInitial) {
      List<Transaction> transactions = await getTransactions(true, event.selectedRate);
      emit((state as TransactionsInitial).copy(
        selectRate: event.selectedRate,
        image: null,
        transactions: transactions
      ));
    }
  }

  void onSetDateEventTransactions(
      SetDateEventTransactions event, Emitter<TransactionsState> emit) {
    if (state.runtimeType == TransactionsInitial) {
      emit((state as TransactionsInitial)
          .copy(lastDate: event.lastDate, firstDate: event.firstDate));
    }
  }

  void onSelectCompaniesEventTransactions(
      SelectCompaniesEventTransactions event, Emitter<TransactionsState> emit) {
    if (state.runtimeType == TransactionsInitial) {
      emit((state as TransactionsInitial)
          .copy(selectCompanies: event.selectedCompanies));
    }
  }


  Future<List<Rate>> getRates() async {
    return [
      Rate(charCode: "USD", currency: "USD Dollar", currencySymbol: "\$"),
      Rate(charCode: "AUD", currency: "Australian Dollar"),
      Rate(charCode: "AMD", currency: "Armenia Dram"),
      Rate(charCode: "BYN", currency: "Belarussian Ruble"),
      Rate(charCode: "RUB", currency: "Russian Ruble", currencySymbol: "₽"),
      Rate(charCode: "HKD", currency: "Hong Kong Dollar"),
      Rate(charCode: "DKK", currency: "Danish Krone"),
      Rate(charCode: "EUR", currency: "Euro", currencySymbol: "€"),
      Rate(charCode: "INR", currency: "Indian Rupee"),
      Rate(charCode: "KZT", currency: "Kazakhstan Tenge"),
      Rate(charCode: "UAH", currency: "Ukrainian Hryvnia"),
      Rate(charCode: "GBP", currency: "British Pound Sterling"),
      Rate(charCode: "JPY", currency: "Japanese Yen")
    ];
  }

  Future<double> getBalance(Rate rate) async {
    switch (rate.charCode) {
      case "USD":
        return 180970.83;
      case "RUB":
        return 2875654.27;
      case "EUR":
        return 475.00;
      default:
        return 0.00;
    }
  }

  Future<List<Transaction>> getTransactions(bool sort, Rate rate) async {
    List<Transaction> transactions;
    DateTime now = DateTime.now();
    switch (rate.charCode) {
      case "USD":
        transactions = [
          Transaction(
              name: "Pret A Manager",
              date: DateTime(now.year, now.month, now.day, 12, 23),
              amount: -55.31,
              rate: rate,
              image: "images/logo/PRET.png"),
          Transaction(
              name: "Darren Hodgkin",
              date: DateTime(now.year, now.month, now.day, 12, 23),
              amount: 130.31,
              rate: rate),
          Transaction(
              name: "McDonalds",
              date: DateTime(now.year, now.month, now.day, 12, 23),
              amount: -55.31,
              rate: rate,
              image: "images/logo/McDonalds.png"),
          Transaction(
              name: "Starbucks",
              date: DateTime(now.year, now.month, now.day, 12, 23),
              amount: -55.31,
              rate: rate,
              image: "images/logo/Starbucks.png"),
          Transaction(
              name: "Dave Winklevoss",
              date: DateTime(now.year, now.month, now.day, 12, 23),
              amount: -300.31,
              rate: rate),
          Transaction(
              name: "Virgin Megastore",
              date: DateTime(now.year-1, 12, 11, 12, 23),
              amount: -500.31,
              rate: rate,
              image: "images/logo/Virgin.png"),
          Transaction(
              name: "Nike",
              date: DateTime(now.year-1, 12, 11, 12, 23),
              amount: -500.31,
              rate: rate,
              image: "images/logo/Nike.png"),
          Transaction(
              name: "Louis Vuitton",
              date: DateTime(now.year-1, 12, 9, 12, 23),
              amount: -500.31,
              rate: rate,
              image: "images/logo/LV.png"),
          Transaction(
              name: "Carrefour",
              date: DateTime(now.year-1, 12, 9, 12, 23),
              amount: -500.31,
              rate: rate,
              image: "images/logo/Carrefour.png"),
        ];
        break;
      case "RUB":
        transactions = [
          Transaction(
              name: "McDonalds",
              date: DateTime(now.year-1, now.month, 7, 12, 5),
              amount: -47.58,
              rate: rate,
              image: "images/logo/McDonalds.png"),
          Transaction(
              name: "Starbucks",
              date: DateTime(now.year-1, now.month, now.day, 12, 23),
              amount: 428.17,
              rate: rate,
              image: "images/logo/Starbucks.png"),
        ];
        break;
      case "EUR":
        transactions = [
          Transaction(
              name: "Pret A Manager",
              date: DateTime(now.year-1, 6, 5, 20, 1),
              amount: 955.31,
              rate: rate,
              image: "images/logo/PRET.png"),
          Transaction(
              name: "Darren Hodgkin",
              date: DateTime(now.year-1, 7, 1, 17, 00),
              amount: 130.31,
              rate: rate),
          Transaction(
              name: "Louis Vuitton",
              date: DateTime(now.year-1, 4, 4, 5, 57),
              amount: 518.31,
              rate: rate,
              image: "images/logo/LV.png"),
        ];
        break;
      default:
        transactions = [];
        break;
    }

    transactions.sort((a, b) {
      if (a.date.isBefore(b.date)) {
        return 1;
      }
      return -1;
    });
    return transactions;
  }
}
