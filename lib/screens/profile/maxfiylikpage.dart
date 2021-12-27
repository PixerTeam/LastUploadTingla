import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

class Maxfiylik extends StatelessWidget {
  const Maxfiylik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                left: getProportionScreenWidth(24.0),
                right: getProportionScreenWidth(24.0),
                top: getProportionScreenHeight(24.0),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    """Shaxsiy ma'lumotlaringiz, ulardan foydalanish maqsadlari va ular o'tkazilgan shaxslar haqida ma'lumot olishni istasangiz, iltimos, Egasi bilan bog'laning.

Egasi va ma'lumotlar boshqaruvchisi
To'plangan ma'lumotlarning toifalari
Egasi to'plangan Shaxsiy ma'lumotlar toifalari ro'yxatini taqdim etmaydi.

To'plangan Shaxsiy ma'lumotlarning har bir toifasi haqida to'liq ma'lumot ushbu maxfiylik siyosatining tegishli bo'limlarida yoki ma'lumotlarni yig'ishdan oldin ekranda ko'rsatiladigan maxsus tushuntirish matnlarida keltirilgan.
Shaxsiy ma'lumotlar Foydalanuvchi tomonidan mustaqil ravishda taqdim etilishi mumkin yoki Foydalanish ma'lumotlari bo'lsa, Ilova ulardan foydalanganda ularni avtomatik ravishda to'plashi mumkin.
Agar boshqacha ko'rsatilmagan bo'lsa, Ilova tomonidan so'ralgan barcha ma'lumotlar majburiydir. Agar ko'rsatilgan ma'lumotlar taqdim etilmasa, Ilova o'z xizmatlarini taqdim eta olmasligi mumkin. Ilova ma'lum ma'lumotlarning ixtiyoriy ravishda taqdim etilishini to'g'ridan-to'g'ri ko'rsatgan hollarda, Foydalanuvchilar Xizmatning mavjudligi yoki ishlashi nuqtai nazaridan hech qanday oqibatlarsiz tegishli ma'lumotlarni taqdim etmaslik huquqiga ega.
Qaysi Shaxsiy ma'lumotlar kerakligiga ishonchi komil bo'lmagan foydalanuvchilarga Egasi bilan bog'lanish tavsiya etiladi.
Ilova yoki ilovadan foydalanadigan uchinchi tomon xizmatlarining egalari cookie-fayllardan (yoki boshqa kuzatuv vositalaridan) faqat Foydalanuvchi tomonidan talab qilinadigan Xizmatni taqdim etish maqsadida, shuningdek ushbu hujjatda va Cookie-da ko'rsatilgan boshqa maqsadlarda foydalanadilar. Siyosat "(agar mavjud bo'lsa).

Foydalanuvchilar ushbu Ilova orqali olgan, nashr etgan yoki boshqalarga taqdim etgan, qabul qilgan, nashr etgan yoki uzatgan uchinchi shaxslarning har qanday Shaxsiy maʼlumotlari uchun javobgar boʻladilar va tegishli uchinchi tomonning Egasiga maʼlumotlarni taqdim etish uchun roziligini olganliklarini tasdiqlaydilar.

Ma'lumotlarni qayta ishlash usuli va joyi
Qayta ishlash usullari
Egasi Ma'lumotlarga ruxsatsiz kirish, ularni oshkor qilish, o'zgartirish yoki ruxsatsiz yo'q qilishning oldini olish uchun tegishli xavfsizlik choralarini ko'radi.
Ma'lumotlarni qayta ishlash tashkiliy tartib-qoidalar va aniq belgilangan maqsadlar bilan bog'liq usullarga muvofiq axborot texnologiyalari (IT) qo'llab-quvvatlanadigan kompyuterlar va (yoki) vositalar yordamida amalga oshiriladi. Ba'zi hollarda, Ma'lumotlar Egasidan tashqari, ushbu Ilovaning ishlashida ishtirok etadigan mas'ul shaxslarning ma'lum toifalari (ma'muriyat, savdo bo'limi, marketing bo'limi, yuridik bo'lim, tizim ma'murlari) yoki uchinchi shaxslar uchun mavjud bo'lishi mumkin. partiya tashkilotlari (masalan, uchinchi tomon texnik xizmat ko'rsatuvchi provayderlar, pochta tashkilotlari, xosting xizmatlarini provayderlar, axborot texnologiyalari kompaniyalari, aloqa xizmatlari), agar kerak bo'lsa, Egasi ma'lumotlar protsessorining funktsiyalarini bajarishni ishonib topshiradi. Ushbu shaxslar va tomonlarning yangilangan ro'yxati istalgan vaqtda egasidan so'ralishi mumkin.

Qayta ishlashning huquqiy asoslari
Egasi, agar quyidagi mezonlardan biri qo'llaniladigan bo'lsa, Foydalanuvchilarga tegishli Shaxsiy ma'lumotlarni qayta ishlashi mumkin:

Foydalanuvchilar ma'lumotlardan bir yoki bir nechta aniq maqsadlarda foydalanishga rozilik berdilar. Eslatma: ba'zi yurisdiktsiyalarning qonunlariga ko'ra, Egasi Shaxsiy ma'lumotlarni foydalanuvchi bunga e'tiroz bildirmaguncha ("tasdiqlash") quyidagi rozilik yoki boshqa qonuniy asoslarga tayanmasdan turib qayta ishlashga ruxsat berilishi mumkin. Biroq, shaxsiy ma'lumotlarni qayta ishlash Evropaning ma'lumotlarni himoya qilish qonuni bilan tartibga solinsa, yuqorida aytilganlar qo'llanilmaydi;
Ma'lumotlarni taqdim etish foydalanuvchi bilan tuzilgan shartnomani va (yoki) shartnoma tuzilishidan oldingi har qanday majburiyatlarni bajarish uchun zarur;
qayta ishlash mulkdorga yuklangan qonuniy majburiyatni bajarish uchun zarur bo'lsa;
qayta ishlash jamiyat manfaatlarini ko'zlab yoki mulkdorga berilgan rasmiy vakolatlarni amalga oshirishda amalga oshiriladigan muayyan vazifa bilan bog'liq;
qayta ishlash Egasining yoki uchinchi shaxsning qonuniy manfaatlarini ta'minlash uchun zarur.
Qanday bo'lmasin, Egasi qayta ishlash uchun qo'llaniladigan aniq huquqiy asosni va xususan, Shaxsiy ma'lumotlarni taqdim etish qonuniy yoki shartnomaviy talabmi yoki shartnoma tuzish uchun zarur bo'lgan talabmi yoki yo'qligini aniqlashga yordam berishdan mamnun bo'ladi.

Ma'lumotlar Egasining operatsion idoralarida va ularni qayta ishlashda ishtirok etuvchi tomonlar joylashgan har qanday boshqa joylarda qayta ishlanadi.
Foydalanuvchining joylashgan joyiga qarab, ma'lumotlarni uzatish foydalanuvchi ma'lumotlarini o'z mamlakatidan tashqaridagi mamlakatga o'tkazishni o'z ichiga olishi mumkin. Bunday uzatilgan ma'lumotlarni qayta ishlash joyi haqida batafsil ma'lumot olish uchun foydalanuvchilar Shaxsiy ma'lumotlarni qayta ishlash bo'yicha batafsil ma'lumotni o'z ichiga olgan bo'limga murojaat qilishlari mumkin.

Foydalanuvchilar, shuningdek, huquqiy hujjatlar bilan tanishish huquqiga ega""",
                    style: TextStyle(
                      fontSize: getProportionScreenWidth(18.0),
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
            CustomAppBar(
              child: Row(
                children: [
                  CustomButton(
                    icon: 'assets/icons/back_icon.svg',
                    color: Colors.black,
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: getProportionScreenWidth(12.0)),
                  Expanded(
                    child: Text(
                      "Maxfiylik siyosati",
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(24.0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
