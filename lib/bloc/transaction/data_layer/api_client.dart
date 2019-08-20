import 'dart:convert';

import 'package:http/http.dart';
import 'package:pertani_shop/models/transaction.dart';
import 'package:pertani_shop/utils/coded_exception.dart';

class TransactionListApiClient {
  final Client http = Client();
  final String baseUrl = "http://localhost/api/transactions";

  Future<Transaction> fetch({int id}) async {
    try {
      final result = await http.get("$baseUrl/$id/");

      if (result.statusCode != 200) {
        throw Exception();
      }

      final body = result.body;

      return Transaction.fromMap(jsonDecode(body));
    } catch (e) {
      throw CodedException();
    }
  }

  Future<Transaction> create({Transaction transaction}) async {
    try {
      final response = await http.post("$baseUrl/");
      final body = response.body;
      
      return transaction;
    } catch (e) {}
  }
}
