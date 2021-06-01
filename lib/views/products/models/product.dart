import 'dart:io';

class Product {
  String id;
  String imageUrl;
  String nameAr;
  String nameEn;
  String descriptionAr;
  String descriptionEn;
  double price;
  bool isFavourite;
  File file;

  Product(
      {this.nameAr,
      this.nameEn,
      this.descriptionAr,
      this.descriptionEn,
      this.id,
      this.price,
      this.isFavourite = false,
      this.imageUrl,
      this.file});
  toMap() {
    return {
      'nameAr': this.nameAr,
      'nameEn': this.nameEn,
      'descriptionAr': this.descriptionAr,
      'descriptionEn': this.descriptionEn,
      'price': this.price,
      'isFavourite': this.isFavourite,
      'imageUrl': this.imageUrl
    };
  }
}
