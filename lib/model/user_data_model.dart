class MyDataModel {

  final String imageAddress;
  final double lat;
  final double long;

  MyDataModel({
    
    required this.imageAddress,
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageAddress': imageAddress,
      'lat': lat,
      'long': long,
    };
  }
}
