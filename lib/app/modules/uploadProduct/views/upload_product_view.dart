import 'package:flutter/material.dart';

class UploadProductView extends StatefulWidget {
  const UploadProductView({super.key});

  @override
  _UploadProductViewState createState() => _UploadProductViewState();
}

class _UploadProductViewState extends State<UploadProductView> {
  String selectedSize = 'M';
  String selectedColor = 'Red';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Product'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'http://shinyglows.com/storage/uploads/products/img-3.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                spacing: 10,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      hintText: 'Enter Product Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Price',
                            hintText: 'Enter Product Price',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'QTY',
                            hintText: 'Enter Product Quantity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Size: '),
                      Row(
                        children: ['M', 'L', 'XL', 'XXL'].map((size) {
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            child: Text(
                              size,
                              style: TextStyle(
                                color: selectedSize == size
                                    ? Colors.blue
                                    : Colors.black,
                                fontWeight: selectedSize == size
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Color: '),
                      Row(
                        children: ['Red', 'Blue', 'Green', 'Yellow'].map((color) {
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                selectedColor = color;
                              });
                            },
                            child: Text(
                              color,
                              style: TextStyle(
                                color: selectedColor == color
                                    ? Colors.red
                                    : Colors.black,
                                fontWeight: selectedColor == color
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter Product Description',
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
