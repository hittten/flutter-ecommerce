Future<String> createOrderMessage() async {
  var order = await fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is
// more complex and slow.
Future.delayed(
  const Duration(seconds: 2),
      () => 'Large Latte',
);

void main() {
  print('init');
  print('Fetching user order...');
  print(createOrderMessage());
  // createOrderMessage().then((value) => print(value));
  print('end');
}
