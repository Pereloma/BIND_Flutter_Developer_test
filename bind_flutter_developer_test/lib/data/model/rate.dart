class Rate {
  final String charCode;
  final String currency;
  final String currencySymbol;
  Rate({required this.charCode, required this.currency, this.currencySymbol = "¤"});
}