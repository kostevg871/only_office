// To parse this JSON data, do
//
//     final documents = documentsFromJson(jsonString);

import 'dart:convert';

Documents documentsFromJson(String str) => Documents.fromJson(json.decode(str));

String documentsToJson(Documents data) => json.encode(data.toJson());

class Documents {
  Documents({
    this.status,
    this.response,
  });

  int status;
  Response response;

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
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
    this.files,
    this.folders,
    this.current,
  });

  List<FileElement> files;
  List<Current> folders;
  Current current;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
        folders:
            List<Current>.from(json["folders"].map((x) => Current.fromJson(x))),
        current: Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "folders": List<dynamic>.from(folders.map((x) => x.toJson())),
        "current": current.toJson(),
      };
}

class Current {
  Current({
    this.parentId,
    this.filesCount,
    this.foldersCount,
    this.id,
    this.title,
    this.access,
    this.shared,
    this.rootFolderType,
    this.updatedBy,
    this.created,
    this.createdBy,
    this.updated,
  });

  int parentId;
  int filesCount;
  int foldersCount;
  int id;
  String title;
  int access;
  bool shared;
  int rootFolderType;
  AtedBy updatedBy;
  DateTime created;
  AtedBy createdBy;
  DateTime updated;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        parentId: json["parentId"],
        filesCount: json["filesCount"],
        foldersCount: json["foldersCount"],
        id: json["id"],
        title: json["title"],
        access: json["access"],
        shared: json["shared"],
        rootFolderType: json["rootFolderType"],
        updatedBy: AtedBy.fromJson(json["updatedBy"]),
        created: DateTime.parse(json["created"]),
        createdBy: AtedBy.fromJson(json["createdBy"]),
        updated: DateTime.parse(json["updated"]),
      );

  Map<String, dynamic> toJson() => {
        "parentId": parentId,
        "filesCount": filesCount,
        "foldersCount": foldersCount,
        "id": id,
        "title": title,
        "access": access,
        "shared": shared,
        "rootFolderType": rootFolderType,
        "updatedBy": updatedBy.toJson(),
        "created": created.toIso8601String(),
        "createdBy": createdBy.toJson(),
        "updated": updated.toIso8601String(),
      };
}

class AtedBy {
  AtedBy({
    this.id,
    this.displayName,
    this.title,
    this.avatarSmall,
    this.profileUrl,
  });

  String id;
  DisplayName displayName;
  Title title;
  AvatarSmall avatarSmall;
  String profileUrl;

  factory AtedBy.fromJson(Map<String, dynamic> json) => AtedBy(
        id: json["id"],
        displayName: displayNameValues.map[json["displayName"]],
        title: titleValues.map[json["title"]],
        avatarSmall: avatarSmallValues.map[json["avatarSmall"]],
        profileUrl: json["profileUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayNameValues.reverse[displayName],
        "title": titleValues.reverse[title],
        "avatarSmall": avatarSmallValues.reverse[avatarSmall],
        "profileUrl": profileUrl,
      };
}

enum AvatarSmall { URL_TO_SMALL_AVATAR }

final avatarSmallValues =
    EnumValues({"url to small avatar": AvatarSmall.URL_TO_SMALL_AVATAR});

enum DisplayName { MIKE_ZANYATSKI }

final displayNameValues =
    EnumValues({"Mike Zanyatski": DisplayName.MIKE_ZANYATSKI});

enum Title { MANAGER }

final titleValues = EnumValues({"Manager": Title.MANAGER});

class FileElement {
  FileElement({
    this.folderId,
    this.version,
    this.versionGroup,
    this.contentLength,
    this.pureContentLength,
    this.fileStatus,
    this.viewUrl,
    this.fileType,
    this.fileExst,
    this.comment,
    this.id,
    this.title,
    this.access,
    this.shared,
    this.rootFolderType,
    this.updatedBy,
    this.created,
    this.createdBy,
    this.updated,
  });

  int folderId;
  int version;
  int versionGroup;
  String contentLength;
  int pureContentLength;
  int fileStatus;
  String viewUrl;
  int fileType;
  String fileExst;
  dynamic comment;
  int id;
  String title;
  int access;
  bool shared;
  int rootFolderType;
  AtedBy updatedBy;
  DateTime created;
  AtedBy createdBy;
  DateTime updated;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        folderId: json["folderId"],
        version: json["version"],
        versionGroup: json["versionGroup"],
        contentLength: json["contentLength"],
        pureContentLength: json["pureContentLength"],
        fileStatus: json["fileStatus"],
        viewUrl: json["viewUrl"],
        fileType: json["fileType"],
        fileExst: json["fileExst"],
        comment: json["comment"],
        id: json["id"],
        title: json["title"],
        access: json["access"],
        shared: json["shared"],
        rootFolderType: json["rootFolderType"],
        updatedBy: AtedBy.fromJson(json["updatedBy"]),
        created: DateTime.parse(json["created"]),
        createdBy: AtedBy.fromJson(json["createdBy"]),
        updated: DateTime.parse(json["updated"]),
      );

  Map<String, dynamic> toJson() => {
        "folderId": folderId,
        "version": version,
        "versionGroup": versionGroup,
        "contentLength": contentLength,
        "pureContentLength": pureContentLength,
        "fileStatus": fileStatus,
        "viewUrl": viewUrl,
        "fileType": fileType,
        "fileExst": fileExst,
        "comment": comment,
        "id": id,
        "title": title,
        "access": access,
        "shared": shared,
        "rootFolderType": rootFolderType,
        "updatedBy": updatedBy.toJson(),
        "created": created.toIso8601String(),
        "createdBy": createdBy.toJson(),
        "updated": updated.toIso8601String(),
      };
}

class PathPart {
  PathPart({
    this.key,
    this.path,
  });

  String key;
  String path;

  factory PathPart.fromJson(Map<String, dynamic> json) => PathPart(
        key: json["key"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "path": path,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
