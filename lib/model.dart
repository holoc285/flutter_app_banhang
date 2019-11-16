class SanPhamModel {
  final String id;
  final String tensp;
  final String giasp;
  final String hinhanh;
  final String motasp;
  final String urlAnh1;
  final String urlAnh2;

  SanPhamModel(
      {this.id,
      this.tensp,
      this.giasp,
      this.hinhanh,
      this.motasp,
      this.urlAnh1,
      this.urlAnh2});

  factory SanPhamModel.fromJSON(Map<String, dynamic> parsedJson) {
    return SanPhamModel(
        id: parsedJson['id'].toString(),
        tensp: parsedJson['tensp'],
        giasp: parsedJson['giasp'].toString(),
        hinhanh: parsedJson['hinhanhsp'],
        motasp: parsedJson['motasp']);
  }

  factory SanPhamModel.fromJSONNew(Map<String, dynamic> parsedJSon) {
    return SanPhamModel(
        id: parsedJSon['masp'].toString(),
        tensp: parsedJSon['tensp'],
        giasp: parsedJSon['gia'].toString(),
        motasp: parsedJSon['thongtin'],
        urlAnh1: parsedJSon['anhlon'],
        urlAnh2: parsedJSon['anhnho']);
  }
}

class ListSanPham {
  List<SanPhamModel> list;

  ListSanPham({this.list});

  factory ListSanPham.fromJSON(List<dynamic> parsedJson) {
    List<SanPhamModel> lists = new List<SanPhamModel>();
    lists = parsedJson.map((i) => SanPhamModel.fromJSON(i)).toList();
    return ListSanPham(list: lists);
  }

  factory ListSanPham.fromJSONNew(List<dynamic> parsedJson) {
    List<SanPhamModel> lists = new List<SanPhamModel>();
    lists = parsedJson.map((i) => SanPhamModel.fromJSONNew(i)).toList();
    return ListSanPham(list: lists);
  }

}