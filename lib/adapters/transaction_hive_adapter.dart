import 'package:despesas_app/app/models/transaction.dart';
import 'package:hive_flutter/adapters.dart';

class TransactionHiveAdapter extends TypeAdapter<Transaction> {
  @override
  final typeId = 0;

  @override
  Transaction read(BinaryReader reader) {
    return Transaction(
      id: reader.readString(),
      title: reader.readString(),
      value: reader.readDouble(),
      date: DateTime.fromMicrosecondsSinceEpoch(reader.readInt32()),
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeDouble(obj.value);
    writer.writeInt32(obj.date.microsecondsSinceEpoch);
  }
}
