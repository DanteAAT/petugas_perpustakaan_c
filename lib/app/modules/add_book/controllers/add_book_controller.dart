import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petugas_perpustakaan_c/app/data/constant/endpoint.dart';
import 'package:petugas_perpustakaan_c/app/data/provider/api_provider.dart';
import 'package:petugas_perpustakaan_c/app/data/provider/storage_provider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:petugas_perpustakaan_c/app/routes/app_pages.dart';

class AddBookController extends GetxController {
  //TODO: Implement AddBookController
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahun_terbitController = TextEditingController();
  final count = 0.obs;
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  addBook() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.book,
            data: dio.FormData.fromMap({
              "judul": judulController.text.toString(),
              "penulis": penulisController.text.toString(),
              "penerbit": penerbitController.text.toString(),
              "tahun_terbit": int.parse(tahun_terbitController.text.toString()),

            }));
        if (response.statusCode == 201) {
          Get.back();
          // Get.snackbar("Berhasil", "",
          //     backgroundColor: Colors.green);
          // Get.offAllNamed(Routes.BOOK);
        } else {
          Get.snackbar("Sorry", "Tambah Buku Gagal", backgroundColor: Colors.orange);
        }
      }
      loading(false);
    } on dio.DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
