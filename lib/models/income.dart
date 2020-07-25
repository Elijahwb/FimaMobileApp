class Income {
  String source;
  double amount;
  DateTime date;

  Income({this.amount, this.source, this.date});

  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      source: json['source'],
      date: DateTime.parse(json['date']),
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'amount': amount,
      'date': date,
    };
  }
}

/*
import 'package:hive/hive.dart';

part 'income.g.dart';

@HiveType(typeId: 0)
class Income {
  @HiveField(0)
  final String source;
  @HiveField(1)
  final double amount;
  @HiveField(3)
  final DateTime date;
  Income({this.amount, this.source, this.date});
}*/
