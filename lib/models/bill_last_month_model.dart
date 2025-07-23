class BillsLastMonthModel {
  final String status;
  final int statusCode;
  final String message;
  final Payload payload;

  BillsLastMonthModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.payload,
  });

  factory BillsLastMonthModel.fromJson(Map<String, dynamic> json) {
    return BillsLastMonthModel(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      payload: Payload.fromJson(json['payload']),
    );
  }
}

class Payload {
  final int lastMonthStock;
  final int todayStock;
  final int totalStocks;
  final int thisMonthStock;
  final double growthPercentage;
  final List<Item> thisMonthItems;
  final List<Item> todayItems;

  Payload({
    required this.lastMonthStock,
    required this.todayStock,
    required this.totalStocks,
    required this.thisMonthStock,
    required this.growthPercentage,
    required this.thisMonthItems,
    required this.todayItems,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      lastMonthStock: json['lastMonthStock'],
      todayStock: json['todayStock'],
      totalStocks: json['totalStocks'],
      thisMonthStock: json['thisMonthStock'],
      growthPercentage: (json['growthPercentage'] as num).toDouble(),
      thisMonthItems: (json['thisMonthItems'] as List)
          .map((e) => Item.fromJson(e))
          .toList(),
      todayItems: (json['todayItems'] as List)
          .map((e) => Item.fromJson(e))
          .toList(),
    );
  }
}

class Item {
  final String itemCategory;
  final String shopId;
  final String model;
  final double sellingPrice;
  final int ram;
  final int rom;
  final String color;
  final int qty;
  final String company;
  final String logo;
  final List<int> createdDate;
  final String? description;
  final int billMobileItem;

  Item({
    required this.itemCategory,
    required this.shopId,
    required this.model,
    required this.sellingPrice,
    required this.ram,
    required this.rom,
    required this.color,
    required this.qty,
    required this.company,
    required this.logo,
    required this.createdDate,
    required this.description,
    required this.billMobileItem,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemCategory: json['itemCategory'],
      shopId: json['shopId'],
      model: json['model'],
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      ram: json['ram'],
      rom: json['rom'],
      color: json['color'],
      qty: json['qty'],
      company: json['company'],
      logo: json['logo'],
      createdDate: List<int>.from(json['createdDate']),
      description: json['description'],
      billMobileItem: json['billMobileItem'],
    );
  }
}
