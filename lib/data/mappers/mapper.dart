import '../../app/extensions.dart';
import '../../domain/entities/auth.dart';
import '../../domain/entities/contacts.dart';
import '../../domain/entities/customer.dart';
import '../constants.dart';
import '../responses/responses.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    if (this == null) {
      return Customer(
        id: DataConstants.empty,
        name: DataConstants.empty,
        notificationsCount: DataConstants.zero,
      );
    } else {
      return Customer(
        id: this!.id.orEmpty(),
        name: this!.name.orEmpty(),
        notificationsCount: this!.notificationsCount.orZero(),
      );
    }
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    if (this == null) {
      return Contacts(
        phone: DataConstants.empty,
        email: DataConstants.empty,
        website: DataConstants.empty,
      );
    } else {
      return Contacts(
        phone: this!.phone.orEmpty(),
        email: this!.email.orEmpty(),
        website: this!.website.orEmpty(),
      );
    }
  }
}

extension AuthResponseMapper on AuthResponse? {
  Auth toDomain() {
    if (this == null) {
      return Auth(
        customer: Customer(
          id: DataConstants.empty,
          name: DataConstants.empty,
          notificationsCount: 0,
        ),
        contacts: Contacts(
          phone: DataConstants.empty,
          email: DataConstants.empty,
          website: DataConstants.empty,
        ),
      );
    } else {
      return Auth(
        customer: this!.customerResponse.orEmpty(),
        contacts: this!.contactsResponse.orEmpty(),
      );
    }
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse {
  String toDomain() {
    if (supportMessage == null) {
      return DataConstants.empty;
    } else {
      return supportMessage!;
    }
  }
}
