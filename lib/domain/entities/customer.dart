// ignore_for_file: public_member_api_docs, sort_constructors_first

class Customer {
  String id;
  String name;
  int notificationsCount;
  Customer({
    required this.id,
    required this.name,
    required this.notificationsCount,
  });

  // static Customer fromResponse(CustomerResponse customerResponse) {
  //   return Customer(
  //     id: customerResponse.id!,
  //     name: customerResponse.name!,
  //     notificationsCount: customerResponse.notificationsCount!,
  //   );
  // }
}
