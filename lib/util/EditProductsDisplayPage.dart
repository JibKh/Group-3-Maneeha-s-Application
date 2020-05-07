import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_proj/admin/db_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

var firestore=Firestore.instance;

class EditProductsDisplay extends StatefulWidget {
  @override
  final prodID;
  final name;
  final price;
  final stock;
  final desc;
  final allPictures;
  EditProductsDisplay({ this.prodID,this.name,this.price,this.stock,this.desc,this.allPictures});
  _EditProductsDisplayState createState() => _EditProductsDisplayState();
}
//    print(widget.prodID);
class _EditProductsDisplayState extends State<EditProductsDisplay> {
  File FirstImage;
  File SecondImage;
  File ThirdImage;

  Image img1;
  Image img2;
  Image img3;




//  document.get() => then(function(document) {
//  print(document('name'));
//  }
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    TextEditingController ProdName = TextEditingController(text: widget.name );
    TextEditingController ProdPrice = TextEditingController(text: widget.price);
    TextEditingController ProdDesc = TextEditingController(text:widget.desc);
    TextEditingController ProdQuantity = TextEditingController(text:widget.stock.toString());
//  links db_products class to this file
    ProductService productService=ProductService();
    return Scaffold (
      appBar: AppBar(
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Edit product", style: TextStyle(color: Colors.black),),
      ),

      body: Form (
        key: _formKey,
        child: SingleChildScrollView(

          child: Column(

              children: <Widget> [

                Row (
//=========================DISPLAYING BUTTONS TO UPLOAD IMAGES=======================
                  children: <Widget>[

                    Expanded (
                      child: RaisedButton(
                        onPressed: () async {
                          _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), 1);
                        },

                        child:
                        _displayChild1(FirstImage),

                      ),
                    ),

                    Expanded (
                      child: RaisedButton(
                          onPressed: () async {
                            _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), 2);
                          },

                          child:
                          _displayChild2(SecondImage)

                      ),
                    ),

                    Expanded (
                      child: RaisedButton(
                          onPressed: () async {
                            _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), 3);
                          },

                          child:
                          _displayChild3(ThirdImage)
                      ),
                    )

                  ],
                ),

                Padding (
                  padding: const EdgeInsets.all(8.0),
                ),
//=========================product name form================================
                Padding (
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: ProdName,
                      decoration: InputDecoration(
                          labelText: "Product Name",
                          hintText: 'Product Name',

                      ),
                    )
                ),



                Padding (
                  padding: const EdgeInsets.all(8.0),
                ),

// ==========================PRODUCT Quantity FORM========================================
                Padding (
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: ProdQuantity,
                      decoration: InputDecoration(
                          labelText: "Quantity",
                          hintText: 'Quantity'
                      ),
                    )
                ),

                Padding (
                  padding: const EdgeInsets.all(8.0),
                ),

//  ===========================PRICE FORM==============================================
                Padding (
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: ProdPrice,
                      decoration: InputDecoration(
                          labelText: "Price",
                          hintText: 'Price'
                      ),
                    )
                ),


                Padding (
                  padding: const EdgeInsets.all(8.0),
                ),

// ===============================DESCRIPTION FORM=================================
                Padding (
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: ProdDesc,
                      decoration: InputDecoration(
                          labelText: "Product Description",
                          hintText: 'Description'
                      ),
                    )
                ),

//========================HERE WE WILL ADD OUR PRODUCT
                OutlineButton(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
                  color: Colors.black,
                  textColor: Colors.black,
                  child: Text('Edit Product Info'),
                  onPressed: () {
                    validateAndUpload(ProdName.text, widget.prodID, widget.allPictures, ProdPrice.text,int.parse(ProdQuantity.text) , ProdDesc.text);
                  },

                )




              ]

          ),
        ),
      ),
    );
  }



  void _selectImage(Future<File> pickImage, int imgnum) async{
    File tempImg = await pickImage;
    switch(imgnum){
      case 1 : setState(() => FirstImage = tempImg);
      break;
      case 2 : setState(() => SecondImage = tempImg);
      break;
      case 3 : setState(() => ThirdImage = tempImg);
      break;
    }
    //setState(() => FirstImage = tempImg);
  }




//=========================  DISPLAYING IMAGES ========================================
  Widget _displayChild1(File Image2show) {
    if(FirstImage == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: Colors.black,),
      );
    }else{
      return
        Image.file(FirstImage, height: 200, width:200);
      //return Image.file(Image2show, fit: BoxFit.fill, width: double.infinity,);
    }
  }

  Widget _displayChild2(File Image2show) {
    if(SecondImage == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: Colors.grey,),
      );
    }else{
      return Image.file(SecondImage, height: 200, width: 200,);
      //return Image.file(Image2show, fit: BoxFit.fill, width: double.infinity,);
    }
  }

  Widget _displayChild3(File Image2show) {
    if(ThirdImage == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: Colors.grey,),
      );
    }else{
      return Image.file(Image2show, height: 200, width: 200);
    }
  }

  void validateAndUpload(name,  id, url, productPrice, ProdQuantity, productDesc) async{
    if(_formKey.currentState.validate()){
//      if(FirstImage != null && SecondImage != null && ThirdImage != null){
//        this code snippet uploads images in the storage
//      String imageUrl1;
//      String imageUrl2;
//      String imageUrl3;
//      var urls = new List();
//
//      final FirebaseStorage storage= FirebaseStorage.instance;
//      var uuid = Uuid();
//
//      final  String pic1= uuid.v4();
//      final ref = storage.ref().child(pic1);
//      StorageUploadTask task1= ref.putFile(FirstImage);
//      var storageTaskSnapshot = await task1.onComplete;
//      var downloadUrl1 = await storageTaskSnapshot.ref.getDownloadURL();
//      urls.add(downloadUrl1);
//
//      final  String pic2= uuid.v4();
//      final ref2 = storage.ref().child(pic2);
//      StorageUploadTask task2= ref2.putFile(SecondImage);
//      var storageTaskSnapshot2 = await task2.onComplete;
//      var downloadUrl2 = await storageTaskSnapshot2.ref.getDownloadURL();
//      urls.add(downloadUrl2);
//
//      final  String pic3= uuid.v4();
//      final ref3 = storage.ref().child(pic3);
//      StorageUploadTask task3= ref3.putFile(ThirdImage);
//      var storageTaskSnapshot3 = await task3.onComplete;
//      var downloadUrl3 = await storageTaskSnapshot3.ref.getDownloadURL();
//      urls.add(downloadUrl3);

      /*final  String pic2="2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task2= storage.ref().child(pic1).putFile(SecondImage);
          storageTaskSnapshot = await task2.onComplete;
          downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

          final  String pic3="3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task3= storage.ref().child(pic1).putFile(ThirdImage);*/

      //StorageTaskSnapshot snapshot1= await task1.onComplete.then((snapshot)=>snapshot);
      //StorageTaskSnapshot snapshot2= await task2.onComplete.then((snapshot)=>snapshot);

      /*task3.onComplete.then((snapshot3) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            imageUrl2 = await snapshot2.ref.getDownloadURL();
            imageUrl3 = await snapshot3.ref.getDownloadURL();*/
//            list of images we'll upload

      //List <String> imageList= [imageUrl1,imageUrl2,imageUrl3];

//            now well call the function to upload the products
//            inside the function arguments pass the product information
      ProductService().editProducts(name,  id, url, productPrice, ProdQuantity, productDesc);
    };
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text('Product info has been edited'),
          );
        });

    

//      }
//      else{
//        Fluttertoast.showToast(msg: 'all the images must be provided');
//      }
  }
}







