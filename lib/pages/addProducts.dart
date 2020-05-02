import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_proj/pages/db_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File FirstImage;
  File SecondImage;
  File ThirdImage;

  TextEditingController ProdName = TextEditingController();
  TextEditingController ProdCat = TextEditingController();
  TextEditingController ProdPrice = TextEditingController();
  TextEditingController ProdDesc = TextEditingController();
//  links db_products class to this file
  ProductService productService=ProductService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        elevation: 4,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text("Add product", style: TextStyle(color: Colors.black),),
      ),

      body: Form (
        key: _formKey,
        child: SingleChildScrollView(

          child: Column(

            children: <Widget> [

            Row (

                children: <Widget>[

                  Expanded (
                    child: RaisedButton(
                      onPressed: () async {
                        _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), FirstImage);
                      },

                      child: 
                      _displayChild1(FirstImage),
                      
                    ),
                  ),

                  Expanded (
                    child: RaisedButton(
                      onPressed: () async {
                        _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), SecondImage);
                      },

                      child:
                        _displayChild1(SecondImage)
                        
                    ),
                  ),

                  Expanded (
                    child: RaisedButton(
                      onPressed: () async {
                        _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), ThirdImage);
                      },

                      child: 
                        _displayChild1(ThirdImage)
                    ),
                  )

                ],
              ),

               Padding (
                  padding: const EdgeInsets.all(8.0),
                ),

              Padding (
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: ProdName,
                    decoration: InputDecoration(
                      labelText: "Product Name",
                      hintText: 'Product Name'
                    ),
                  )
                ),



              Padding (
                  padding: const EdgeInsets.all(8.0),
                ),

              Padding (
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: ProdCat,
                    decoration: InputDecoration(
                      labelText: "Category",
                      hintText: 'Category'
                    ),
                  )
                ),


              Padding (
                  padding: const EdgeInsets.all(8.0),
                ),

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


                OutlineButton(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
                  color: Colors.black,
                  textColor: Colors.black,
                  child: Text('Add product to inventory'),
                  onPressed: () {
                      validateAndUpload();
                  },

                )




            ]

          ),
        ),
      ),
    );
  }



void _selectImage(Future<File> pickImage, File Image2Fill) async{
    File tempImg = await pickImage;
    setState(() => Image2Fill = tempImg);
  }



  
//  display the child
  Widget _displayChild1(File Image2show) {
    if(FirstImage == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: Colors.grey,),
      );
    }else{
      return Image.file(Image2show, fit: BoxFit.fill, width: double.infinity,);
    }
  }


  void validateAndUpload() async{
    if(_formKey.currentState.validate()){
      if(FirstImage != null && SecondImage != null && ThirdImage != null){
//        this code snippet uploads images in the storage
          String imageUrl1;
          String imageUrl2;
          String imageUrl3;
          final FirebaseStorage storage= FirebaseStorage.instance;
          final  String pic1="1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1= storage.ref().child(pic1).putFile(FirstImage);
          final  String pic2="2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task2= storage.ref().child(pic1).putFile(SecondImage);
          final  String pic3="3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task3= storage.ref().child(pic1).putFile(ThirdImage);

          StorageTaskSnapshot snapshot1= await task1.onComplete.then((snapshot)=>snapshot);
          StorageTaskSnapshot snapshot2= await task2.onComplete.then((snapshot)=>snapshot);

          task3.onComplete.then((snapshot3) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            imageUrl2 = await snapshot2.ref.getDownloadURL();
            imageUrl3 = await snapshot3.ref.getDownloadURL();
//            list of images we'll upload

            List <String> imageList= [imageUrl1,imageUrl2,imageUrl3];

//            now well call the function to upload the products
//            inside the function arguments pass the product information
        ProductService().uploadProducts(ProdName.text, imageList, ProdCat.text, ProdPrice.text, ProdDesc.text);
          });

      }else{
        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }
}

