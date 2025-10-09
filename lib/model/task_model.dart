class TaskModel {
  String taskname;
  String taskdescription;
  bool isHighPeriorty;
  bool? ischecked;
  int id;
  TaskModel({
    required this.taskname,
    required this.taskdescription,
    required this.isHighPeriorty,
    required this.ischecked,
    this.id = 0,
  });
  factory TaskModel.fromJson(e) {
    return TaskModel(
      id: e["id"],
      ischecked: e["ischecked"] ?? false,
      taskname: e["taskname"],
      taskdescription: e["taskdescription"],
      isHighPeriorty: e["isHighPeriorty"] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "taskname": taskname,
      "taskdescription": taskdescription,
      "isHighPeriorty": isHighPeriorty,
      "ischecked": ischecked,
    };
  }
}
