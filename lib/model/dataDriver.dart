class DataDriver {
  String? nama;
  String? tujuan;
  String? tanggal;
  String? mobil;
  String? id;

  DataDriver({
    this.nama,
    this.tujuan,
    this.tanggal,
    this.mobil,
    required this.id
  });

  DataDriver.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    tujuan = json['tujuan'];
    tanggal = json['tanggal'];
    mobil = json['mobil'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {
    'nama' : nama,
    'tujuan' : tujuan,
    'tanggal' : tanggal,
    'mobil' : mobil,
    'id' : id
  };
}
