class FinancialModel {
  FinancialModel({
      this.balance, 
      this.totalReservationPayments, 
      this.transactions,});

  FinancialModel.fromJson(dynamic json) {
    balance = json['balance'];
    totalReservationPayments = json['total_reservation_payments'];
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions?.add(Transactions.fromJson(v));
      });
    }
  }
  int? balance;
  int? totalReservationPayments;
  List<Transactions>? transactions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['balance'] = balance;
    map['total_reservation_payments'] = totalReservationPayments;
    if (transactions != null) {
      map['transactions'] = transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Transactions {
  Transactions({
      this.id, 
      this.date, 
      this.amount, 
      this.destinationCardNumber, 
      this.isDone, 
      this.wallet,});

  Transactions.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    amount = json['amount'];
    destinationCardNumber = json['destination_card_number'];
    isDone = json['is_done'];
    wallet = json['wallet'];
  }
  int? id;
  String? date;
  int? amount;
  String? destinationCardNumber;
  bool? isDone;
  int? wallet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['amount'] = amount;
    map['destination_card_number'] = destinationCardNumber;
    map['is_done'] = isDone;
    map['wallet'] = wallet;
    return map;
  }

}