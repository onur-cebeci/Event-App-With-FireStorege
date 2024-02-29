class UserModel {
  final String name;
  final String surname;
  final String mail;
  final String img;
  final String birthDay;
  final String address;
  final String city;
  final String phone;
  final bool isAdmin;

  UserModel({
    required this.name,
    required this.surname,
    required this.mail,
    required this.birthDay,
    required this.city,
    required this.img,
    required this.address,
    required this.phone,
    required this.isAdmin,
  });
}
