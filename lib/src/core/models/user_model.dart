import 'dart:convert';

class UserDetail {
  final String uid;
  final String name;
  final String email;
  final String dob;
  final String contact;
  final String photoURL;
  UserDetail({
    this.uid,
    this.name,
    this.email,
    this.dob,
    this.contact,
    this.photoURL,
  });

  UserDetail copyWith({
    String uid,
    String name,
    String email,
    String dob,
    String contact,
    String photoURL,
  }) {
    return UserDetail(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      contact: contact ?? this.contact,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'dob': dob,
      'contact': contact,
      'photoURL': photoURL,
    };
  }

  factory UserDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserDetail(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      dob: map['dob'],
      contact: map['contact'],
      photoURL: map['photoURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetail.fromJson(String source) =>
      UserDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDetail(uid: $uid, name: $name, email: $email, dob: $dob, contact: $contact, photoURL: $photoURL)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserDetail &&
        o.uid == uid &&
        o.name == name &&
        o.email == email &&
        o.dob == dob &&
        o.contact == contact &&
        o.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        dob.hashCode ^
        contact.hashCode ^
        photoURL.hashCode;
  }
}
