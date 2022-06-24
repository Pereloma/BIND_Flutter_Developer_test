part of 'transactions_bloc.dart';

@immutable
abstract class TransactionsEvent {}

class SetHideEventTransactions extends TransactionsEvent {
  SetHideEventTransactions(this.hide);
  final bool hide;
}
class SetImageDefaultEventTransactions extends TransactionsEvent {
}
class SelectRateEventTransactions extends TransactionsEvent {
  final Rate selectedRate;
  SelectRateEventTransactions(this.selectedRate);
}
class SetDateEventTransactions extends TransactionsEvent {
  final DateTime firstDate;
  final DateTime lastDate;
  SetDateEventTransactions(this.firstDate, this.lastDate);
}
class SelectCompaniesEventTransactions extends TransactionsEvent {
  final String selectedCompanies;
  SelectCompaniesEventTransactions(this.selectedCompanies);
}

class InitializeStateEventTransactions extends TransactionsEvent {}
