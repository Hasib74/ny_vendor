import 'dart:core';

class BankInfoModel {
  var id;
  var bankHolder;
  var accountNumber;
  var bankName;
  var createdAt;
  var updatedAt;

  BankInfoModel({this.id, this.bankHolder, this.accountNumber, this.bankName,this.createdAt,
      this.updatedAt});

   BankInfoModel.fromJson(dynamic json) {
  
    id = json[0]['id'];
    bankHolder = json[0]['bank_holder'];
    accountNumber = json[0]['account_number'];
    bankName = json[0]['bank_name'];
    createdAt = json[0]['created_at'];
    updatedAt = json[0]['updated_at'];
  }

  Map<String, String?> toJson() {
    final Map<String, String?> data = new Map<String, String?>();
    data['id'] = this.id;
    data['bank_holder'] = this.bankHolder;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankHolder;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

}
