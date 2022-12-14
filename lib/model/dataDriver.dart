class DataDriver {
  String? nama;
  String? catatan;
  String? tanggal;
  String? mobil;
  String? id;
  String? photodir;
  String? status;

  DataDriver({
    this.nama,
    this.catatan,
    this.tanggal,
    this.mobil,
    required this.id,
    this.photodir,
    this.status
  });

  DataDriver.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    catatan = json['catatan'];
    tanggal = json['tanggal'];
    mobil = json['mobil'];
    id = json['id'];
    photodir = json['photodir'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() => {
    'nama' : nama,
    'catatan' : catatan,
    'tanggal' : tanggal,
    'mobil' : mobil,
    'id' : id,
    'photodir': photodir,
    "status" : status
  };
}
