import 'package:flutter/material.dart';
import 'package:newproject/Helpers/DatabaseHelper.dart';
import 'package:newproject/sqlDatabase/ViewProduct.dart';

class UpdateProduct extends StatefulWidget {
  var proid;


  UpdateProduct({this.proid});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {


  TextEditingController pdname = TextEditingController();
  TextEditingController pdprice = TextEditingController();
  TextEditingController pdqulity = TextEditingController();
  GetSingleProductData()async
  {
    DatabaseHelper obj = DatabaseHelper();
    var data = await obj.getSigleData(widget.proid);
    print(data);
   setState(() {
     pdname.text = data[0]["pname"].toString();
     pdprice.text = data[0]["pprice"].toString();
     pdqulity.text = data[0]["pqty"].toString();

   });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetSingleProductData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UpdateProduct"),
      ),
      body:Column(
          children: [
            SizedBox(height: 10,),
            TextField(
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
            TextField(
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
            TextField(
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


              var nm = pdname.text.toString();
              var pr = pdprice.text.toString();
              var qty = pdqulity.text.toString();

            DatabaseHelper obj = new DatabaseHelper();
            var status = await obj.updateData(widget.proid,nm,pr,qty);
            if(status==1)
              {
                print("Success Update");
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewProduct()));
              }
            else
              {
                print("Error " + status.toString());
              }


            }, child: Text("OK")),
          ],
        ),

    );
  }
}
