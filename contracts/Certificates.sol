// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Certificates{

  string public syatemName ;
  uint public count = 0;

  constructor() {
    syatemName = "Certificates System";

  }

  struct Certificate {
    uint id;
    string name;
    string urlSite;
    string category;
    string image;
    address  payable owner;
    string date;
  }

  event CreateCertificate (
    uint id,
    string name,
    string urlSite,
    string category,
    string image,
    address  payable owner,
    string date
  );




  mapping (uint =>Certificate) private shopCertificates;

  modifier onlOwner(uint256 id) {
    require(
      shopCertificates[id].owner != address(0) &&
      shopCertificates[id].owner == msg.sender, "Only the owner  can do this operation"
    );
    _;
  }

  function createCertificate(string  memory name, string memory urlSite, string memory image,string memory category, string  memory date) public {

    require(bytes(name).length > 0,"Your Name Is empty");
    require(bytes(urlSite).length > 0,"Your urlSite Is empty");
    require(bytes(image).length > 0,"Your image Is empty");

    require(bytes(category).length > 0,"Your category Is empty");

    count++;
    shopCertificates[count]=Certificate(count,name,urlSite,category,image,payable (msg.sender),date);

    emit CreateCertificate(count,name,urlSite,category,image,payable (msg.sender),date);


  }

  ///FETCH SINGLE JOB WITH VALIDATIONS
  function fetchSingleItem(uint256 id)  public   onlOwner(id) view returns (Certificate memory)    {
    return shopCertificates[id];
  }

  function getMyItemCreated() public view returns(Certificate[] memory){

    //    require(Certificate.owner == msg.sender,"only owner can get his cerifates");

    uint256 totalItemCount = count;
    uint myItemCount=0;//10
    uint myCurrentIndex =0;

    for(uint i = 0;i<totalItemCount;i++){
      if(shopCertificates[i+1].owner == msg.sender){
        myItemCount+=1;

      }
    }
    Certificate [] memory certificatetems = new Certificate[](myItemCount); //list[3]
    for(uint i = 0;i<totalItemCount;i++){
      if(shopCertificates[i+1].owner==msg.sender){      //[1,2,3,4,5]
        uint currentId = i+1;
        Certificate storage  currentItem = shopCertificates[currentId];
        certificatetems[myCurrentIndex] = currentItem;
        myCurrentIndex +=1;

      }
    }


    return certificatetems;

  }


}

