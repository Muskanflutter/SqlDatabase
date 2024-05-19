import 'package:flutter/material.dart';
import 'package:newproject/Helpers/DatabaseHelper.dart';
import 'package:newproject/sqlDatabase/UpdateProduct.dart';
import 'package:newproject/sqlDatabase/ViewProduct.dart';

class InsertProduct extends StatefulWidget {
  const InsertProduct({super.key});

  @override
  State<InsertProduct> createState() => _InsertProduct();
}

class _InsertProduct extends State<InsertProduct> {

  var formkey = GlobalKey<FormState>();
  TextEditingController pdname = TextEditingController();
  TextEditingController pdprice = TextEditingController();
  TextEditingController pdqulity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InsertProduct"),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextFormField(
              controller: pdname,
              decoration: InputDecoration(
                labelText: "Product Name:",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: pdprice,
              decoration: InputDecoration(
                labelText: "Product Price:",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: pdqulity,
              decoration: InputDecoration(
                labelText: "Product qulity:",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            ElevatedButton(onPressed: () async {
              var prnm  = pdname.text.toString();
              var prpc = pdprice.text.toString();
              var prqu = pdqulity.text.toString();

              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>ViewProduct()),
              );

              DatabaseHelper obj = new DatabaseHelper();
             int result = await obj.insertData(prnm,prpc,prqu);
             print(result.toString());


            }, child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}
