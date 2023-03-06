// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advanced_flutter/data/responses/responses.dart';

class Contacts {
  String phone;
  String email;
  String website;
  Contacts({
    required this.phone,
    required this.email,
    required this.website,
  });

  // static Contacts fromResponse(ContactsResponse contactsResponse) {
  //   return Contacts(
  //     phone: contactsResponse.phone!,
  //     email: contactsResponse.email!,
  //     website: contactsResponse.website!,
  //   );
  // }
}
