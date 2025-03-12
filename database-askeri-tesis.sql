-- sigorta tablosu
CREATE TABLE sigorta (
    sigorta_id SERIAL PRIMARY KEY,
    sigorta_adi VARCHAR(300) NOT NULL,
    sirket_adi VARCHAR(300) NOT NULL,
    son_kullanma_yili INT NOT NULL,
    kapsam DECIMAL NOT NULL,
    fiyat INT NOT NULL
);

-- calisan tablosu
CREATE TABLE calisan (
    calisan_id SERIAL PRIMARY KEY,
    ad VARCHAR(300) NOT NULL,
    soyad VARCHAR(300) NOT NULL,
    maas INT NOT NULL,
    dogum_tarihi DATE NOT NULL,
    cinsiyet VARCHAR(300) NOT NULL,
    iletisim VARCHAR(300) NOT NULL UNIQUE,
    adres VARCHAR(300) NOT NULL,
    mezuniyet VARCHAR(300) NOT NULL,
    medeni_hali VARCHAR(300) NOT NULL,
    is_tanimi VARCHAR(300) NOT NULL,
    is_durumu VARCHAR(300) NOT NULL,
    sigorta_id INT NOT NULL,
    FOREIGN KEY (sigorta_id) REFERENCES sigorta(sigorta_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- departman tablosu
CREATE TABLE departman (
    departman_id SERIAL PRIMARY KEY,
    departman_adi VARCHAR(300) NOT NULL,
    departman_yoneticisi VARCHAR(300) NOT NULL,
    departman_konumu VARCHAR(300) NOT NULL,
    departman_aciklamasi VARCHAR(300) NOT NULL,
    calisan_id INT NOT NULL,
    FOREIGN KEY (calisan_id) REFERENCES calisan(calisan_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- rutbe tablosu
CREATE TABLE rutbe (
    rutbe_id SERIAL PRIMARY KEY,
    rutbe_adi VARCHAR(300) NOT NULL,
    rutbe_kisaltmasi VARCHAR(300) NOT NULL,
    rutbe_aciklamasi VARCHAR(300) NOT NULL
);

-- silah tablosu
CREATE TABLE silah (
    silah_id SERIAL PRIMARY KEY,
    silah_adi VARCHAR(300) NOT NULL,
    teslim_tarihi DATE NOT NULL,
    fiyat INT NOT NULL,
    miktar INT NOT NULL,
    silah_aciklamasi VARCHAR(300) NOT NULL
);

-- silah_disi tablosu
CREATE TABLE silah_disi (
    silah_disi_id SERIAL PRIMARY KEY,
    adi VARCHAR(300) NOT NULL,
    teslim_tarihi DATE NOT NULL,
    fiyat INT NOT NULL,
    miktar INT NOT NULL
);

-- asker tablosu
CREATE TABLE asker (
    asker_id SERIAL PRIMARY KEY,
    ad VARCHAR(300) NOT NULL,
    soyad VARCHAR(300) NOT NULL,
    maas INT NOT NULL,
    dogum_tarihi DATE NOT NULL,
    cinsiyet VARCHAR(300) NOT NULL,
    iletisim VARCHAR(300) NOT NULL UNIQUE,
    adres VARCHAR(300) NOT NULL,
    mezuniyet VARCHAR(300) NOT NULL,
    medeni_hali VARCHAR(300) NOT NULL,
    is_tanimi VARCHAR(300) NOT NULL,
    is_durumu VARCHAR(300) NOT NULL,
    calisan_id INT NOT NULL,
    sigorta_id INT NOT NULL,
    rutbe_id INT NOT NULL,
    silah_id INT NOT NULL,
    silah_disi_id INT NOT NULL,
    FOREIGN KEY (calisan_id) REFERENCES calisan(calisan_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (sigorta_id) REFERENCES sigorta(sigorta_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (rutbe_id) REFERENCES rutbe(rutbe_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (silah_id) REFERENCES silah(silah_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (silah_disi_id) REFERENCES silah_disi(silah_disi_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- asker_olmayan tablosu
CREATE TABLE asker_olmayan (
    asker_olmayan_id SERIAL PRIMARY KEY,
    ad VARCHAR(300) NOT NULL,
    soyad VARCHAR(300) NOT NULL,
    maas INT NOT NULL,
    dogum_tarihi DATE NOT NULL,
    cinsiyet VARCHAR(300) NOT NULL,
    iletisim VARCHAR(300) NOT NULL UNIQUE,
    adres VARCHAR(300) NOT NULL,
    mezuniyet VARCHAR(300) NOT NULL,
    medeni_hali VARCHAR(300) NOT NULL,
    is_tanimi VARCHAR(300) NOT NULL,
    is_durumu VARCHAR(300) NOT NULL,
    calisan_id INT NOT NULL,
    sigorta_id INT NOT NULL,
    silah_disi_id INT NOT NULL,
    FOREIGN KEY (calisan_id) REFERENCES calisan(calisan_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (sigorta_id) REFERENCES sigorta(sigorta_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (silah_disi_id) REFERENCES silah_disi(silah_disi_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- askeri_tesis tablosu
CREATE TABLE askeri_tesis (
    askeri_tesis_id SERIAL PRIMARY KEY,
    tesis_adi VARCHAR(300) NOT NULL,
    tesis_aciklamasi VARCHAR(300) NOT NULL,
    tesis_konumu VARCHAR(300) NOT NULL,
    tesis_iletisim VARCHAR(300) NOT NULL UNIQUE,
    asker_id INT NOT NULL,
    FOREIGN KEY (asker_id) REFERENCES asker(asker_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- izin tablosu
CREATE TABLE izin (
    izin_nedeni VARCHAR(300) NOT NULL,
    ayrilis_tarihi DATE NOT NULL,
    donus_tarihi DATE NOT NULL,
    calisan_id INT NOT NULL,
    FOREIGN KEY (calisan_id) REFERENCES calisan(calisan_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- takim tablosu
CREATE TABLE takim (
    takim_adi VARCHAR(300) NOT NULL,
    takim_turu VARCHAR(300) NOT NULL,
    takim_sorumluluklari VARCHAR(300) NOT NULL,
    asker_id INT NOT NULL,
    FOREIGN KEY (asker_id) REFERENCES asker(asker_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- gorevdeki_asker tablosu
CREATE TABLE gorevdeki_asker (
    takim_adi VARCHAR(300) NOT NULL,
    takim_turu VARCHAR(300) NOT NULL,
    sorumluluk VARCHAR(300) NOT NULL,
    asker_id INT NOT NULL,
    FOREIGN KEY (asker_id) REFERENCES asker(asker_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- gorev_aranan_suclu tablosu
CREATE TABLE gorev_aranan_suclu (
    gorev_id INT NOT NULL,
    suclu_id INT NOT NULL,
    FOREIGN KEY (gorev_id) REFERENCES gorev(gorev_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (suclu_id) REFERENCES aranan_suclu(suclu_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- silah_disi_asker_olmayan tablosu
CREATE TABLE silah_disi_asker_olmayan (
    silah_disi_id INT NOT NULL,
    asker_olmayan_id INT NOT NULL,
    FOREIGN KEY (silah_disi_id) REFERENCES silah_disi(silah_disi_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (asker_olmayan_id) REFERENCES asker_olmayan(asker_olmayan_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- silah_asker tablosu
CREATE TABLE silah_asker (
    silah_id INT NOT NULL,
    asker_id INT NOT NULL,
    FOREIGN KEY (silah_id) REFERENCES silah(silah_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (asker_id) REFERENCES asker(asker_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- calisan_izin tablosu
CREATE TABLE calisan_izin (
    calisan_id INT NOT NULL,
    FOREIGN KEY (calisan_id) REFERENCES calisan(calisan_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Güncellenmiş gorev tablosu
INSERT INTO gorev (gorev_id, gorev_tarihi, gorev_konumu, gorev_aciklamasi, gorev_basari_durumu)
VALUES
(1, '2024-06-01 09:00:00', 'Irak, Bağdat', 'Kaçakçılık gruplarına karşı mücadele', 'Başarılı'),
(2, '2024-07-15 14:30:00', 'Irak, Bağdat', 'Askeri üs inşası ve güvenlik sağlama', 'Başarısız'),
(3, '2024-08-20 08:00:00', 'Suriye, Halep', 'İnsani yardım operasyonu düzenlemek', 'Başarılı'),
(4, '2024-09-05 11:00:00', 'Suriye, Şam', 'Hedef operasyonu ve düşman kamplarının imhası', 'Başarılı'),
(5, '2024-10-10 13:30:00', 'Libya, Trablus', 'Barışı sağlama ve yerel yönetimle işbirliği', 'Başarılı'),
(6, '2024-06-15 10:00:00', 'Yemen, Sana', 'Düşman üslerinin keşfi ve raporlama', 'Başarılı'),
(7, '2024-11-01 09:00:00', 'Mısır, Kahire', 'Askeri eğitim ve tatbikatlar düzenlemek', 'Başarısız'),
(8, '2024-07-01 08:30:00', 'Somali, Mogadişu', 'Açlık yardımı dağıtımı ve güvenlik sağlama', 'Başarılı'),
(9, '2024-05-15 12:00:00', 'Lübnan, Beyrut', 'Askeri üs kurma ve güvenlik önlemleri almak', 'Başarılı'),
(10, '2024-09-25 10:00:00', 'Çad, N’Djamena', 'Hedef tarama ve izleme görevleri', 'Başarısız');


-- Güncellenmiş aranan_suclu tablosu
INSERT INTO aranan_suclu (suclu_id, ad, soyad, suclama, konum, cinsiyet, gorev_id)
VALUES
(1, 'Firat', 'Aydin', 'Kaçakçılık', 'Irak, Bağdat', 'Erkek', 1),
(2, 'Kemal', 'Kaya', 'Terör Faaliyeti', 'Irak, Bağdat', 'Erkek', 2),
(3, 'Ali', 'Kar', 'İnsani Yardım Operasyonu', 'Suriye, Halep', 'Erkek', 3),
(4, 'Murat', 'Yılmaz', 'Hedef Operasyonu', 'Suriye, Şam', 'Erkek', 4),
(5, 'Halil', 'Demir', 'Barış Gücü Aykırılığı', 'Libya, Trablus', 'Erkek', 5),
(6, 'Hüseyin', 'Kurt', 'Düşman Üslerinin Keşfi', 'Yemen, Sana', 'Erkek', 6),
(7, 'Serdar', 'Ak', 'Askeri Eğitim ve Tatbikat', 'Mısır, Kahire', 'Erkek', 7),
(8, 'Zeki', 'Ekin', 'Açlık Yardımı Dağıtımı', 'Somali, Mogadişu', 'Erkek', 8),
(9, 'Eren', 'Arslan', 'Askeri Üs Kurma', 'Lübnan, Beyrut', 'Erkek', 9),
(10, 'Burak', 'Yıldız', 'Hedef Tarama ve İzleme', 'Çad, N’Djamena', 'Erkek', 10);



--Bu kısımda alttan yukarıya doğru sırayla veriler eklenmelidir alt sınırı belirteceğim

INSERT INTO calisan (calisan_id, ad, soyad, maas, dogum_tarihi, cinsiyet, iletisim, adres, mezuniyet, medeni_hali, is_tanimi, is_durumu, sigorta_id)
VALUES
(1, 'Mehmet', 'Baysal', 7000, '1992-05-12', 'Erkek', '0566 123 45 67', 'İzmir', 'Lisans', 'Bekar', 'Piyade', 'Aktif', 1),
(2, 'Kemal', 'Kılıç', 7500, '1988-08-25', 'Erkek', '0577 234 56 78', 'Antalya', 'Lisans', 'Evli', 'Komutan', 'Aktif', 2),
(3, 'Fatih', 'Yavuz', 8000, '1985-11-17', 'Erkek', '0588 345 67 89', 'Kocaeli', 'Yüksek Lisans', 'Bekar', 'Operasyon Sorumlusu', 'Aktif', 3),
(4, 'Serkan', 'Çelik', 7200, '1990-02-19', 'Erkek', '0599 456 78 90', 'Eskişehir', 'Lisans', 'Evli', 'Tankçı', 'Aktif', 4),
(5, 'Hasan', 'Tekin', 6800, '1993-04-25', 'Erkek', '0612 678 90 12', 'Diyarbakır', 'Lisans', 'Bekar', 'İstihbarat Subayı', 'Aktif', 1),
(6, 'Yusuf', 'Şahin', 7500, '1987-09-10', 'Erkek', '0623 789 01 23', 'Gaziantep', 'Yüksek Lisans', 'Evli', 'Hava Kuvvetleri Subayı', 'Aktif', 3),
(7, 'Murat', 'Kurt', 7100, '1986-12-03', 'Erkek', '0634 890 12 34', 'Van', 'Lisans', 'Bekar', 'Muhabere Uzmanı', 'Aktif', 2),
(8, 'Emre', 'Bulut', 6900, '1992-07-22', 'Erkek', '0645 901 23 45', 'Samsun', 'Lisans', 'Bekar', 'Keskin Nişancı', 'Aktif', 1),
(9, 'Ayşe', 'Öztürk', 4000, '1995-03-03', 'Kadın', '0599 456 78 90', 'Adana', 'Lisans', 'Bekar', 'Lojistik Uzmanı', 'Aktif', 4),
(10, 'Hüseyin', 'Çetin', 3500, '1993-06-14', 'Erkek', '0600 567 89 01', 'Konya', 'Önlisans', 'Evli', 'Depo Sorumlusu', 'Aktif', 3),
(11, 'Elif', 'Aydın', 4200, '1991-09-22', 'Kadın', '0611 678 90 12', 'Trabzon', 'Lisans', 'Bekar', 'Teknik Destek', 'Aktif', 2),
(12, 'Nihal', 'Güneş', 3800, '1990-05-16', 'Kadın', '0622 456 70 90', 'İzmir', 'Lisans', 'Bekar', 'Eğitim Uzmanı', 'Aktif', 1),
(13, 'Burak', 'Eren', 3600, '1988-08-08', 'Erkek', '0633 567 89 01', 'Ankara', 'Lisans', 'Evli', 'Satın Alma Uzmanı', 'Aktif', 3),
(14, 'Leyla', 'Aksoy', 4000, '1992-12-12', 'Kadın', '0644 678 90 12', 'Antalya', 'Lisans', 'Bekar', 'İnsan Kaynakları Uzmanı', 'Aktif', 4),
(15, 'Halil', 'Karaca', 3700, '1989-01-20', 'Erkek', '0655 789 01 23', 'Bursa', 'Önlisans', 'Evli', 'Planlama Uzmanı', 'Aktif', 2),
(16, 'Esra', 'Polat', 3900, '1993-07-03', 'Kadın', '0666 890 12 34', 'Trabzon', 'Lisans', 'Bekar', 'Müşteri Temsilcisi', 'Aktif', 1);



INSERT INTO asker (asker_id, ad, soyad, maas, dogum_tarihi, cinsiyet, iletisim, adres, mezuniyet, medeni_hali, is_tanimi, is_durumu, calisan_id, sigorta_id, rutbe_id, silah_id, silah_disi_id)
VALUES
(1, 'Mehmet', 'Baysal', 7000, '1992-05-12', 'Erkek', '0566 123 45 67', 'İzmir', 'Lisans', 'Bekar', 'Piyade', 'Aktif',1, 1, 4, 2, 3),
(2, 'Kemal', 'Kılıç', 7500, '1988-08-25', 'Erkek', '0577 234 56 78', 'Antalya', 'Lisans', 'Evli', 'Komutan', 'Aktif',2, 2, 5, 1, 1),
(3, 'Fatih', 'Yavuz', 8000, '1985-11-17', 'Erkek', '0588 345 67 89', 'Kocaeli', 'Yüksek Lisans', 'Bekar', 'Operasyon Sorumlusu', 'Aktif',3, 3, 7, 2, 4),
(4, 'Serkan', 'Çelik', 7200, '1990-02-19', 'Erkek', '0599 456 78 90', 'Eskişehir', 'Lisans', 'Evli', 'Tankçı', 'Aktif',4, 4, 3, 2, 5),
(5, 'Hasan', 'Tekin', 6800, '1993-04-25', 'Erkek', '0612 678 90 12', 'Diyarbakır', 'Lisans', 'Bekar', 'İstihbarat Subayı', 'Aktif',5, 1, 2, 3, 4),
(6, 'Yusuf', 'Şahin', 7500, '1987-09-10', 'Erkek', '0623 789 01 23', 'Gaziantep', 'Yüksek Lisans', 'Evli', 'Hava Kuvvetleri Subayı', 'Aktif',6, 3, 6, 1, 2),
(7, 'Murat', 'Kurt', 7100, '1986-12-03', 'Erkek', '0634 890 12 34', 'Van', 'Lisans', 'Bekar', 'Muhabere Uzmanı', 'Aktif',7, 2, 5, 2, 1),
(8, 'Emre', 'Bulut', 6900, '1992-07-22', 'Erkek', '0645 901 23 45', 'Samsun', 'Lisans', 'Bekar', 'Keskin Nişancı', 'Aktif',8, 1, 4, 3, 1);

INSERT INTO asker_olmayan (asker_olmayan_id, ad, soyad, maas, dogum_tarihi, cinsiyet, iletisim, adres, mezuniyet, medeni_hali, is_tanimi, is_durumu, calisan_id, sigorta_id, silah_disi_id)
VALUES
(1, 'Ayşe', 'Öztürk', 4000, '1995-03-03', 'Kadın', '0599 456 78 90', 'Adana', 'Lisans', 'Bekar', 'Lojistik Uzmanı', 'Aktif',9, 4, 4),
(2, 'Hüseyin', 'Çetin', 3500, '1993-06-14', 'Erkek', '0600 567 89 01', 'Konya', 'Önlisans', 'Evli', 'Depo Sorumlusu', 'Aktif',10, 3, 5),
(3, 'Elif', 'Aydın', 4200, '1991-09-22', 'Kadın', '0611 678 90 12', 'Trabzon', 'Lisans', 'Bekar', 'Teknik Destek', 'Aktif',11, 2, 2),
(4, 'Nihal', 'Güneş', 3800, '1990-05-16', 'Kadın', '0622 456 78 90', 'İzmir', 'Lisans', 'Bekar', 'Eğitim Uzmanı', 'Aktif',12, 1, 3),
(5, 'Burak', 'Eren', 3600, '1988-08-08', 'Erkek', '0633 567 89 01', 'Ankara', 'Lisans', 'Evli', 'Satın Alma Uzmanı', 'Aktif',13, 3, 3),
(6, 'Leyla', 'Aksoy', 4000, '1992-12-12', 'Kadın', '0644 678 90 12', 'Antalya', 'Lisans', 'Bekar', 'İnsan Kaynakları Uzmanı', 'Aktif',14, 4, 1),
(7, 'Halil', 'Karaca', 3700, '1989-01-20', 'Erkek', '0655 789 01 23', 'Bursa', 'Önlisans', 'Evli', 'Planlama Uzmanı', 'Aktif',15, 2, 2),
(8, 'Esra', 'Polat', 3900, '1993-07-03', 'Kadın', '0666 890 12 34', 'Trabzon', 'Lisans', 'Bekar', 'Müşteri Temsilcisi', 'Aktif',16, 1, 1);



INSERT INTO rutbe (rutbe_id, rutbe_adi, rutbe_kisaltmasi, rutbe_aciklamasi)
VALUES
(1,'Özel', 'Öz', 'Askerin en düşük rütbesi. Genellikle eğitim aşamasındaki askerler için kullanılır.'),
(2,'Çavuş', 'Çvş', 'Ekip lideri veya biriminin sorumluluğunu taşıyan, genellikle birkaç askerle çalışan rütbe.'),
(3,'Astsubay', 'A.sub', 'Çavuşlardan üst, profesyonel asker olarak belirli bir askeri birim ya da görevi yönetir.'),
(4,'Subay', 'Sb', 'Askeri üniversiteyi tamamlayıp görevli olarak atanmış, liderlik ve komutanlık sorumluluğu taşıyan rütbe.'),
(5,'Yüzbaşı', 'Yb', 'Bir askeri birimde, genellikle 100-150 askerlik birliği yöneten rütbe.'),
(6,'Binbaşı', 'Bş', 'Büyük askeri birliklerin yöneticisi, yüzbaşılardan daha üst bir rütbe.'),
(7,'Albay', 'Alb', 'Çoğunlukla bir tugay, alay ya da daha büyük askeri birliğin komutanıdır.'),
(8,'Tuğgeneral', 'Tğn', 'Küçük bir orduyu yöneten, albaydan daha yüksek rütbeli subay.'),
(9,'Tümgeneral', 'Tgn', 'Ordu komutanlıklarında görev yapan, yüksek düzeyde askeri lider.'),
(10,'Orgeneral', 'Org', 'En yüksek askeri rütbe, orduya liderlik eden, ülkenin en yüksek askeri yetkilisidir.');

INSERT INTO sigorta (sigorta_id, sigorta_adi, sirket_adi, son_kullanma_yili, kapsam, fiyat)
VALUES
(1, 'Askerî Sağlık Sigortası', 'Türk Askeri Sigorta A.Ş.', 2026, 1, 500),
(2, 'Çalışan Sigortası', 'Çalışan Güvence Sigorta', 2025, 2, 300),
(3, 'Genel Sağlık Sigortası', 'Sağlık Sigorta A.Ş.', 2027, 3, 250),
(4, 'İşsizlik Sigortası', 'İş Güvenliği Sigorta', 2024, 4, 150),
(5, 'Deprem Sigortası', 'Doğa Sigorta', 2030, 5, 400);

INSERT INTO silah (silah_id, silah_adi, teslim_tarihi, fiyat, miktar, silah_aciklamasi, teslim_id)
VALUES
(1, 'AK-47', '2025-01-15', 2500, 100, 'Askeri kullanım için tasarlanmış, yarı otomatik ve tam otomatik modlar.', 1),
(2, 'M16', '2025-02-01', 3000, 150, 'Amerikan yapımı, askeri piyade tüfeği, yüksek hassasiyetli.', 2),
(3, 'Glock 19', '2025-01-25', 700, 200, 'Polis ve güvenlik güçleri için tasarlanmış, kompakt tabanca.', 3);


INSERT INTO silah_disi (silah_disi_id, adi, teslim_tarihi, fiyat, miktar, teslim_id)
VALUES

(1, 'Taktik Yelek', '2025-01-15', 150, 50, 4),
(2, 'Büyüteç', '2025-02-01', 25, 200, 5),
(3, 'Kamuflaj Üniforma', '2025-01-25', 80, 100, 6),
(4, 'Mikroskop', '2025-03-01', 500, 30, 7),
(5, 'Gözlük Seti', '2025-01-30', 45, 150, 8);


INSERT INTO teslim (teslim_id, teslim_adi, teslim_turu, teslim_tarihi, teslim_fiyati, miktar, tedarikci_id)
VALUES
(1, 'AK-47 Teslimatı', 'Silah', '2025-01-15', 250000, 100, 1),
(2, 'M16 Teslimatı', 'Silah', '2025-02-01', 450000, 150, 2),
(3, 'Glock 19 Teslimatı', 'Silah', '2025-01-25', 140000, 200, 3),
(4, 'Taktik Yelek Teslimatı', 'Silah Dışı', '2025-01-15', 7500, 50, 4),
(5, 'Büyüteç Teslimatı', 'Silah Dışı', '2025-02-01', 5000, 200, 5),
(6, 'Kamuflaj Üniforma Teslimatı', 'Silah Dışı', '2025-01-25', 8000, 100, 6),
(7, 'Mikroskop Teslimatı', 'Silah Dışı', '2025-03-01', 15000, 30, 7),
(8, 'Gözlük Seti Teslimatı', 'Silah Dışı', '2025-01-30', 6750, 150, 8);

INSERT INTO tedarikci (tedarikci_id, ad, soyad, teslim_tarihi, teslim_urun, miktar, tedarikci_konumu, iletisim)
VALUES
(1, 'Kemal', 'Kara', '2025-01-15', 'AK-47', 100, 'İstanbul', '0212 123 45 67'),
(2, 'Selim', 'Berk', '2025-02-01', 'M16', 150, 'Bursa', '0224 234 56 78'),
(3, 'Emin', 'Yavuz', '2025-01-25', 'Glock 19', 200, 'Kocaeli', '0262 345 67 89'),
(4, 'Veli', 'Öztürk', '2025-01-15', 'Taktik Yelek', 50, 'Adana', '0322 456 78 90'),
(5, 'Mustafa', 'Çetin', '2025-02-01', 'Büyüteç', 200, 'Konya', '0332 567 89 01'),
(6, 'Ahmet', 'Demir', '2025-01-25', 'Kamuflaj Üniforma', 100, 'Ankara', '0312 678 90 12'),
(7, 'Mehmet', 'Baysal', '2025-03-01', 'Mikroskop', 30, 'İzmir', '0232 789 01 23'),
(8, 'Fatma', 'Kılıç', '2025-01-30', 'Gözlük Seti', 150, 'Antalya', '0242 890 12 34');

--altsınır

INSERT INTO askeri_tesis (askeri_tesis_id, tesis_adi, tesis_aciklamasi, tesis_konumu, tesis_iletisim)
Values
(1, 'Ana Karargah', 'Bölgedeki operasyonların planlandığı ve yönetildiği merkez.', 'Ankara', '0312 123 45 67');


INSERT INTO departman (departman_adi, departman_yoneticisi, departman_konumu, departman_aciklamasi, calisan_id)
VALUES
('Piyade Birimi', 'Mehmet Baysal', 'İzmir', 'Piyade biriminde operasyon yönetimi.', 1),
('Komutanlık', 'Kemal Kılıç', 'Antalya', 'Tugay komutanlığını yönetir.', 2),
('Operasyon Yönetimi', 'Fatih Yavuz', 'Kocaeli', 'Operasyonları koordine eder.', 3),
('Tank Birimi', 'Serkan Çelik', 'Eskişehir', 'Tank operasyonlarını yürütür.', 4),
('İstihbarat Birimi', 'Hasan Tekin', 'Diyarbakır', 'İstihbarat toplama ve analiz.', 5),
('Hava Kuvvetleri', 'Yusuf Şahin', 'Gaziantep', 'Hava operasyonlarını yönetir.', 6),
('Muhabere Birimi', 'Murat Kurt', 'Van', 'Muhabere desteği sağlar.', 7),
('Keskin Nişancı Ekibi', 'Emre Bulut', 'Samsun', 'Keskin nişancı birimini yönetir.', 8),
('Lojistik Departmanı', 'Ayşe Öztürk', 'Adana', 'Lojistik yönetimi ve sevkiyat.', 9),
('Depo Yönetimi', 'Hüseyin Çetin', 'Konya', 'Depo operasyonlarını yürütür.', 10),
('Teknik Destek', 'Elif Aydın', 'Trabzon', 'Teknik destek sağlar.', 11),
('Eğitim Departmanı', 'Nihal Güneş', 'İzmir', 'Personel eğitimi düzenler.', 12),
('Satın Alma Departmanı', 'Burak Eren', 'Ankara', 'Malzeme tedarikini yönetir.', 13),
('İnsan Kaynakları', 'Leyla Aksoy', 'Antalya', 'İnsan kaynakları yönetimi.', 14),
('Planlama Departmanı', 'Halil Karaca', 'Bursa', 'Operasyonel planlama yapar.', 15),
('Müşteri Temsilciliği', 'Esra Polat', 'Trabzon', 'Müşteri ilişkilerini yönetir.', 16);

INSERT INTO takim (takim_adi, takim_turu, takim_sorumluluklari, asker_id)
VALUES
('Piyade Timi', 'Piyade', 'Arazi operasyonları ve saldırı birimi.', 1),
('Komutanlık Ekibi', 'Komutanlık', 'Tugay operasyonları ve liderlik.', 2),
('Operasyon Timi', 'Operasyon', 'Kritik görevlerin planlanması ve yürütülmesi.', 3),
('Tank Birimi', 'Tankçı', 'Tank operasyonlarının yürütülmesi.', 4),
('İstihbarat Ekibi', 'İstihbarat', 'Bilgi toplama ve analiz.', 5),
('Hava Timi', 'Hava Kuvvetleri', 'Hava operasyonlarının yönetimi ve icrası.', 6),
('Muhabere Ekibi', 'Muhabere', 'İletişim ve teknik destek.', 7),
('Keskin Nişancı Timi', 'Keskin Nişancı', 'Hassas hedeflerin etkisiz hale getirilmesi.', 8);

INSERT INTO gorev_aranan_suclu (gorev_id, suclu_id) 
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6),
       (7, 7),
       (8, 8),
       (9, 9),
       (10, 10);

insert into silah_asker(silah_id, asker_id)
VALUES (2, 1),
       (1, 2),
       (2, 3),
       (2, 4),
       (3, 5),
       (1, 6),
       (2, 7),
       (3, 8);

VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6),
       (7, 7),
       (8, 8),
       (9, 9),
       (10, 10);

CREATE TABLE silah_disi_asker (
    silah_disi_id INTEGER,
    asker_id INTEGER
);

-- Verileri ekle
INSERT INTO silah_disi_asker (silah_disi_id, asker_id) VALUES
(3, 1),
(1, 2),
(4, 3),
(5, 4),
(4, 5),
(2, 6),
(1, 7),
(1, 8);


--Teslimat miktarının mevcut stoklardan fazla olup olmadığını kontrol eder
CREATE OR REPLACE FUNCTION tedarikci_teslimat_kontrol()
RETURNS TRIGGER AS $$
DECLARE
    mevcut_stok INT;
BEGIN
    -- Mevcut stok miktarını al
    SELECT SUM(miktar) INTO mevcut_stok
    FROM silah
    WHERE teslim_id = NEW.teslim_id;

    -- Teslimat miktarının mevcut stoktan fazla olup olmadığını kontrol et
    IF mevcut_stok < NEW.miktar THEN
        RAISE EXCEPTION 'Teslim edilen miktar, mevcut stoktan fazla olamaz';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tedarikci_teslimat_onayla
BEFORE INSERT ON teslim
FOR EACH ROW
EXECUTE FUNCTION tedarikci_teslimat_kontrol();



-- Göreve katılan ve başarılı olan askerlerin maaşlarına 100TL ekleme yapılır
CREATE OR REPLACE FUNCTION gorev_basarili_asker_maas_artis()
RETURNS TRIGGER AS $$
BEGIN
    -- Eğer görev başarılı olduysa
    IF NEW.gorev_basarisi = 'başarılı' THEN
        -- Görevdeki askerin maaşını 100 TL artır
        UPDATE calisan
        SET maas = maas + 100
        WHERE calisan_id IN (SELECT calisan_id FROM gorevdeki_asker WHERE gorev_id = NEW.gorev_id);
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER gorev_basarili_asker_maas_artis_trigger
AFTER UPDATE ON gorev
FOR EACH ROW
EXECUTE FUNCTION gorev_basarili_asker_maas_artis();


-- Asker 50 yaşını geçmiş ve yüzbaşı değilse yüzbaşı olur
CREATE OR REPLACE FUNCTION rutbe_yas_kontrol()
RETURNS TRIGGER AS $$
BEGIN
    -- Yaşını kontrol et
    IF EXTRACT(YEAR FROM AGE(NEW.dogum_tarihi)) >= 50 THEN
        -- Eğer rütbesi 5 (Yüzbaşı) ve ondan küçükse, rütbesini Yüzbaşı yap
        IF NEW.rutbe_id < 5 THEN
            UPDATE asker
            SET rutbe_id = 5
            WHERE asker_id = NEW.asker_id;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER rutbe_yas_kontrol_trigger
AFTER INSERT OR UPDATE ON asker
FOR EACH ROW
EXECUTE FUNCTION rutbe_yas_kontrol();



-- Silah miktarı 10 un altına düşerse uyarı verir
CREATE OR REPLACE FUNCTION silah_sayisi_kontrol()
RETURNS TRIGGER AS $$
BEGIN
    -- Eğer silah miktarı 10'dan küçükse
    IF NEW.miktar < 10 THEN
        RAISE NOTICE 'Uyarı: Silah Adı: %, Miktar 10 adetin altına düştü!', NEW.silah_adi;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER silah_sayisi_kontrol_trigger
AFTER UPDATE ON silah
FOR EACH ROW
EXECUTE FUNCTION silah_sayisi_kontrol();


--18 Yaşını doldurmayanlar askeriyede çalışan olamaz
CREATE OR REPLACE FUNCTION yas_kontrol_eklemeden_once() 
RETURNS TRIGGER AS $$
BEGIN
    -- Yaşı hesapla (doğum_tarihi'ni kullanarak)
    IF EXTRACT(YEAR FROM AGE(NEW.dogum_tarihi)) < 18 THEN
        -- Eğer yaş 18'den küçükse hata mesajı ver
        RAISE EXCEPTION 'Kişi 18 yaşından küçük, işlem yapılamaz!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER yas_kontrol_trigger
BEFORE INSERT ON calisan
FOR EACH ROW
EXECUTE FUNCTION yas_kontrol_eklemeden_once();




