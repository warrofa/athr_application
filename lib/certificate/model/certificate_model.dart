import 'package:web3dart/credentials.dart';

class CertificateModel {
  late BigInt id;
  late String name;
  late String urlSite;
  late String category;
  late String image;

  late EthereumAddress owner;
  late String date;


  CertificateModel(
      {required this.id,
      required this.name,
      required this.urlSite,
      required this.category,
      required this.image,
      required this.owner,
      required this.date});
}

