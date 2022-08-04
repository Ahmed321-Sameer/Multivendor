import 'package:multivendor/screens/user/widgets/cart.dart';

class Cart_Calculation {
  static List<String> price = ["200", "300"];
  List name = ["caasual shirt", "Tee shirt"];
  List qunatity = ["2", "1"];
  Delete_Calculation(useenteredtshirt) {
    for (int i = 0; i < name.length; i++) {
      if (useenteredtshirt == name[i]) {
        name.removeAt(i);
        price.removeAt(i);
        qunatity[i] = qunatity[i] + 1;
      }
    }
  }

  Update_Calculation(useenteredtshirt) {
    for (int i = 0; i < name.length; i++) {
      if (useenteredtshirt == name[i]) {
        name.removeAt(i);
        price.removeAt(i);
        qunatity[i] = qunatity[i] + 1;
      }
    }
  }

  Future<bool> checkproduct(
    productname,
  ) {
    for (int i = 0; i < cart.Product_name.length; i++) {
      if (productname == cart.Product_name[i]) {
        return Future.value(true);
      }
    }
    return Future.value(false);
  }
}
