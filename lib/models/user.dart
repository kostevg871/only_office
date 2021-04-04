import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.status,
    this.response,
  });

  int status;
  Response response;

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response.toJson(),
      };
}

class Response {
  Response({
    this.id,
    this.userName,
    this.isVisitor,
    this.firstName,
    this.lastName,
    this.email,
    this.birthday,
    this.sex,
    this.status,
    this.activationStatus,
    this.terminated,
    this.department,
    this.workFrom,
    this.location,
    this.notes,
    this.displayName,
    this.title,
    this.contacts,
    this.groups,
    this.avatarMedium,
    this.avatar,
    this.isAdmin,
    this.isLdap,
    this.listAdminModules,
    this.isOwner,
    this.cultureName,
    this.isSso,
    this.avatarSmall,
    this.profileUrl,
  });

  String id;
  String userName;
  bool isVisitor;
  String firstName;
  String lastName;
  String email;
  DateTime birthday;
  String sex;
  int status;
  int activationStatus;
  dynamic terminated;
  String department;
  DateTime workFrom;
  String location;
  String notes;
  dynamic displayName;
  String title;
  List<Contact> contacts;
  List<Group> groups;
  String avatarMedium;
  String avatar;
  bool isAdmin;
  bool isLdap;
  List<String> listAdminModules;
  bool isOwner;
  String cultureName;
  bool isSso;
  String avatarSmall;
  String profileUrl;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        userName: json["userName"],
        isVisitor: json["isVisitor"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        sex: json["sex"],
        status: json["status"],
        activationStatus: json["activationStatus"],
        terminated: json["terminated"],
        department: json["department"],
        workFrom:
            json["workFrom"] == null ? null : DateTime.parse(json["workFrom"]),
        location: json["location"],
        notes: json["notes"],
        displayName: json["displayName"],
        title: json["title"],
        // contacts: List<Contact>.from(
        //     json["contacts"].map((x) => Contact.fromJson(x))),
        // groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
        avatarMedium: json["avatarMedium"],
        avatar: json["avatar"],
        isAdmin: json["isAdmin"],
        isLdap: json["isLDAP"],
        // listAdminModules:
        //     List<String>.from(json["listAdminModules"].map((x) => x)),
        isOwner: json["isOwner"],
        cultureName: json["cultureName"],
        isSso: json["isSSO"],
        avatarSmall: json["avatarSmall"],
        profileUrl: json["profileUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "isVisitor": isVisitor,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "birthday": birthday.toIso8601String(),
        "sex": sex,
        "status": status,
        "activationStatus": activationStatus,
        "terminated": terminated,
        "department": department,
        "workFrom": workFrom.toIso8601String(),
        "location": location,
        "notes": notes,
        "displayName": displayName,
        "title": title,
        // "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
        // "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
        "avatarMedium": avatarMedium,
        "avatar": avatar,
        "isAdmin": isAdmin,
        "isLDAP": isLdap,
        // "listAdminModules": List<dynamic>.from(listAdminModules.map((x) => x)),
        "isOwner": isOwner,
        "cultureName": cultureName,
        "isSSO": isSso,
        "avatarSmall": avatarSmall,
        "profileUrl": profileUrl,
      };
}

class Contact {
  Contact({
    this.type,
    this.value,
  });

  String type;
  String value;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}

class Group {
  Group({
    this.id,
    this.name,
    this.manager,
  });

  String id;
  String name;
  String manager;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        manager: json["manager"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "manager": manager,
      };
}
