Future<void> fetchUserOrder() {
  print('Fetching user order...');
  // Imagine that this function is fetching user info from another service or database.
  return Future.delayed(const Duration(seconds: 2), () => print('Large Latte'));
}

// Future<void> fetchSomething() async {
//   print('1');
//
//   // await Future.delayed(const Duration(seconds: 2));
//   //
//   // print('2');
// }

Future<void> main() async {
  print('init');
  fetchUserOrder();
  // fetchSomething();
  print('end');
}
