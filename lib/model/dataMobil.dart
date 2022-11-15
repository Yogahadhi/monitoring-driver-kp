class DataMobil {
  String? merek;
  String? platmobil;
  int? id;

  DataMobil({this.merek, this.platmobil, required this.id});

  DataMobil.fromJson(Map<String, dynamic> json) {
    merek = json['merek'];
    platmobil = json['platmobil'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {
    'merek': merek,
    'platmobil': platmobil,
    'id' : id
  };
}
