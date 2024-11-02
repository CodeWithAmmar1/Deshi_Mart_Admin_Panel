import 'package:admin/textfeild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

bool isloading = false;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class _CategoryItemState extends State<CategoryItem> {
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController image = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: AppBar(
            backgroundColor: Colors.green.shade400,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Add Item",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Group 34 (1).png"),
                  opacity: 0.3,
                  fit: BoxFit.contain)),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.green.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Add Product Detail",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Textfeild(
                        text: "Enter Name",
                        controller: title,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Textfeild(
                        text: "Enter Price",
                        controller: price,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Textfeild(
                        text: "Enter Weight",
                        controller: weight,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Textfeild(
                        text: "Enter Quantity",
                        controller: quantity,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Textfeild(
                        text: "Enter ImageUrl",
                        controller: image,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            child: isloading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      if (image.text.isEmpty ||
                                          price.text.isEmpty ||
                                          weight.text.isEmpty ||
                                          quantity.text.isEmpty ||
                                          title.text.isEmpty) {
                                        var snackBar = SnackBar(
                                          content: Text(
                                              'Please fill out all fields'),
                                          backgroundColor: Colors.green,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 6.0,
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        return;
                                      }

                                      setState(() {
                                        isloading = true;
                                      });
                                      await Future.delayed(
                                          Duration(milliseconds: 100));
                                      try {
                                        num parsedPrice =
                                            num.parse(price.text.trim());
                                        num parsedQuantity =
                                            num.parse(quantity.text.trim());

                                        Map<String, dynamic> order = {
                                          "image": image.text.trim(),
                                          "price": parsedPrice,
                                          "quantity": parsedQuantity,
                                          "title": title.text.trim(),
                                          "weight": weight.text.trim(),
                                        };

                                        try {
                                          await firestore
                                              .collection("data")
                                              .add(order);
                                          Navigator.of(context).pop();
                                        } catch (e) {
                                          var snackBar = SnackBar(
                                            content:
                                                Text('Error adding data: $e'),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            elevation: 6.0,
                                            duration: Duration(seconds: 2),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } finally {
                                          setState(() {
                                            isloading = false;
                                          });
                                        }
                                      } catch (e) {
                                        var snackBar = SnackBar(
                                          content: Text('Invalid input'),
                                          backgroundColor: Colors.green,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 6.0,
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        setState(() {
                                          isloading = false;
                                        });
                                      }

                                      price.clear();
                                      image.clear();
                                      weight.clear();
                                      quantity.clear();
                                      title.clear();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade400,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade400,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text(
                                "Close",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.green.shade400,
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
// https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz7ygpXgsobRRzuWjpigN8TnVYXE7EUSYGUw&s
