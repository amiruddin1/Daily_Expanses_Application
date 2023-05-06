class MyTransaction{
  int? TransactionID_PK  = null;
  String TransactionTitle = "";
  String TransactionDescription = "";
  int TransactionAmount = 0;
  String TransactionMode = "";
  String TransactionDateTime="";

  MyTransaction({required this.TransactionID_PK,required this.TransactionTitle,required this.TransactionDescription,required this.TransactionAmount,required this.TransactionMode, required this.TransactionDateTime});
  Map<String, dynamic> toMap() {
    return {
      'TransactionID_PK': TransactionID_PK,
      'TransactionTitle': TransactionTitle,
      'TransactionDescription': TransactionDescription,
      'TransactionAmount': TransactionAmount,
      'TransactionMode': TransactionMode,
      'TransactionDateTime': TransactionDateTime
    };
  }

  List<MyTransaction> mapToList(List<Map<String, dynamic>> d){
    return d.map((map) => MyTransaction(
          TransactionID_PK: map['TransactionID_PK'],
          TransactionTitle: map['TransactionTitle'],
          TransactionDescription: map['TransactionDescription'],
          TransactionAmount: map['TransactionAmount'],
          TransactionMode: map['TransactionMode'],
          TransactionDateTime: map['TransactionDateTime'])).toList();
  }
}