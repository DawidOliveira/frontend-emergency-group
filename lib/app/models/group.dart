class GroupModel {
  String name;
  int ownerId;
  int id;

  GroupModel({
    this.name,
    this.ownerId,
    this.id,
  });

  factory GroupModel.fromJson({String name, int owner, int id}) {
    return GroupModel(
      name: name,
      ownerId: owner,
      id: id,
    );
  }
}
