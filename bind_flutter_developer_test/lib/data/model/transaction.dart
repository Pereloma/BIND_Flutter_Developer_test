import 'package:bind_flutter_developer_test/data/model/rate.dart';

class Transaction {
  final String? image;
  final String name;
  final DateTime date;
  final double amount;
  final Rate rate;

  Transaction({required this.name, this.image, required this.date, required this.amount, required this.rate});
}