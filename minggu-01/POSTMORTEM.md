# Blameless Postmortem - Insiden Kegagalan Deployment Manual

## Ringkasan Insiden
Aplikasi gagal dijalankan saat serah-terima dari Dev ke Ops.

## Kronologi (timeline)
Dev menyerahkan folder kode -> Ops membaca HANDOVER.md -> Ops mengeksekusi kode -> Muncul error modul Flask tidak ditemukan.

## Dampak (waktu terbuang, jumlah kegagalan)
Waktu terbuang sekitar 15 menit untuk menebak-nebak dependensi yang hilang.

## Akar Masalah pada SISTEM (bukan pada orang)
Tidak adanya sistem yang memaksa penyertaan dokumen dependensi (requirements.txt) sebelum kode diserahkan, serta proses manual yang rentan salah.

## Tindakan Perbaikan (action items) + penanggung jawab peran
Menerapkan otomasi lingkungan menggunakan skrip setup.sh (Penanggung jawab: Developer).

## Pelajaran yang Diambil
Proses manual sangat mengandalkan ingatan manusia yang terbatas. Otomasi memastikan konsistensi dan mencegah kesalahan yang berulang.
