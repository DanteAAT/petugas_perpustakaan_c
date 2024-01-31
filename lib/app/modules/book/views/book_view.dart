import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:petugas_perpustakaan_c/app/data/model/response_book.dart';
import 'package:petugas_perpustakaan_c/app/routes/app_pages.dart';

import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {

  const BookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookView'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Get.toNamed(Routes.ADD_BOOK),child: Icon(Icons.add),
      ),
      body: controller.obx((state) => ListView.separated(
        itemCount: state!.length,
        itemBuilder: (context, index){
          DataBook dataBook = state[index];
          return ListTile(
            title: Text("${dataBook.judul}"),
            subtitle: Text("Penulis ${dataBook.penulis}\n${dataBook.penerbit} - ${dataBook.tahunTerbit}"),
          );
        },
        separatorBuilder: (context,index)=> Divider(),
      ))
    );
  }
}
