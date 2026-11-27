import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const Color primaryBlue = Color(0xFF254EDB);
  static const Color softBlueBg = Color(0xFFE0EAFF);
  static const Color textDark = Color(0xFF1E293B);
  static const Color cardBg = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        bottom: false,
        child: Obx(() {
          return Stack(
            children: [
              // Konten Halaman sesuai Tab
              IndexedStack(
                index: controller.selectedIndex.value,
                children: [
                  _buildChatTab(),
                  _buildHomeContent(context),
                  _buildJadwalTab(),
                ],
              ),

              // Bottom Navigation Dock Floating Bar
              Positioned(
                left: 20,
                right: 20,
                bottom: 24,
                child: _buildBottomNav(),
              ),
            ],
          );
        }),
      ),
    );
  }

  // --- BERANDA / HOME CONTENT ---
  Widget _buildHomeContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Nama User & Instansi + Menu Titik Tiga (Settings, Panduan, Laporkan, Bantuan)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.userName.value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: textDark,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.instansiName.value,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: textDark.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: textDark),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onSelected: (value) => controller.openSettingsMenu(value),
                itemBuilder: (BuildContext context) => [
                  _buildPopupItem('panduan', 'Panduan Penggunaan', Icons.menu_book_outlined),
                  _buildPopupItem('laporkan', 'Laporkan Kendala', Icons.report_problem_outlined),
                  _buildPopupItem('bantuan', 'Bantuan & Darurat', Icons.headset_mic_outlined),
                  const PopupMenuDivider(),
                  _buildPopupItem('pengaturan', 'Pengaturan Akun', Icons.settings_outlined),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Main Card: Informasi Trip, Status Biro, dan Indikator Status
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris Atas: Indikator Traffic Light & Logo/Badge Biro
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Indikator 3 Titik (Hijau, Kuning, Merah)
                    Row(
                      children: [
                        _buildDot(Colors.green),
                        const SizedBox(width: 6),
                        _buildDot(Colors.amber),
                        const SizedBox(width: 6),
                        _buildDot(Colors.redAccent),
                      ],
                    ),
                    // Icon Biro / Foto Placeholder
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.directions_bus_rounded,
                        color: primaryBlue,
                        size: 26,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Nama Perusahaan Biro & Judul Perjalanan
                Text(
                  controller.biroName.value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6366F1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.tripName.value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),

                const SizedBox(height: 16),

                // 3 Card Mini Placeholder (seperti dalam wireframe desain)
                Row(
                  children: [
                    Expanded(child: _buildMiniCard('Bus 01', 'Armada', Icons.directions_bus_outlined)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildMiniCard('TL Budi', 'Tour Leader', Icons.person_pin_circle_outlined)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildMiniCard('Aktif', 'Status Trip', Icons.check_circle_outline)),
                  ],
                ),

                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 12),

                // Footer Card: Notifikasi & Tanggal Jam
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${controller.unreadNotifications.value} Notifikasi',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: textDark.withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      controller.currentDateTime.value,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: textDark.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Grid 4 Tombol Aksi Cepat
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  title: 'Lokasi Terkini',
                  icon: Icons.my_location_rounded,
                  bg: softBlueBg,
                  textColor: textDark,
                  onTap: () => controller.openRadar(),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildActionButton(
                  title: 'Jadwal',
                  icon: Icons.calendar_today_rounded,
                  bg: softBlueBg,
                  textColor: textDark,
                  onTap: () => controller.changeTab(2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  title: 'Info Destinasi',
                  icon: Icons.place_outlined,
                  bg: softBlueBg,
                  textColor: textDark,
                  onTap: () {
                    Get.snackbar('Info Destinasi', 'Menampilkan daftar objek wisata perjalanan ini');
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildActionButton(
                  title: 'Lainnya',
                  icon: Icons.dashboard_outlined,
                  bg: softBlueBg,
                  textColor: textDark,
                  onTap: () => controller.openSettingsMenu('Semua Menu'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Banner Card: Menu Maps Perjalanan Realtime
          InkWell(
            onTap: () {
              Get.snackbar('Peta Rute Perjalanan', 'Membuka peta rute langsung perjalanan bus...');
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withValues(alpha: 0.28),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.map_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Peta Perjalanan Realtime',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Pantau rute bus & titik temu rombongan',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB CHAT / INBOX PESERTA ---
  Widget _buildChatTab() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Chat Inbox Peserta', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildChatCard(
            title: 'Pengumuman Tour Leader (Mas Budi)',
            message: 'Rombongan bus 01 sudah bersiap di lobi hotel. Harap segera kumpul.',
            time: '17:40',
            isOfficial: true,
          ),
          const SizedBox(height: 12),
          _buildChatCard(
            title: 'Rian (Peserta Bus 1)',
            message: 'Siap mas, kami sedang turun lift.',
            time: '17:42',
            isOfficial: false,
          ),
          const SizedBox(height: 12),
          _buildChatCard(
            title: 'Siti (Peserta Bus 1)',
            message: 'Ada yang ketinggalan payung biru di kursi belakang?',
            time: '17:45',
            isOfficial: false,
          ),
        ],
      ),
    );
  }

  // --- TAB JADWAL / ITINERARY ---
  Widget _buildJadwalTab() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Jadwal Acara Trip', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildJadwalItem(
            time: '08:00 - 10:00',
            title: 'Penjemputan & Briefing',
            location: 'Titik Kumpul Stasiun Tugu',
            isDone: true,
          ),
          _buildJadwalItem(
            time: '10:30 - 13:00',
            title: 'Wisata Candi Prambanan',
            location: 'Kompleks Candi Prambanan',
            isDone: true,
          ),
          _buildJadwalItem(
            time: '17:30 - 19:30',
            title: 'Makan Malam & Belanja Oleh-oleh',
            location: 'Kawasan Malioboro',
            isCurrent: true,
          ),
          _buildJadwalItem(
            time: '20:00 - Selesai',
            title: 'Check-in Hotel & Istirahat',
            location: 'Hotel Santika Premiere',
            isNext: true,
          ),
        ],
      ),
    );
  }

  // --- BOTTOM NAVIGATION DOCK (3 Tombol dengan Radar Floating di Tengah) ---
  Widget _buildBottomNav() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Row untuk 2 tombol samping (Chat Kiri, Jadwal Kanan)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tombol 1: Chat / Riwayat Pesan (Kiri)
                IconButton(
                  onPressed: () => controller.changeTab(0),
                  icon: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 26,
                    color: controller.selectedIndex.value == 0
                        ? primaryBlue
                        : const Color(0xFF64748B),
                  ),
                ),

                // Tombol 3: Jadwal Acara / Dokumen (Kanan)
                IconButton(
                  onPressed: () => controller.changeTab(2),
                  icon: Icon(
                    Icons.description_outlined,
                    size: 26,
                    color: controller.selectedIndex.value == 2
                        ? primaryBlue
                        : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // Tombol 2 (Tengah): Radar Realtime ke Tour Leader (Bulatan Mengapung Sesuai Mockup)
          Positioned(
            top: -12,
            child: GestureDetector(
              onTap: () {
                controller.changeTab(1); // kembali ke beranda bila sedang di tab lain
                controller.openRadar();
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: primaryBlue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryBlue.withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.radar_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget Titik Status (Traffic Light)
  Widget _buildDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  // Helper Widget Card Mini di dalam Status Card
  Widget _buildMiniCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF64748B)),
          const SizedBox(height: 6),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  // Helper Widget Tombol Menu Aksi Cepat (Grid)
  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required Color bg,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: const Color(0xFF1E3A8A)),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Popup Item Menu Titik Tiga
  PopupMenuItem<String> _buildPopupItem(String value, String title, IconData icon) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF475569)),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // Helper Widget Chat Item
  Widget _buildChatCard({
    required String title,
    required String message,
    required String time,
    required bool isOfficial,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isOfficial ? const Color(0xFFEEF2FF) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isOfficial ? const Color(0xFFC7D2FE) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isOfficial ? const Color(0xFF3730A3) : const Color(0xFF1E293B),
                ),
              ),
              Text(
                time,
                style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: const TextStyle(fontSize: 13, color: Color(0xFF334155)),
          ),
        ],
      ),
    );
  }

  // Helper Widget Jadwal Rundown Item
  Widget _buildJadwalItem({
    required String time,
    required String title,
    required String location,
    bool isDone = false,
    bool isCurrent = false,
    bool isNext = false,
  }) {
    Color badgeColor = const Color(0xFF94A3B8);
    String statusLabel = 'Akan Datang';
    if (isDone) {
      badgeColor = Colors.green;
      statusLabel = 'Selesai';
    } else if (isCurrent) {
      badgeColor = const Color(0xFF254EDB);
      statusLabel = 'Berlangsung Sekarang';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrent ? const Color(0xFF254EDB) : const Color(0xFFE2E8F0),
          width: isCurrent ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: badgeColor,
                  ),
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF94A3B8)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
