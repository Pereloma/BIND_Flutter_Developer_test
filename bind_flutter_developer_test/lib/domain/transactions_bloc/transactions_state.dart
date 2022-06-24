part of 'transactions_bloc.dart';

@immutable
abstract class TransactionsState {}

class TransactionsInitial extends TransactionsState {
  final bool hide;
  final List<Rate> rates;
  final Rate selectRate;
  final double balance;
  final String? image;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final List<Transaction> transactions;
  final List<String> companies;
  final String selectCompanies;

  TransactionsInitial({
    required this.rates,
    this.hide = false,
    required this.selectRate,
    required this.balance,
    this.image,
    this.firstDate,
    this.lastDate,
    required this.transactions,
    required this.companies,
    required this.selectCompanies,
  });

  TransactionsInitial copy(
      {bool? hide,
      List<Rate>? rates,
      Rate? selectRate,
      double? balance,
      String? image,
      DateTime? firstDate,
      DateTime? lastDate,
      List<Transaction>? transactions,
      List<String>? companies,
      String? selectCompanies}) {
    return TransactionsInitial(
        hide: hide ?? this.hide,
        rates: rates ?? this.rates,
        selectRate: selectRate ?? this.selectRate,
        balance: balance ?? this.balance,
        image: image,
        firstDate: firstDate ?? this.firstDate,
        lastDate: lastDate ?? this.lastDate,
        transactions: transactions ?? this.transactions,
        companies: companies ?? this.companies,
        selectCompanies: selectCompanies?? this.selectCompanies);
  }
}

class TransactionsLoad extends TransactionsState {}
