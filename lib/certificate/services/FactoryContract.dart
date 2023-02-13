// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/src/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import '../../main.dart';
import '../model/certificate_model.dart';

class FactoryContract extends ChangeNotifier {
  //192.168.1.4

  //final String _networkUrl = "HTTP://192.168.1.7:7545";
  //final String _networkSocketUrl = "wss://127.0.0.1:7545";
  final String _networkUrl = "https://data-seed-prebsc-1-s1.binance.org:8545/";
  final String _networkSocketUrl =
      "wss://data-seed-prebsc-1-s1.binance.org:8545/";

  // final String _myAccountPrivateKey ="2e570ae3aed78a77ceb5ce32df1472e60d64d65f1484c8ee0563458a3babfbfe"; //0xa720ee5b6fc85ac3fc7438ca611af88284e94113
//0x67b6C984e747cFF6Dc67174edCbBdC79e0B72883
  bool isLoading = true;
  bool isAddingLoading = false;
  Web3Client? _client;

  String? _abiCode;
  EthereumAddress? _contractAddress;

  Credentials? _credentials;
  EthereumAddress? ownAddress;
  double myBalance = 0;

  DeployedContract? _contract;

  ContractFunction? _shopNameFunction;
  ContractFunction? _shopProductCountFunction;
  ContractFunction? _shopProducts;
  ContractFunction? _createShopProduct;

  late String shopNameDeplyed = "";
  String shopProductCount = "0";
  List<CertificateModel> products = [];
  List<CertificateModel> userCategoryCertificatesList = [];

  List<CertificateModel> singleProduct = [];

  int productCount = 0;
  int productUserCount = 0;
  String prefsPrivateKey = "";

  int CHAIN_ID = 97;

  FactoryContract() {
    initialSetup();
  }

  // Future <void>initialSetup() async {
  //   _client = Web3Client(_networkUrl,  Client());
  //
  //   await getAbi();
  //   await getCredentials();
  //   await getDeployedContract();
  //
  // }

  Future<void> initialSetup() async {
    // ignore: unnecessary_cast
    _client = Web3Client(_networkUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_networkSocketUrl).cast<String>();
    });

    await getAbi();
    await getDeployedContract();
  }

  //Get the abi from local file
  Future<void> getAbi() async {
    String abiStringFUllFile =
        await rootBundle.loadString("assets/src/abis/Certificates.json");

    var jsonAbi = jsonDecode(abiStringFUllFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    //Get the dynmic address with 5777 network
    var contractAddress = "0xc2fd2657d311000033fb299f3f7326c6fdfb55d3";
    _contractAddress = EthereumAddress.fromHex(contractAddress);
  }

  savePrivateKey(String newPrivateKey) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (newPrivateKey != ""){
      prefs.setString('privateKey', newPrivateKey);
      prefsPrivateKey = prefs.getString("privateKey")!;
      getCredentials("Education");
      getFilteredUserProducts("Education");
      notifyListeners();
    } else {}
  }

  resetPrivateKey() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('privateKey', "");
       prefsPrivateKey = prefs.getString("privateKey")!;
      notifyListeners();
  }

  Future<void> getCredentials(String category) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var prKey = prefs.getString("privateKey");

    if (prKey != null || prKey !='') {
      try {
        _credentials = await _client!.credentialsFromPrivateKey(prKey);
        ownAddress = await _credentials!.extractAddress();
        // You can now call rpc methods. This one will query the amount of Ether you own
        EtherAmount balance = await _client!.getBalance(ownAddress!);

        myBalance = balance.getValueInUnit(EtherUnit.ether);
        isLoading = false;
        getFilteredUserProducts(category);
      } catch (err) {
        notifyListeners();
        isLoading = false;
      }
    } else {}
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "Certificates"), _contractAddress!);

    _shopNameFunction = _contract!.function("syatemName");
    _createShopProduct = _contract!.function("createCertificate");
    _shopProductCountFunction = _contract!.function("count");

    _shopProducts = _contract!.function("getMyItemCreated");

    //Call teh function the return the name
    getShopName();
    getShopProductCount();
    getCredentials("Education");
  }

  getShopName() async {
    try {
      List<dynamic> currentName = await _client!
          .call(contract: _contract!, function: _shopNameFunction!, params: []);
      shopNameDeplyed = currentName[0];
      isLoading = false;
      // ignore: empty_catches
    } catch (e) {}

    notifyListeners();
  }

  getShopProductCount() async {
    try {
      List<dynamic> currentShopCount = await _client!.call(
          contract: _contract!,
          function: _shopProductCountFunction!,
          params: []);
      shopProductCount = currentShopCount[0].toString();
      isLoading = false;

    } catch (e) {}

    notifyListeners();
  }

  getSingleProducts(int certificateId) async {
    List currentShopCount = await _client!.call(
        contract: _contract!, function: _shopProductCountFunction!, params: []);
    BigInt totalShopProduct = currentShopCount[0];
    productCount = totalShopProduct.toInt();
    singleProduct.clear();
    var shopProducts = await _client!.call(
        contract: _contract!,
        function: _shopProducts!,
        params: [BigInt.from(certificateId)]);
    singleProduct.add(CertificateModel(
        id: shopProducts[0],
        name: shopProducts[1],
        urlSite: shopProducts[2],
        category: shopProducts[3],
        image: shopProducts[4],
        owner: shopProducts[6],
        date: shopProducts[7]));
    isLoading = false;
    notifyListeners();
  }

  Future<List<CertificateModel>?> getFilteredUserProducts(String categoryName) async {
    try {
      List currentShopCount = await _client!.call(
          contract: _contract!,
          function: _shopProductCountFunction!,
          params: [],
          sender: ownAddress);
      BigInt totalShopProduct = currentShopCount[0];
      productUserCount = totalShopProduct.toInt();
      userCategoryCertificatesList.clear();
      var shopProducts = await _client!.call(
          contract: _contract!,
          function: _shopProducts!,
          params: [],
          sender: ownAddress);

      var allItems = shopProducts[0];

      allItems.forEach((singleItem) {
        if (singleItem[3] == categoryName) {
          userCategoryCertificatesList.add(CertificateModel(
              id: singleItem[0],
              name: singleItem[1],
              urlSite: singleItem[2],
              category: singleItem[3],
              image: singleItem[4],
              owner: singleItem[5],
              date: singleItem[6]));
        }
      });
    } catch (e) {
      return null;
    }
    return userCategoryCertificatesList;
  }

  addCertificate(String productName, String urlSite, String image, String category, String date) async {
    try {
      if (image != "") {
        setLoading(true);
        await _client!
            .sendTransaction(
                _credentials!,
                Transaction.callContract(
                    contract: _contract!,
                    function: _createShopProduct!,
                    parameters: [productName, urlSite, image, category, date]),
                chainId: CHAIN_ID)
            .then((value) => {
                  debugPrint(value),
                });

        Future.delayed(const Duration(seconds: 2), () {
          setLoading(false);
          setMessage("Check your account to see your Certificate after minute");
        });
      } else {
        return {
          "message": "The Product should Have NFt Image,Please select image"
        };
      }
    } catch (erre) {
      setLoading(false);
    }
  }

  setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  setAddingLoading(bool val) {
    isAddingLoading = val;
    notifyListeners();
  }

  void setMessage(value) {
    Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
    );
    notifyListeners();
  }

  int selectedEducationIndex = -1;

  setSelectEducation(int i) {
    selectedEducationIndex = i;
    notifyListeners();
  }
}


 