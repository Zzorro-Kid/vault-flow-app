enum Currency {
  usd('USD', '\$', 'US Dollar'),
  eur('EUR', '€', 'Euro'),
  gbp('GBP', '£', 'British Pound'),
  rub('RUB', '₽', 'Russian Ruble'),
  jpy('JPY', '¥', 'Japanese Yen'),
  cny('CNY', '¥', 'Chinese Yuan'),
  krw('KRW', '₩', 'South Korean Won'),
  inr('INR', '₹', 'Indian Rupee'),
  uah('UAH', '₴', 'Ukrainian Hryvnia'),
  pln('PLN', 'zł', 'Polish Zloty');

  final String code;
  final String symbol;
  final String name;

  const Currency(this.code, this.symbol, this.name);

  static Currency fromCode(String code) {
    return Currency.values.firstWhere(
      (currency) => currency.code == code,
      orElse: () => Currency.usd,
    );
  }
}
