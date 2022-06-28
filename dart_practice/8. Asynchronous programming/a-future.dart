Future<void> fetchUserOrder() {
  print('Fetching user order...');
  // Imagine that this function is fetching user info from another service or database.
  return Future.delayed(const Duration(seconds: 2), () => print('Large Latte'));
}

void main() {
  print('init');
  fetchUserOrder();
  print('end');
}
