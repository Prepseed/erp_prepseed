class LeavesModel {
  bool? success;
  List<Leaves>? leaves;

  LeavesModel({this.success, this.leaves});

  LeavesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['leaves'] != null) {
      leaves = <Leaves>[];
      json['leaves'].forEach((v) {
        leaves!.add(Leaves.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (leaves != null) {
      data['leaves'] = leaves!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leaves {
  String? sId;
  String? fromDate;
  String? toDate;
  List<LeavesStatus>? leavesStatus;
  User? user;

  Leaves({this.sId, this.fromDate, this.toDate, this.leavesStatus, this.user});

  Leaves.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    if (json['leavesStatus'] != null) {
      leavesStatus = <LeavesStatus>[];
      json['leavesStatus'].forEach((v) {
        leavesStatus!.add(LeavesStatus.fromJson(v));
      });
    }
    if (json['leaves'] != null) {
      leavesStatus = <LeavesStatus>[];
      json['leaves'].forEach((v) {
        leavesStatus!.add(LeavesStatus.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    if (leavesStatus != null) {
      data['leavesStatus'] = leavesStatus!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class LeavesStatus {
  bool? granted;
  bool? rejected;
  String? type;
  String? sId;
  String? date;
  bool? fullDay;

  LeavesStatus(
      {this.granted,
        this.rejected,
        this.type,
        this.sId,
        this.date,
        this.fullDay});

  LeavesStatus.fromJson(Map<String, dynamic> json) {
    granted = json['granted'];
    rejected = json['rejected'];
    type = json['type'];
    sId = json['_id'];
    date = json['date'];
    fullDay = json['fullDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['granted'] = granted;
    data['rejected'] = rejected;
    data['type'] = type;
    data['_id'] = sId;
    data['date'] = date;
    data['fullDay'] = fullDay;
    return data;
  }
}

class User {
  String? dp;
  String? sId;
  String? email;
  String? name;
  String? mobileNumber;
  String? username;

  User(
      {this.dp,
        this.sId,
        this.email,
        this.name,
        this.mobileNumber,
        this.username});

  User.fromJson(Map<String, dynamic> json) {
    dp = json['dp'];
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dp'] = dp;
    data['_id'] = sId;
    data['email'] = email;
    data['name'] = name;
    data['mobileNumber'] = mobileNumber;
    data['username'] = username;
    return data;
  }
}
