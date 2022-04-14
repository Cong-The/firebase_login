class TheUser {
  final String uid;
  TheUser({required this.uid});
}

class TheUserData {
  final String uid, name, sugars;
  final int strength;
  TheUserData(
      {required this.sugars,
      required this.strength,
      required this.uid,
      required this.name});
}
