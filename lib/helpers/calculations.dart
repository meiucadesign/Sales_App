class Calculations {
  static int calcDiscount(int price, int discount) {
    return (price * discount) ~/ 100;
  }

  static int priceAfterDiscount(int price, int discount) {
    return price - calcDiscount(price, discount);
  }
}
