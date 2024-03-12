class Holder {
  final String id;
  String name;
  String email;
  String phone;
  bool isAdmin;

  Holder({
    required this.id,
    required this.name,
    required this.isAdmin,
    this.email = "",
    this.phone = "",
  });
}
