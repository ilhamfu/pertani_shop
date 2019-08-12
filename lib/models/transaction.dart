import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product.dart';

class TransactionStatus {
  static String transactionStatusDesc(String code) => {
        'NC': 'NOT CONFIRMED',
        'NP': 'NOT PAYED',
        'PC': 'PAYMENT CONFIRMED',
        'TP': 'TRANSACTION IN PROCESS',
        'PS': 'PRODUCT SENDED',
        'PA': 'PRODUCT ACCEPTED',
        'TF': 'TRANSACTION FINISHED',
        'PR': 'PRODUCT RATED',
        'NA': 'NOT ACCEPTED'
      }[code];

  static const String STATUS_CODE_NOT_CONFIRMED = "NC";
  static const String STATUS_CODE_NOT_PAYED = "NP";
  static const String STATUS_CODE_PAYMENT_CONFIRMED = "PC";
  static const String STATUS_CODE_TRANSACTION_IN_PROCESS = "TP";
  static const String STATUS_CODE_PRODUCT_SENDED = "PS";
  static const String STATUS_CODE_PRODUCT_ACCEPTED = "PA";
  static const String STATUS_CODE_TRANSACTION_FINISHED = "TF";
  static const String STATUS_CODE_PRODUCT_RATED = "PR";
  static const String STATUS_CODE_NOT_ACCEPTED = "NA";
}

class TransactionHistory extends Equatable {
  final int id;
  final DateTime changedAt;
  final String fromStatus;
  final String toStatus;

  TransactionHistory(
      {this.id, this.changedAt, String fromStatus, String toStatus})
      : this.fromStatus = TransactionStatus.transactionStatusDesc(fromStatus),
        this.toStatus = TransactionStatus.transactionStatusDesc(toStatus),
        super([id, changedAt, fromStatus, toStatus]);

  factory TransactionHistory.fromMap(Map<String, dynamic> map) {
    return TransactionHistory(
      id: map["id"],
      changedAt: map["changedat"],
      fromStatus: map["fromStatus"],
      toStatus: map["toStatus"],
    );
  }
}

class TransactionDetail extends Equatable {
  final int id;
  final Product product;
  final int price;
  final int total;
  final int rate;
  final String testimony;

  TransactionDetail(
      {this.id,
      this.product,
      this.price,
      this.total,
      this.rate,
      this.testimony})
      : super([id, product, price, total, rate, testimony]);

  factory TransactionDetail.fromMap(Map<String, dynamic> map) {
    return TransactionDetail(
        id: map["id"],
        product: Product.fromMap(map["product"]),
        price: map["price"],
        total: map["total"],
        rate: map["rate"],
        testimony: map["testimony"]);
  }

  Map<String,dynamic> toMap(){
    return {
      "id":this.id,
      "product":this.product.id,
      "price":this.price,
      "total":this.total,
      "rate":this.rate,
      "testimony":this.testimony,
    };
  }
}

class Transaction extends Equatable {
  final int id;
  final TransactionDetail detail;
  final TransactionHistory history;
  final String transactionStatus;
  final bool cod;
  final bool canceled;
  final DateTime canceledDate;
  final DateTime duePayment;
  final int total;

  Transaction(
      {this.id,
      this.detail,
      this.history,
      String transactionStatus,
      this.cod,
      this.canceled,
      this.canceledDate,
      this.duePayment,
      this.total})
      : this.transactionStatus =
            TransactionStatus.transactionStatusDesc(transactionStatus),
        super([
          id,
          detail,
          history,
          transactionStatus,
          cod,
          canceled,
          canceledDate,
          duePayment,
          total,
        ]);

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map["id"],
      detail: TransactionDetail.fromMap(map["detail"]),
      history: TransactionHistory.fromMap(map["history"]),
      transactionStatus: map["transaction_status"],
      cod: map["cod"],
      canceled: map["canceled"],
      canceledDate: map["canceled_date"],
      duePayment: map["due_payment"],
      total: map["total"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id":this.id,
      "detail":this.detail,
      "history":this.history,
      "transactionStatus":this.transactionStatus,
      "cod":this.cod,
      "canceled":this.canceled,
      "canceledDate":this.canceledDate,
      "duePayment":this.duePayment,
      "total":this.total,
    };
  }
}
