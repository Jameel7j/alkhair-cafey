# مشروع "كافتيريا الخير" — تطبيق المتجر (نسخة مبدئية)

وصف سريع:
تطبيق طلبات للمقهى "كافتيريا الخير" — يدعم اللغة العربية (RTL)، تصفح الأصناف حسب الأقسام، أحجام قابلة للاختيار، زر "إتمام الطلب" يرسل رسالة جاهزة عبر WhatsApp إلى رقم المتجر ويخزن الطلب في Firestore.

تقنيات مستخدمة:
- Flutter (Android / iOS / Web PWA)
- Firebase (Firestore, Auth, Storage)
- url_launcher (لفتح WhatsApp)
- Geolocator (مشاركة الموقع)

خطوات تشغيل محلي (مطور):
1. ثبت Flutter وادواته، ثم نفذ:
   flutter pub get
2. جهز Firebase Project وأضف تطبيق Android/iOS/Web، ثم نزّل ملفات google-services.json و GoogleService-Info.plist وضعهم في المسارات المناسبة.
3. قم بتعديل إعدادات Firebase في `lib/services/firebase_options.dart` أو استخدم `flutterfire configure`.
4. شغّل على المحاكي:
   flutter run

نشر APK:
- لبناء ملف APK:
  flutter build apk --release

لوحة المالك (Admin Panel):
- لوحة ويب بسيطة تعتمد Firebase Auth (مستخدم واحد مالك).
- يمكن تنصيبها كـ Firebase Hosting أو أي استضافة ويب.

ملاحظات مهمة:
- الربط مع بوابة الدفع "كريمي/حاسب": سنحتاج توثيق API لنقطة الدفع (رقم نقطة: 1299834) لتفعيل الدفع عبر البطاقة/محفظة.
- سياسة الأمان: في نسخة الإنتاج سيتم تقييد صلاحيات الكتابة على مجموعة `products` للمستخدم صاحب UID الخاص بالمالك فقط.
