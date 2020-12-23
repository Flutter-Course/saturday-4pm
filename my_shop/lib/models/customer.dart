import 'package:my_shop/models/user.dart';
import 'package:my_shop/models/vendor.dart';

class Customer extends User {
  Customer.formFirestore(userId, document)
      : super.fromFirestore(userId, document);

  Customer.fromVendor(Vendor vendor) : super.fromUser(vendor);
  Future<void> init() async {}
}
