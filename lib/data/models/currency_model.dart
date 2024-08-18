class Currency {
  // {
  //     "title": "UAE Dirham",
  //     "code": "AED",
  //     "cb_price": "3438.87",
  //     "nbu_buy_price": "",
  //     "nbu_cell_price": "",
  //     "date": "08\/13\/2024 08:00:00 pm"
  // },
  String title;
  String code;
  
  String cbPrice;
  Currency({
    required this.title,
    required this.code,
  
    required this.cbPrice,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    String title = json["title"] ?? "no data";
    String code = json["code"] ?? "no data";
    String cbPrice = json["cb_price"] ?? "no date";
    return Currency(
      title: title,
      code: code,
      cbPrice: cbPrice,
    );
  }
}
