class Holder {
  final String id;
  final String name;
  final String email;
  final String phone;

  Holder({
    required this.id,
    required this.name,
    this.email = "",
    this.phone = "",
  });
}
