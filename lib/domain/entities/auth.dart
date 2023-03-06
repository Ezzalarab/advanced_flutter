// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advanced_flutter/data/responses/responses.dart';

import 'contacts.dart';
import 'customer.dart';

class Auth {
  Customer? customer;
  Contacts? contacts;
  Auth({
    this.customer,
    this.contacts,
  });

  // static Auth fromResponse(AuthResponse authResponse) {
  //   return Auth(
  //     customer: Customer.fromResponse(authResponse.customerResponse!),
  //     contacts: Contacts.fromResponse(authResponse.contactsResponse!),
  //   );
  // }
}
