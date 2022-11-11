class ClientDetails {
  bool? success;
  List<Clients>? clients;

  ClientDetails({this.success, this.clients});

  ClientDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['clients'] != null) {
      clients = <Clients>[];
      json['clients'].forEach((v) {
        clients!.add(new Clients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.clients != null) {
      data['clients'] = this.clients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clients {
  String? sId;
  String? name;
  String? logo;

  Clients({this.sId, this.name, this.logo});

  Clients.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}
