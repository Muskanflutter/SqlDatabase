import 'package:flutter/material.dart';
import 'package:newproject/Basictopic/Alert_Dialog.dart';
import 'package:newproject/Helpers/DatabaseHelper.dart';
import 'package:newproject/sqlDatabase/InsertProduct.dart';
import 'package:newproject/sqlDatabase/UpdateProduct.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
   Future<List>? data;
  getProduct() async
  {
    DatabaseHelper obj = DatabaseHelper();
    setState(()  {
      data =  obj.getData();
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ViewProduct"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InsertProduct()));
        },
        child: Icon(Icons.add),
      ),
      body:FutureBuilder(
        future: data,
        builder: (context,snapsort)
        {
          if(snapsort.hasData)
            {
              if(snapsort.data!.length <= 0){
                return Text("no data");
              }
              else
              {
                return ListView.builder(
                    itemCount: snapsort.data!.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(snapsort.data![index]["pid"].toString()),
                        ),
                        title: Text(snapsort.data![index]['pname'].toString()),
                        subtitle:Row(children: [Text(snapsort.data![index]['pprice']),Text(snapsort.data![index]['pqty'])],) ,
                        trailing: Wrap(
                          spacing: 12,
                          children: [
                            IconButton(onPressed: (){

                              AlertDialog alert = AlertDialog(
                                title: Text("Are you sure to data delete"),
                                content: Text("data delete to content"),
                                actions: [
                                  ElevatedButton(onPressed: () async {

                                    var proid = snapsort.data![index]["pid"].toString();
                                    DatabaseHelper obj = new DatabaseHelper();
                                    var delstatus  = await obj.deleteData(proid);
                                 if(delstatus==1) {
                                   Navigator.of(context).pop();
                                   getProduct();
                                 }
                                 else
                                   {
                                     print("error delete");
                                   }
                                  }, child: Text("yes")),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("no")),
                                ],
                              );
                              showDialog(
                                  context: (context),
                                  builder: (context) {
                                    return alert;
                                  });
                            }, icon: Icon(Icons.delete)),
                            IconButton(onPressed: (){

                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>UpdateProduct(proid:snapsort.data![index]['pid'].toString(),
                                )),
                              );

                            }, icon: Icon(Icons.update)),
                          ],
                        ),
                      );
                    });
              }
            }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
