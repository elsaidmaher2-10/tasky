enum ItemActionEnum {
  edit(id: 1),
  delete(id: 2),
  markAsDone(id: 3);

  final int id;

  const ItemActionEnum({required this.id});
}
