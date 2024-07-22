![Repo1](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/Repo-SS/Title.png)

### Hazırlayan: Hüseyin UZUNYAYLA / OgnitorenKs
- ► Discord: https://discord.gg/zwCDKnAKSw
- ► Mail: ognitorenks@gmail.com
- ► Site: [https://ognitorenks.blospot.com](https://ognitorenks.blospot.com)
- ► Desteklenen diller = Turkish │ English

Çalışmanın tüm hakları Hüseyin UZUNYAYLA’ya aittir. Çalışma üzerinde geliştirme, kopyalama, içeriğini değiştirmek yasaktır. Uygulamayı farklı platformlar üzerinde paylaşmak isterseniz tarafımdan izin almanız gerekmektedir.

# EASYDISM

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/0.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/6.4.png)

- EasyDism Windows 10 - 11 sürümlerinin x64 mimarilerinde çalışmaktadır.
- Windows ekran ölçeklendirme ayarı Toolbox'ın pencere ayarını bozabilir.

<details><B><summary> 1 - WIM │ ESD okuyucu</B></summary>

Bu bölümde 'install.wim', 'instal.esd' ve 'boot.wim' dosyasının içeriğini görüntülüyebilirsiniz.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/1.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/1.2.png)

</details><details><B><summary> 2 - WIM ► ESD dönüştür</B></summary>

- install.wim dosyasını install.esd dosyasına dönüştürebilirsiniz. 
- Esd dönüştürme işlemi install.wim dosyasını oldukça sıkıştırıp boyutunu düşürecektir.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/2.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/2.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/2.3.png)

</details><details><B><summary> 3 - ESD ► WIM dönüştür</B></summary>

- install.esd dosyasını install.wim'e dönüştürebilirsiniz.
- install.esd dosyaları üzerinde yeniden işlem yapmak için öncelikle install.wim'e dönüştürülmelidir.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/3.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/3.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/3.3.png)

</details><details><B><summary> 4 - İndex çıkart</B></summary>

Bu bölümü aynı zamanda index silici olarak kullanabilirsiniz. Çünkü index silme işlemi install.wim içerisinde çöp dosyaları temizlemediği için boyutta azalma olmaz. Ancak 'index çıkarıcı' yeni oluşturacağı install dosyasına çöp dosyaları almayacağı için öncesinde düzenleme yaptıysanız boyutta azalma olacaktır.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/4.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/4.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/4.3.png)

Bu bölümde daha önceden çıkarma yaptıysanız ve dosyalarınızı EasyDism klasöründen almayı unutma durumunuza karşın yeni işlemlerde seçenekli işlem sunar. Yani Output klasörü içerisinde install.wim/esd dosyası varsa çıkarma işleminize göre uyarı verecektir.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/4.4.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/4.5.png)

</details><details><B><summary> 5 - Hepsi bir arada Windows Hazırla [AIO]</B></summary>

Farklı Windows sürümlerini tek bir ISO'da toplamanıza imkan tanır. Yani Windows 10 ve Windows 11 sürümlerinin birlikte olduğu tek bir install.wim dosyası oluşturmanıza imkan verir.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/5.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/5.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/5.3.png)

</details><details><B><summary> 6 - İmaj yükle [Mount]</B></summary>

İmaj dosyasını dizine çıkarmanızı sağlar. Birden fazla imajı çıkaramazsınız. İmaj tanımlandıktan sonra ana menüye içeriği hakkında bilgileri yazar.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/6.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/6.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/6.3.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/6.4.png)

</details><details><B><summary> 7 - Sürücü yükle</B></summary>

Dizine çıkarılmış imajlara sürücü yüklemenizi sağlar. Eklemek istediğiniz sürücüleri EasyDism uygulamasının yüklü dizininde 'Driver' klasörü içine atıp. Bu bölümü tuşlayıp çalıştırarak yükleme işlemini gerçekleştirebilirsiniz.

</details><details><B><summary> 8 - Regedit kayıtlarını yükle</B></summary>

İmaj içine regedit kayıtlarını entegre etmenizi sağlar. Yüklemek istediğiniz '.reg' dosyalarını EasyDism uygulamasının yüklü dizininde 'Regedit' klasörü içine atınız. Daha sonra bu bölümü çalıştırıp entegre işlemini başlatabilirsiniz. Bu kadar gelişmiş regedit kayıt entegrasyonunu başka bir uygulamada bulamazsınız.

</details><details><B><summary> 9 - Güncelleme yükle</B></summary>

Mount edilmiş imaj içine güncelleme yükleme imkanı sağlar. Yüklemek istediğiniz güncelleme dosyalarını EasyDism uygulamasının yüklü dizininde 'Update' klasörü için atınız. Daha sonra bu bölümü çalıştırıp yükleme işlemini gerçekleştirebilirsiniz. Bu bölüm işlem sonunda güncelleme çöp dosyalarını da temizleyecektir.

</details><details><B><summary> 10 - Format sonrası ilk açılışa batch script ekle</B></summary>

Mount edilmiş imaj içine sistem ilk açılışında çalışacak komut dosyası eklenir. Bu komut dosyası içine ilk açılışta çalışmasını istediğiniz script dosyalarını atabilirsiniz.
- Bu bölüme .bat .cmd .vbs .ps1 script dosyalarını atabilirsiniz. EasyDism yüklü olduğu dizini açıp ".Script-AfterSetup" klasörü içerisine dosyaları atın.
- Katılımsız program ekleyip ilk açılışta yükleme işlemini yapabilirsiniz. EasyDism yüklü olduğu dizini açıp ".Script-AfterSetup" klasörü içerisine dosyaları atın. Yalnızca katılımsız programları ekleyin.
- İlk açılışta uygulanması gereken .reg dosyalarını ekleyebilirsiniz. EasyDism yüklü olduğu dizini açıp ".Script-AfterSetup" klasörü içerisine dosyaları atın.
- Masaüstüne dosya ekleyebilirsiniz. EasyDism yüklü olduğu dizini açıp ".Desktop-AfterSetup" klasörü içerisine dosyaları atın. Boş klasörleri eklemeyecektir. Masaüstüne "EasyDism_OgnitorenKs" klasörü olarak ekleme yapacaktır.

</details><details><B><summary> 11 - İmaj topla [UnMount]</B></summary>

Mount edilmiş sistemi toplayıp install.wim haline getirir. Mount edilmiş imaj üzerinde yaptığınız düzenlemelerden sonra toplama işlemi sonrası install.wim'in boyutu düşeceğine artabiliyor. Bunun sebebi kaldırdığımız bileşenlerin çöp dosya olarak kalmasıdır. Bu bölüm mount edilen imajı toplarken indexleri önce ayrı dizine çıkarıp yeniden oluşturur. Böylece çöp dosyalar silindiği için boyutu da düşürecektir.

- Toplama işlemi sonrası ana menüdeki imaj bilgileri kaldırılacaktır.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/10.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/10.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/10.3.png)

</details><details><B><summary> 12 - ISO hazırla</B></summary>

UEFI ve Legacy BIOS kurulum için uygun ISO hazırlamanıza imkan tanır. ISO hazırlandıktan sonra oluşturulduğu klasör açılacaktır. Daha önceden yaptığınız işlemlerde unuttuğunuz aynı isimde ISO varsa öncesinde uyarı verecektir.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/11.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/11.2.png)

</details><details><B><summary> 13 - Windows Setup düzenle</B></summary>

Bu bölümde boot.wim dosyası içinde yer alan "Windows Setup" bölümü düzenlenir. Sırasıyla sorulacak işlemler;
- "Lerup Launch bar ve programları eklensin mi?" ► Bu ayar ile kurulum ekranında başlat menüsü gibi işlevsel bir WinPE uygulaması ekliyoruz. Ayrıca içerisinde Explorer++, AOMEI Partition Assistan gibi yardımcı programlar yer almaktadır. İşlemi kabul ederseniz ilgili dosyaları github deposundan indirip boot.wim içerisine entegre edecektir.
- "Windows 11 Bypass kayıtları entegre edilsin mi?" ► Windows 11 kurulum engellemelerini aşmak için bypass kayıtlarını boot.wim içerisine entegre eder.
- "Setup alanı görselleri değiştirilsin mi?" ► Bu sorunun gelmesi için; "background.bmp", "spwizimg.dll", "setup.bmp" dosyalarını düzenleyip EasyDism'in kurulu olduğu dizinde "Boot" klasörüne yerleştirmeniz gerekiyor. Yoksa bu bölümü atlayacaktır. Düzenleme detayları için blog sayfamdaki konuma bakabilirsiniz; https://ognitorenks.blogspot.com/2022/03/windows-setup-bolumu-nasl-duzenlenir.html
- "VMD sürücüleri yüklensin mi?" ► Yeni nesil Laptop cihazlarda geliştirilen bu özellik için Windows içerisine eklenmiş entegre sürücü bulunmuyor bundan dolayı kurulum esnasında diskler görüntülenemiyor. Bu tarz bir sorun yaşamamak için sürücüleri boot.wim içerisine entegre eder. İşlemi kabul ederseniz Github deposundan ilgili sürücüleri indirip, yükleyecektir.
- "Mount dizini toplansın mı?" ► işlemler tamamlandıktan sonra farklı bir düzenleme yapmayacaksanız değişiklikleri kaydedip mount dizinini toplamak istediğinizi soracaktır.

</details><details><B><summary> 14 - Mount yol tanımla</B></summary>

Bu bölümde daha önceden mount ettiğiniz bir imaj varsa onu seçip tanımladıktan sonra EasyDism üzerinde işlem yapmanıza imkan tanır. Tanımlamadan sonra ana menüde imaj hakkında bilgiler yazılacaktır.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/10.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/6.4.png)

</details><details><B><summary> 15 - EasyDism dil değiştirme</B></summary>

Açılışta varsayılan sistem diline göre otomatik seçim yapılmaktadır. Değiştirmek isterseniz bu bölümü kullanabilirsiniz.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/TR-SS/15.png)

</details>
