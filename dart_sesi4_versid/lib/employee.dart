import 'package:intl/intl.dart';

var numFormat = NumberFormat("#,000");
var dateFormat = DateFormat("yyyy-MM-dd");

const umr = 3200000;

enum TipeJabatan { kabag, manajer, direktur }

abstract class Employee {
  String nip;
  String name;
  String? address;
  int tahunMasuk;
  int _gaji = umr;

  Employee(this.nip, this.name, {this.tahunMasuk = 2015});

  void presensi(DateTime jamMasuk);

  String deskripsi() {
    String teks = """ ==================
    NIP: $nip
    Nama: $name
    Gaji: ${numFormat.format(gaji)} \n""";
    if (address != null) {
      teks += "Alamat: $address";
    }
    return teks;
  }

  int get tunjangan;

  int get gaji => (_gaji + tunjangan);

  set gaji(int gaji) {
    if (gaji < umr) {
      _gaji = umr;
      print("Gaji $name, tidak boleh dibawah UMR");
    } else {
      _gaji = gaji;
    }
  }
}

class StafBiasa extends Employee {
  StafBiasa(super.nip, super.name, {tahunMasuk = 2015});

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 8) {
      print("$name pada ${dateFormat.format(jamMasuk)} datang terlambat=");
    } else {
      print("$name pada ${dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  }

  @override
  int get tunjangan => ((2023 - tahunMasuk) < 5) ? 500000 : 1000000;
}

class Pejabat extends Employee {
  TipeJabatan jabatan;
  Pejabat(super.nip, super.name, this.jabatan);

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 9) {
      print("$name datang terlambat");
    } else {
      print("$name datang tepat waktu");
    }
  }

  @override
  int get tunjangan {
    if (jabatan == TipeJabatan.kabag) {
      return 15000000;
    } else if (jabatan == TipeJabatan.manajer) {
      return 25000000;
    } else {
      return 5000000;
    }
  }

  @override
  String deskripsi() {
    String teks = super.deskripsi();
    teks += "\n Jabatan:${jabatan.name}";
    return teks;
  }
}
