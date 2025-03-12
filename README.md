# Askeri Tesis Veritabanı Projesi

Bu proje, bir askeri üssün veri tabanı yönetimi çerçevesinde modellenmesi ve gerçek hayattaki senaryoları ele alarak geliştirilmiştir. Kullanıcılar, C# Form Application arayüzü aracılığıyla verileri yönetebilir ve CRUD (Create, Read, Update, Delete) işlemlerini gerçekleştirebilirler.

## Proje Bileşenleri

### 1. Kullanılan Teknolojiler
- **C# Form Application** (Kullanıcı Arayüzü)
- **PostgreSQL** (Veritabanı Sistemi)
- **Valentino Studio & Draw.io** (ERD Diyagramları)

### 2. Veritabanı Yapısı
Veritabanı PostgreSQL kullanılarak tasarlanmıştır ve aşağıdaki temel bileşenlerden oluşmaktadır:

- **Çalışanlar**: Künye, iletişim ve departman bilgileri
- **Askerler**: Rütbe, takım ve görev bilgileri
- **Görevler**: Operasyon bilgileri ve başarı durumları
- **Tedarikler**: Askeri ve lojistik malzemelerin kaydı
- **ER Diyagramları**: Varlık-ilişkisel yapıyı göstermektedir.

Daha detaylı ER diyagramı için **preview.png** dosyasına bakabilirsiniz.

## Kullanıcı Arayüzü ve CRUD İşlemleri
Kullanıcılar, arayüz üzerinden aşağıdaki işlemleri yapabilir:

- **Listeleme**: Verileri tablo halinde görüntüleme
- **Ekleme**: Yeni kayıt oluşturma
- **Güncelleme**: Mevcut verileri düzenleme
- **Silme**: Kapsam dışı kalan verileri temizleme

## İş Kuralları
- Her çalışan yalnızca bir departmanda çalışabilir.
- Bir asker aynı anda birden fazla göreve atanamaz.
- Tedarik edilen malzemeler sadece askeriyeye teslim edilir.
- 50 yaşını geçen askerler en az "Yüzbaşı" rütbesine getirilir.
- Yeni çalışanlar en az 18 yaşında olmalıdır.

## Diyagramlar ve Veritabanı Kodu
Veritabanı şemaları ve kodlar **database-askeri-tesis.sql** dosyasında bulunmaktadır.
ER Diyagramı görmek için **preview.png** dosyasını inceleyebilirsiniz.

## Kaynaklar
- **Wikipedia - Military Base**
- **C# ve SQL Bağlantı Örnekleri**
- **ChatGPT Danışmanlığı**

Bu proje, askeri veri yönetimini kolaylaştırmak ve sistematik bir yapı oluşturmak amacıyla geliştirilmiştir.

