class DataDriver {
  String? nama;
  String? catatan;
  String? tanggalawal;
  String? tanggalakhir;
  String? mobil;
  String? id;
  String? photodir;
  String? status;

  DataDriver({
    this.nama,
    this.catatan,
    this.tanggalawal,
    this.tanggalakhir,
    this.mobil,
    this.id,
    this.photodir,
    this.status
  });

  DataDriver.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    catatan = json['catatan'];
    tanggalawal = json['tanggalawal'];
    tanggalakhir = json['tanggalakhir'];
    mobil = json['mobil'];
    id = json['id'];
    photodir = json['photodir'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() => {
    'nama' : nama,
    'catatan' : catatan,
    'tanggalawal' : tanggalawal,
    'tanggalakhir' : tanggalakhir,
    'mobil' : mobil,
    'id' : id,
    'photodir': photodir,
    "status" : status
  };
}
