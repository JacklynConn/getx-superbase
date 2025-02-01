import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/uploadProduct/controllers/upload_product_controller.dart';

class UploadProductView extends GetView<UploadProductController> {
  UploadProductView({super.key});

  final List<String> sizes = ['M', 'L', 'XL', 'XXL'];
  final List<String> colors = ['Red', 'Blue', 'Green', 'Yellow'];

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
                  child: Obx(
                    () {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: controller.imageFile.value == null
                            ? const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                              )
                            : Image.file(
                                controller.imageFile.value!,
                                fit: BoxFit.cover,
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                controller.pickImage();
              },
              child: const Text('Pick Image'),
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
                    controller: controller.nameController,
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
                          controller: controller.priceController,
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
                          controller: controller.quantityController,
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
                        children: [
                          for (final size in sizes)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Obx((){
                                return FilterChip(
                                  label: Text(size),
                                  labelStyle: TextStyle(
                                    color: controller.selectSize.contains(size)
                                        ? Colors.black
                                        : Colors.blue,
                                  ),
                                  onSelected: (bool value) {
                                    if (value) {
                                      controller.selectSize.add(size);
                                    } else {
                                      controller.selectSize.remove(size);
                                    }
                                  },
                                );
                              })
                            ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Color: '),
                      Row(
                        children: [
                          for (final color in colors)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Obx((){
                                return FilterChip(
                                  label: Text(color),
                                  labelStyle: TextStyle(
                                    color: controller.selectColor.contains(color)
                                        ? Colors.black
                                        : Colors.blue,
                                  ),
                                  onSelected: (bool value) {
                                    if (value) {
                                      controller.selectColor.add(color);
                                    } else {
                                      controller.selectColor.remove(color);
                                    }
                                  },
                                );
                              })
                            ),
                        ],
                      ),
                    ],
                  ),
                  TextField(
                    controller: controller.descriptionController,
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                controller.uploadProduct();
              },
              child: const Text('Upload Product'),
            ),
          ],
        ),
      ),
    );
  }
}
