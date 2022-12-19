abstract class DataType {
  final bool nullable;
  const DataType(this.nullable);

  DataType makeNullable(bool nullable);
  dynamic accept(visitor, argument) => visitor.visit(this, argument);
}
