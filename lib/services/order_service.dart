import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String shopWhatsApp = '+967730528609'; // رقم المتجر

  Future<void> placeOrder({
    required String customerName,
    required String customerPhone,
    required List<Map<String, dynamic>> items, // [{name, size, qty, price}]
    required double total,
  }) async {
    // جمع موقع الزبون (محاولة)
    String locationText = 'لم يتم تحديد الموقع';
    try {
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      locationText = 'https://maps.google.com/?q=${pos.latitude},${pos.longitude}';
    } catch (e) {
      // السماح بإتمام الطلب بدون موقع
    }

    // حفظ الطلب في Firestore
    final orderRef = await _db.collection('orders').add({
      'customerName': customerName,
      'customerPhone': customerPhone,
      'items': items,
      'total': total,
      'status': 'new',
      'createdAt': FieldValue.serverTimestamp(),
      'location': locationText,
    });

    // إعداد رسالة WhatsApp
    final buffer = StringBuffer();
    buffer.writeln('طلب جديد من تطبيق كافتيريا الخير');
    buffer.writeln('الاسم: $customerName');
    buffer.writeln('الهاتف: $customerPhone');
    buffer.writeln('');
    buffer.writeln('الطلبات:');
    for (var it in items) {
      buffer.writeln('- ${it['name']} (${it['size'] ?? ''}) x ${it['qty']} = ${it['price']} ريال');
    }
    buffer.writeln('');
    buffer.writeln('الإجمالي: ${total.toStringAsFixed(2)} ريال');
    buffer.writeln('الموقع: $locationText');
    buffer.writeln('معرف الطلب: ${orderRef.id}');

    final encoded = Uri.encodeComponent(buffer.toString());
    final waUrl = 'https://wa.me/${shopWhatsApp.replaceAll('+', '')}?text=$encoded';

    // فتح واتساب
    if (await canLaunch(waUrl)) {
      await launch(waUrl);
    } else {
      // فشل فتح واتساب — يمكن عرض رسالة خطأ للمستخدم
      throw 'لا يمكن فتح WhatsApp';
    }
  }
}
