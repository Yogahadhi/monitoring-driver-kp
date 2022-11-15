class DataMobil {
  String? merek;
  String? platmobil;

  DataMobil({this.merek, this.platmobil});

  DataMobil.fromJson(Map<String, dynamic> json) {
    merek = json['merek'];
    platmobil = json['platmobil'];
  }

  Map<String, dynamic> toJson() => {
    'merek': merek,
    'platmobil': platmobil
  };
}
