const umr = 3200000;

class Employee {
  int nip;
  String name;
  String? address;
  int thnMasuk;
  int _gaji = umr;

  Employee(this.nip, this.name, {this.thnMasuk = 2015});

  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 8) {
      print("$name Datang Terlambat");
    } else {
      print("$name Datang Tepat Waktu");
      print("Hallo $name");
    }
  }

  String deskripsi() {
    String teks = """ ==================
    NIP: $nip
    Nama: $name
    Gaji: $_gaji
    """;
    if (address != null) {
      teks += "Alamat: $address";
    }
    return teks;
  }

  int get tunjangan => ((2023 - thnMasuk) < 5) ? 500000 : 1000000;

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
