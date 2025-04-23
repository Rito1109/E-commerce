import '../models/product_model.dart';

class ProductService {
  // Fake product list
  static List<ProductModel> getProducts() {
    return [
      ProductModel(
        id: '1',
        name: 'Утас',
        description: 'Сүүлийн үеийн ухаалаг гар утас.',
        price: 999000,
        imageUrl: 'https://via.placeholder.com/150',
      ),
      ProductModel(
        id: '2',
        name: 'Зөөврийн компьютер',
        description: 'Intel i7, 16GB RAM, 512GB SSD.',
        price: 2599000,
        imageUrl: 'https://via.placeholder.com/150',
      ),
      ProductModel(
        id: '3',
        name: 'Bluetooth чихэвч',
        description: 'Дуу тусгаарлалттай, урт цэнэг.',
        price: 299000,
        imageUrl: 'https://via.placeholder.com/150',
      ),
    ];
  }
}