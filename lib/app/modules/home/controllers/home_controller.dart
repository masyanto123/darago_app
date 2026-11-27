import 'package:get/get.dart';

class HomeController extends GetxController {
  // Index aktif navigasi bawah: 0: Inbox/Chat, 1: Home (default), 2: Jadwal
  final selectedIndex = 1.obs;

  // Data profil peserta & instansi/klien
  final userName = 'Muhammad Nanda Ferdianto'.obs;
  final instansiName = 'Harkat Negeri'.obs;

  // Data biro & trip
  final biroName = 'DaraGo Tour & Travel'.obs;
  final tripName = 'Eksplorasi Budaya & Wisata Jogja - Bali'.obs;
  final currentStatus = 'Dalam Perjalanan'.obs;
  final unreadNotifications = 0.obs;
  final currentDateTime = 'Selasa, 25 Agustus 2026 - 17:57:51'.obs;

  // Nama Tour Leader saat ini
  final tourLeaderName = 'Mas Budi (Tour Leader)'.obs;
  final tourLeaderDistance = '150 meter di depan'.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void openRadar() {
    Get.snackbar(
      'Radar Real-time',
      'Membuka radar & arah kompas ke Tour Leader (${tourLeaderName.value})...',
      snackPosition: SnackPosition.TOP,
    );
  }

  void openSettingsMenu(String item) {
    Get.snackbar(
      item,
      'Membuka menu $item',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
