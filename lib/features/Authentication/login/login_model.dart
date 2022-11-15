class SignInUser {
  String? sId;
  String? username;
  String? name;
  String? mobileNumber;
  String? email;
  bool? isVerified;
  String? dp;
  String? thumbnail;
  String? role;
  int? demoStep;
  List<Subscriptions>? subscriptions;

  SignInUser(
      {this.sId,
        this.username,
        this.name,
        this.mobileNumber,
        this.email,
        this.isVerified,
        this.dp,
        this.thumbnail,
        this.role,
        this.demoStep,
        this.subscriptions});

  SignInUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    isVerified = json['isVerified'];
    dp = json['dp'];
    thumbnail = json['thumbnail'];
    role = json['role'];
    demoStep = json['demoStep'];
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['subscriptions'].forEach((v) {
        subscriptions!.add(new Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['isVerified'] = this.isVerified;
    data['dp'] = this.dp;
    data['thumbnail'] = this.thumbnail;
    data['role'] = this.role;
    data['demoStep'] = this.demoStep;
    if (this.subscriptions != null) {
      data['subscriptions'] =
          this.subscriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subscriptions {
  String? group;
  List<Subgroups>? subgroups;

  Subscriptions({this.group, this.subgroups});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    if (json['subgroups'] != null) {
      subgroups = <Subgroups>[];
      json['subgroups'].forEach((v) {
        subgroups!.add(new Subgroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    if (this.subgroups != null) {
      data['subgroups'] = this.subgroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subgroups {
  String? group;
  List<Phases>? phases;

  Subgroups({this.group, this.phases});

  Subgroups.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    if (json['phases'] != null) {
      phases = <Phases>[];
      json['phases'].forEach((v) {
        phases!.add(new Phases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    if (this.phases != null) {
      data['phases'] = this.phases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Phases {
  bool? active;
  bool? isAccessGranted;
  Phase? phase;

  Phases({this.active, this.isAccessGranted, this.phase});

  Phases.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    isAccessGranted = json['isAccessGranted'];
    phase = json['phase'] != null ? new Phase.fromJson(json['phase']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['isAccessGranted'] = this.isAccessGranted;
    if (this.phase != null) {
      data['phase'] = this.phase!.toJson();
    }
    return data;
  }
}

class Phase {
  Config? config;
  List<String>? topics;
  bool? topicMocks;
  bool? sectionalMocks;
  bool? fullMocks;
  bool? liveTests;
  int? users;
  bool? isPrivate;
  bool? hasCoursePlan;
  bool? inferCoursePlan;
  List<String>? subjects;
  String? sId;
  String? name;
  String? startDate;
  String? endDate;

  Phase(
      {this.config,
        this.topics,
        this.topicMocks,
        this.sectionalMocks,
        this.fullMocks,
        this.liveTests,
        this.users,
        this.isPrivate,
        this.hasCoursePlan,
        this.inferCoursePlan,
        this.subjects,
        this.sId,
        this.name,
        this.startDate,
        this.endDate});

  Phase.fromJson(Map<String, dynamic> json) {
    config =
    json['config'] != null ? new Config.fromJson(json['config']) : null;
    topics = json['topics'].cast<String>();
    topicMocks = json['topicMocks'];
    sectionalMocks = json['sectionalMocks'];
    fullMocks = json['fullMocks'];
    liveTests = json['liveTests'];
    users = json['users'];
    isPrivate = json['isPrivate'];
    hasCoursePlan = json['hasCoursePlan'];
    inferCoursePlan = json['inferCoursePlan'];
    subjects = json['subjects'].cast<String>();
    sId = json['_id'];
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    data['topics'] = this.topics;
    data['topicMocks'] = this.topicMocks;
    data['sectionalMocks'] = this.sectionalMocks;
    data['fullMocks'] = this.fullMocks;
    data['liveTests'] = this.liveTests;
    data['users'] = this.users;
    data['isPrivate'] = this.isPrivate;
    data['hasCoursePlan'] = this.hasCoursePlan;
    data['inferCoursePlan'] = this.inferCoursePlan;
    data['subjects'] = this.subjects;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}

class Config {
  bool? enableChats;
  bool? enableForum;
  bool? enableAnnouncements;
  bool? disablePractice;

  Config(
      {this.enableChats,
        this.enableForum,
        this.enableAnnouncements,
        this.disablePractice});

  Config.fromJson(Map<String, dynamic> json) {
    enableChats = json['enableChats'];
    enableForum = json['enableForum'];
    enableAnnouncements = json['enableAnnouncements'];
    disablePractice = json['disablePractice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enableChats'] = this.enableChats;
    data['enableForum'] = this.enableForum;
    data['enableAnnouncements'] = this.enableAnnouncements;
    data['disablePractice'] = this.disablePractice;
    return data;
  }
}
