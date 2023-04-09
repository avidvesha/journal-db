class CartItem {
  String? nama_produk;
  String? image;
  int? jumlah;
  int? harga;

  CartItem ({this.nama_produk, this.harga, this.image, this.jumlah});

  factory CartItem.fromJson(Map<dynamic, dynamic> json) {
    return CartItem(
      nama_produk: json['nama_produk'] as String?,
      image: json['image'] as String?,
      jumlah: json['jumlah'] as int?,
      harga: json['harga'] as int?,
    );
  }
}