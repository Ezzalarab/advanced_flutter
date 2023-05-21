import '../data/constants.dart';
import '../data/responses/responses.dart';
import '../domain/entities/contacts.dart';
import '../domain/entities/customer.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return DataConstants.empty;
    } else {
      return this ?? DataConstants.empty;
    }
  }
}

extension NonNullInt on int? {
  int orZero() {
    if (this == null) {
      return DataConstants.zero;
    } else {
      return this ?? DataConstants.zero;
    }
  }
}

extension NonNullCustomer on CustomerResponse? {
  Customer orEmpty() {
    if (this == null) {
      return Customer(
        id: DataConstants.empty,
        name: DataConstants.empty,
        notificationsCount: DataConstants.zero,
      );
    } else {
      return Customer(
        id: this!.id ?? DataConstants.empty,
        name: this!.name ?? DataConstants.empty,
        notificationsCount: this!.notificationsCount ?? DataConstants.zero,
      );
    }
  }
}

extension NonNullContacts on ContactsResponse? {
  Contacts orEmpty() {
    if (this == null) {
      return Contacts(
        phone: DataConstants.empty,
        email: DataConstants.empty,
        website: DataConstants.empty,
      );
    } else {
      return Contacts(
        phone: this!.phone ?? DataConstants.empty,
        email: this!.email ?? DataConstants.empty,
        website: this!.website ?? DataConstants.empty,
      );
    }
  }
}
