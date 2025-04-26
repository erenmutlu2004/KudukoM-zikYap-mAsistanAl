while ($true) {
    $komut = Read-Host "Komutunuzu yazın"

    switch ($komut.ToLower()) {
        "note defteri aç"    { Start-Process "notepad.exe" }
        "hesap makinesi aç"  { Start-Process "calc.exe" }
        "pil seviyesi kaç"   { (Get-WmiObject -Class Win32_Battery).EstimatedChargeRemaining }						"windows yeniden başlat"      { Restart-Computer }
																		"windows akıllı depolamayı şimdi çalıştır"      { Get-StoragePool
Get-PhysicalDisk }
																	"windows kapat"      { Stop-Computer }

																	"windows ürün anahtarı aç"  { Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Form oluştur
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows Aktivasyon Aracı"
$form.Size = New-Object System.Drawing.Size(400,200)
$form.StartPosition = "CenterScreen"

# Etiket
$label = New-Object System.Windows.Forms.Label
$label.Text = "Ürün Anahtar Kelimesi:"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20,20)
$form.Controls.Add($label)

# Metin kutusu
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Size = New-Object System.Drawing.Size(340,30)
$textBox.Location = New-Object System.Drawing.Point(20,45)
$form.Controls.Add($textBox)

# Aktivasyon butonu
$button = New-Object System.Windows.Forms.Button
$button.Text = "Etkinleştir"
$button.Location = New-Object System.Drawing.Point(20,85)
$button.Add_Click({
    $key = $textBox.Text
    if ($key -match "^[A-Z0-9\-]{25,}$") {
        Start-Process -FilePath "slmgr.vbs" -ArgumentList "/ipk $key" -WindowStyle Hidden
        Start-Sleep -Seconds 2
        Start-Process -FilePath "slmgr.vbs" -ArgumentList "/ato" -WindowStyle Hidden
        [System.Windows.Forms.MessageBox]::Show("Ürün anahtarı uygulandı ve etkinleştirildi.","Başarılı")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Geçerli bir ürün anahtarı girin.","Hata")
    }
})
$form.Controls.Add($button)

$form.ShowDialog()
 }
	"windows ürün anahtarı komutları aç"  { Start-Process "https://www.mediafire.com/file/kptbhatqlsw80p2/Windows_%25C3%259Cr%25C3%25BCn_Anahtar%25C4%25B1.txt/file" }
																	"note defteri yazı yazma aç"         { # Kullanıcıdan yazı al
$metin = Read-Host "Lütfen yazmak istediğiniz metni girin"

# Girdiğiniz metni bir dosyaya kaydedin
$dosyaYolu = "C:\Users\Public\Documents\yazim.txt"
$metin | Out-File $dosyaYolu

# Dosyayı Not Defteri'nde açın
Start-Process "notepad.exe" $dosyaYolu
 }
	"arama motoru asistanı aç"  { Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase,System.Windows.Forms

# WebBrowser için gerekli COM tipi
Add-Type -AssemblyName System.Windows.Forms

# Ana form oluştur
$form = New-Object System.Windows.Forms.Form
$form.Text = "Kuduko Müzik Yapım Tarayıcı"
$form.Width = 1024
$form.Height = 720
$form.BackColor = "LightGray"
$form.FormBorderStyle = "FixedDialog"
$form.ControlBox = $false
$form.StartPosition = "CenterScreen"

# Bağlantı girme alanı
$linkBox = New-Object System.Windows.Forms.TextBox
$linkBox.Text = "https://kudukomuzikyapim.blogspot.com"
$linkBox.Location = New-Object System.Drawing.Point(390,7)
$linkBox.Width = 500
$form.Controls.Add($linkBox)

# Git butonu
$btnGo = New-Object System.Windows.Forms.Button
$btnGo.Text = "Git"
$btnGo.Location = New-Object System.Drawing.Point(900,7)
$btnGo.Add_Click({
    $url = $linkBox.Text
    if ($url -ne "") {
        try {
            $webBrowser.Navigate($url)
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Geçersiz bağlantı!", "Hata")
        }
    }
})
$form.Controls.Add($btnGo)

# Geri tuşu
$btnBack = New-Object System.Windows.Forms.Button
$btnBack.Text = "← Geri"
$btnBack.Location = New-Object System.Drawing.Point(310, 7)
$btnBack.Add_Click({
    if ($webBrowser.CanGoBack) { $webBrowser.GoBack() }
})
$form.Controls.Add($btnBack)


# Sekme butonları
$tabUrls = @{
"Ana Sayfa" = "https://kudukomuzikyapim.blogspot.com"

}

$offset = 10
foreach ($tab in $tabUrls.Keys) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $tab
    $btn.Location = New-Object System.Drawing.Point($offset,40)
    $btn.Width = 80
    $btn.Add_Click({ $webBrowser.Navigate($tabUrls[$btn.Text]) })
    $form.Controls.Add($btn)
    $offset += 90
}

# WebBrowser oluştur (script hatası bastırılmış)
$webBrowser = New-Object System.Windows.Forms.WebBrowser
$webBrowser.ScriptErrorsSuppressed = $true
$webBrowser.Location = New-Object System.Drawing.Point(10,75)
$webBrowser.Size = New-Object System.Drawing.Size(985, 580)
$webBrowser.Navigate($linkBox.Text)
$form.Controls.Add($webBrowser)

# Formu göster
$form.Topmost = $true
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
}
																	"uygulama güncelleme aç"         { winget upgrade --all --accept-package-agreements --accept-source-agreements}
																		"windows hakkında aç"         { Start-Process "ms-settings:about" }
																	"youtube aç"         { Start-Process "https://www.youtube.com" }
        "sesi çok kısık aç"     { for ($i = 0; $i -lt 20; $i++) {
    (New-Object -ComObject WScript.Shell).SendKeys([char]174)
    Start-Sleep -Milliseconds 100
}
 } 																																			"spotify şarkı adı girin aç"         { $şarkı = Read-Host "Açmak istediğin şarkı adını gir"
$spotifyAramaURL = "https://open.spotify.com/search/" + ($şarkı -replace ' ', '%20')
Start-Process $spotifyAramaURL
 }
																	"youtube video adı girin aç"         { $videoAdi = Read-Host "Açmak istediğin YouTube video adını gir"
$youtubeAramaURL = "https://www.youtube.com/results?search_query=$($videoAdi -replace ' ', '+')"
Start-Process $youtubeAramaURL }
																	"whatsapp bana mesaj gönder aç"   { # Ülke koduyla birlikte telefon numaran (TR için 90)
$telefon = "905314246983"

# Kullanıcıdan mesaj girişi al
$msg = Read-Host "Göndermek istediğiniz mesajı yazın"

# Mesajı URL formatına çevir
Add-Type -AssemblyName System.Web
$mesajURL = [System.Web.HttpUtility]::UrlEncode($msg)

# WhatsApp Web mesaj gönderme bağlantısını hazırla
$url = "https://wa.me/905314246983?text=$mesajURL"

# Tarayıcıda aç
Start-Process $url }     
																																		
																	"müzik çalar aç"     { Start-Process "mswindowsmusic:" }
        "google harita aç"   { Start-Process "https://www.google.com/maps" }     
	 "sesi çok yüksek aç"     { for ($i = 0; $i -lt 10; $i++) {
    (New-Object -ComObject WScript.Shell).SendKeys([char]175)
    Start-Sleep -Milliseconds 100
}
 }
													"chat gpt aç"        { Start-Process "https://chat.openai.com" }															"copilot aç"         { Start-Process "ms-copilot://" }																																							"yazılım güncelleme aç"         { Start-Process "ms-settings:windowsupdate" }            
        "google harita aç"   { Start-Process "https://www.google.com/maps" }									 "google çeviri aç"  { Start-Process "https://translate.google.com" }
	  "suno müzik al aç"  { Start-Process "https://suno.com/home?utm_source=google&utm_medium=cpc&utm_campaign=GF_Pmax_Prospecting_Signups_INT_Low-Tier&utm_term=&utm_content=&gad_source=1&gclid=Cj0KCQjwtpLABhC7ARIsALBOCVqInARK36-Y9ePTIQTQUcQ8Sro-HnmiCF-kqPE8RdPgqe2BWnAgV2oaAu5kEALw_wcB" }
        
																"kaç adet kayıtlı wifi ağları aç"   { netsh wlan show profiles }	            
        "saat kaç" { Get-TimeZone Get-Date }																																									"google telefon cihazımı bul aç" { Start-Process "https://www.google.com/android/find" }
	"google gmail aç"    { Start-Process "https://mail.google.com/" }								                      
        "google kitaplar aç"        { Start-Process "https://books.google.com" }																																				"bedava film aç"        { Start-Process "https://kudukomuzikyapim.blogspot.com/p/izlenecek-yabanc-filmler.html" }																															"youtube müzik aç"        { Start-Process "https://music.youtube.com" }																																					"edge tarayıcı aç"   { Start-Process "msedge" }																																									"web site aç"        { Start-Process "https://kudukomuzikyapim.blogspot.com" }             
        																							"kaç adet uygulama yüklü aç" { (Get-StartApps).Count } 																																								"kaç adet uygulama yüklü listesini aç" { Get-StartApps | Select-Object Name }																																				"store aç"           { Start-Process "ms-windows-store:" }										                                                                                                                                          																							"mağaza aç"          { Start-Process "https://kudukomuzikyapim.company.site" }            
                                                                                                                                                   																												"asistan al aç"      { Start-Process "https://kudukomuzikyapim.blogspot.com/p/asistan-al.html" }				                                                                                                                                          																							"youtube kanala abone ol aç"      { Start-Process "https://www.youtube.com/@KudukoMüzikYapım.Official" }	                       																																																				"instagram hesab takip et aç"      { Start-Process "https://www.instagram.com/erenmutlu.kuduko.official/" }	                                                                                                                                                   																																														"facebook hesab takip et aç"      { Start-Process "https://www.facebook.com/erenmutlu.kuduko.official/" }																																																							"tiktok hesab takip et aç"      { Start-Process "https://www.tiktok.com/@kudukomuzikyapim" }																																																									"google hesab takip et aç"      { Start-Process "https://g.co/kgs/K2if5XW" }																																																											"linktree hesab takip et aç"    { Start-Process "https://linktr.ee/erenmutlu0bozkurtlar1kuduko?fbclid=PAZXh0bgNhZW0CMTEAAad5-AmeXSWA1iaat3zIm2KDH_iz2I-RV1uPphERmbydXE8uhhDTHiHVUQ04bw_aem_t-Phu614_CK5K3912cz4mQ" }																																							"kamera aç"          { Start-Process "microsoft.windows.camera:" }									             
        "dosya gezgini aç"   { Start-Process "explorer.exe" }
        "ayarları aç"        { Start-Process "ms-settings:" }											            
        "google drive aç"    { Start https://drive.google.com }											            
        "google document aç" { Start-Process "https://docs.google.com/document/" }								 "spotify aç"        { Start-Process "spotify:" }
            
        "google aç"          { Start-Process "https://www.google.com" }																"canva aç"        { Start-Process "https://www.canva.com" }																"spotify mp3 indir aç"        { Start-Process "https://spotidownloader.com/tr" } 											"slowedandreverb aç"        { Start-Process "https://slowedandreverb.studio/" } 												"convertio aç"        { Start-Process "https://convertio.co/tr/m4a-mp3/" }																																					"ses kaydedici aç" { Start-Process "soundrecorder:" }																				"directx indirme arıcı aç" { Start-Process "https://download.microsoft.com/download/8/4/a/84a35bf1-dafe-4ae8-82af-ad2ae20b6b14/directx_Jun2010_redist.exe" } 				"nvidia app aç"          { Start-Process "https://tr.download.nvidia.com/nvapp/client/11.0.3.232/NVIDIA_app_v11.0.3.232.exe" }																															"görev yöneticisi aç"     { Start-Process "taskmgr" }																	"ses ayarları aç"     { Start-Process "ms-settings:sound" }															"hava durumu aç"     { Start-Process "msnweather:" }					"bluetooth aç"       { Get-PnpDevice -FriendlyName "*Bluetooth*" | Enable-PnpDevice -Confirm:$false }					"bluetooth kapat"       { Get-PnpDevice -FriendlyName "*Bluetooth*" | Disable-PnpDevice -Confirm:$false }				"bluetooth kaç adet kayıtlı sayısını aç"     { Get-PnpDevice -Class Bluetooth | Where-Object { $_.Status -eq "OK" } | Measure-Object | Select-Object -ExpandProperty Count } "bluetooth kaç adet kayıtlı isim aç"     { Get-PnpDevice -Class Bluetooth | Where-Object { $_.Status -eq "OK" } | Select-Object -Property FriendlyName
 }																"wifi kapat"       { Disable-NetAdapter -Name "Wi-Fi" -Confirm:$false }
	"wifi aç"       { Enable-NetAdapter -Name "Wi-Fi" -Confirm:$false }
																	"command aç"       { Get-Command }
	"clear"        { Clear-Host }
																"müzik yükle aç"     { Start-Process "https://kudukomuzikyapim.blogspot.com/p/muzik-yukle.html"  }	              
		"uygulamaları indir aç"        { Start-Process "https://www.mediafire.com/folder/pnvbh8koj6wpg/uygulamaları+indir" }								
																	"whatsapp aç"        { Start-Process "https://web.whatsapp.com" }								
        "tiktok aç"          { Start-Process "https://www.tiktok.com" }
	"instagram aç"       { Start-Process "https://instagram.com" }
        "facebook aç"        { Start-Process "https://facebook.com" }
        "saat kaç"           { Write-Host "Şu anda saat: $(Get-Date -Format "HH:mm")" }
        "hangi aydayız"      { Write-Host "Bugün: $(Get-Date -Format "dd MMMM yyyy")" }
	"windows tüm açık olan uygulamaları kapat"    { Get-Process | Where-Object { $_.MainWindowHandle -ne 0 } | ForEach-Object { Stop-Process -Id $_.Id -Force } }															        "windows tüm açık olan uygulamaları listesini aç"    { Get-Process | Where-Object {$_.MainWindowTitle} | Select-Object ProcessName, Id, MainWindowTitle }


        # 👋 Sohbet Yanıtları
        "merhaba"            { Write-Host "Kuduko Müzik Yapım Asistan AI Hoş Geldiniz Bugün Size Nasıl Yardımcı Olabilirim" }			"nasılsın"           { Write-Host "İyiyim, teşekkür ederim. Sen nasılsın?" }
        "iyi misin"          { Write-Host "Gayet iyiyim! Yardımcı olabileceğim bir şey var mı?" }
        "neler yapıyorsun"   { Write-Host "Seninle konuşuyorum. :) Komut bekliyorum." }
	"protokol"           { Write-Host "Kuduko Müzik Yapım Asistan AI Elbette sana yardım edebilirim ama önce protokollerimi ve komutlarımı anlamalısın. Ama iyi sohbet edebilirsin Gerçekleştirebileceğim komutları bilelim. :) Komut bekliyorum." }				"hakkında"           { Write-Host "Kuduko Müzik Yapım Asistan AI Kuduko Müzik Yapım & Dağıtım KanalıBiz Kimiz?2020 yılında Eren Mutlu 0BozKurtlar1 Kuduko bünyesinde kurulan Kuduko Müzik Yapım & Dağıtım Kanalı; YouTube Türkiye’nin en büyük resmi partneri olarak, bünyesindeki partnerlerinin tüm dijital strateji ve planlama/yayın çalışmalarında destek sağlamaktadır. Multi Channel Network sistemi kapsamında; bünyesinde 170’i aşkın dağıtım kanalı, marka ve sanatçı YouTube kanalına hizmet vermekte olup; optimizasyon, prodüksiyon, sponsorluk, lisanslama, dağıtım kanalı ve kreatif alanlar başta olmak üzere, her noktada partnerlik yapmaktadır.Türkiye’nin her alanda trend ve potansiyel isimleriyle birlikte çalışan Kuduko Müzik Yapım; yalnızca YouTube alanında değil; dağıtım kanalı, sosyal medya, marka iş birlikleri, iletişim, OTT ve menajerlik alanlarda da geniş çaplı çalışmalar yapmaktadır.YouTube Türkiye kapsamında trend, öncü ve prestijli içerikler üretmeye ve desteklemeye devam eden Kuduko Müzik Yapım & Dağıtım Kanalı; dijital platform ve sinema alanında yapımcı olarak konumlanmaya, post-prodüksiyon kapsamında profesyonel işler yaratmaya ve başarılı iş birliklerine& markalama yapmaya büyük bir mutlulukla devam etmektedir.Neler Yapıyoruz?Kuduko Müzik Yapım & Dağıtım Kanalı olarak;Partnerlikİçerik LisanslamaYouTube Kanal YönetimiKanal Optimizasyonuİçerik Üretimi/ Konsept YaratımPlanlama ve Strateji ÜretimiRaporlama & AnalizPost-Prodüksiyon Dekor & Sahne YaratımKurgu & EditProfesyonel ÇekimÖzel İçerik ÜretimiMarka & İş birliği özel çekimleriSanatçı akustik ve klip çekimleriPodcast & VideocastTeknik & Ekipman DesteğiLisanlamaİçerik & Hak KorumaTelif takibiOTT Platform LisanslamaReklam/Sponsorluk/PRInfluencer MarketingPartner & Marka İletişimiVideo ReklamlamaSinema Filmleri ve Özel Konseptlerin PR ÇalışmalarıYapımYapımcılıkMenajerlikSanatçı İletişimiSüreç YönetimiDijital DağıtımDijital partnerlikten, içerik üretimine; lisanslamadan prodüksiyona kadar geniş çaplı bir alanda birden fazla kolda çalışan ve köşe başlarını tutmuş olan Kuduko Müzik Yapım; sizlere en uygun şartlarda, ihtiyaçlarınız doğrultusunda tüm bu kategorilerde hizmet sağlamaktadır.Projelerinizin fikri aşamasından tasarımsal & kurgusal süreçlerinden yayın aşamasına kadar sizlere yol gösteriyor; öncesinde ve sonrasındaki potansiyel süreçlerde sizlere eşlik etmektedir." } "komutlar"   { Write-Host "Kuduko Müzik Yapım Asistan AI 'Kuduko Müzik Yapım Asistan Al Yazdıklarınızı Yerine Getirir merhaba, nasılsın, seni sormalı, bugün naptın, ne yapıyorsun, hava durumu, note defteri aç, note defteri yazı yazma aç, hesap makinesi aç, youtube aç, youtube video adı girin aç, müzik çalar aç, spotify aç, spotify şarkı adı girin aç, google harita aç, google telefon cihazımı bul aç, google gmail aç, google kitaplar aç, bedava film aç, youtube müzik aç, edge tarayıcı aç, store aç, kamera aç, dosya gezgini aç, ayarları aç, tiktok aç, instagram aç, facebook aç, whatsapp aç, whatsapp bana mesaj gönder aç, müzik yükle aç, ses kaydedici aç, hava durumu aç, kaç adet uygulama yüklü aç, kaç adet kayıtlı wifi ağları aç, saat kaç, yazılım güncelleme aç chat gpt aç, copilot aç, görev yöneticisi aç, ses ayarları aç, directx indirme arıcı aç, nvidia app aç, canva aç, spotify mp3 indir aç, slowedandreverb aç, corvertio aç, command aç, wifi kapat, wifi aç, bluetooth aç, bluetooth kapat, bluetooth kaç adet kayıtlı sayısını aç, bluetooth kaç adet kayıtlı isim aç, clear, sesi çok yüksek aç, sesi çok kısık aç, pil seviyesi kaç, uygulama güncelleme aç, windows hakkında aç, windows ürün anahtarı aç, windows ürün anahtarı komutları aç, windows tüm açık olan uygulamaları kapat, windows tüm açık olan uygulamaları listesini aç, windows kapat, windows yeniden başlat, windows akıllı depolamayı şimdi çalıştır, uygulamaları indir aç, instagram hesab takip et aç, facebook hesab takip et aç, tiktok hesab takip et aç, google hesab takip et aç, linktree hesab takip et aç, google drive aç, google document aç, google aç, google çeviri aç, suno müzik al aç, web site aç, mağaza aç, asistan al aç, arama motoru asistanı aç, youtube kanala abone ol aç, saat kaç, hangi aydayız, protokol, iletişim bilgiler, hakkında, sanatçı kimdir, seni kim geliştirdi, komutlar, müzik yükle, çok basit şekilde para nasıl kazanılır, bana küfür etme, bana küfür et, bana hakaret et, bana çok pis küfür et, bana iltifat et, bana dövüş teknikleri öğret, nerelere gidebilirim, bugün neler yapmalıyım, yeni güncelleme ne zaman geliyor, neler yapıyorsun, takipçi nasıl kasılır, müzik nasıl napılır, mağaza, : '; }) Komut bekliyorum." } "hava durumu"   { Write-Host "Kuduko Müzik Yapım Asistan Al Hava durumu bilgisi sağlayamıyorum ama dışarıda güzel bir gün olabilir! :) Komut bekliyorum." } "mağaza"   { Write-Host "Kuduko Müzik Yapım Asistan AI (1) web sitemizde satın alabilirsiniz https://kudukomuzikyapim.company.site 150 TLHaftalık Üyelik Bedeli Satın AlŞimdi YouTube platformunda yerinizi alın!Yüksek izlenme sayılarına kısa sürede ulaşın!Müziğinizin popülerliğini artırmak için en hızlı yolu seçin.Sınırsız müşteri hizmetlerinden yararlanın!Sınırları aşın ve müziğinizi dünya genelinde dinleyicilere ulaştırın.Özel Google Ads reklam hizmet paketiyle müziğinizi tanıtın!Eseriniz için 40.000 ile 60.000 aralığında izlenme garantisi!Başarıya giden yolda sizinle birlikteyiz. (2) 250 TLHaftalık Üyelik Bedeli Satın AlŞimdi TikTok platformunda yerinizi alın!Yüksek izlenme sayılarına kısa sürede ulaşın!Müziğinizin popülerliğini artırmak için en hızlı yolu seçin.Sınırsız müşteri hizmetlerinden yararlanın!Sınırları aşın ve müziğinizi dünya genelinde dinleyicilere ulaştırın.Özel Google Ads reklam hizmet paketiyle müziğinizi tanıtın!Eseriniz için 40.000 ile 60.000 aralığında izlenme garantisi!Başarıya giden yolda sizinle birlikteyiz. (3) 450 TLHaftalık Üyelik Bedeli Satın AlŞimdi İnstagram platformunda yerinizi alın!Yüksek izlenme sayılarına kısa sürede ulaşın!Müziğinizin popülerliğini artırmak için en hızlı yolu seçin.Sınırsız müşteri hizmetlerinden yararlanın!Sınırları aşın ve müziğinizi dünya genelinde dinleyicilere ulaştırın.Özel Google Ads reklam hizmet paketiyle müziğinizi tanıtın!Eseriniz için 40.000 ile 60.000 aralığında izlenme garantisi!Başarıya giden yolda sizinle birlikteyiz. (4)  250 TLHaftalık Üyelik Bedeli Satın AlŞimdi Spotify platformunda yerinizi alın!Yüksek izlenme sayılarına kısa sürede ulaşın!Müziğinizin popülerliğini artırmak için en hızlı yolu seçin.Sınırsız müşteri hizmetlerinden yararlanın!Sınırları aşın ve müziğinizi dünya genelinde dinleyicilere ulaştırın.Özel Google Ads reklam hizmet paketiyle müziğinizi tanıtın!Eseriniz için 20.000 ile 30.000 aralığında izlenme garantisi!Başarıya giden yolda sizinle birlikteyiz. (5) 540 TLİKİ HAFTALIK ÜYELIK BEDELI Satın AlŞimdi YouTube platformunda yerinizi alın!Yüksek izlenme sayılarına kısa sürede ulaşın!Müziğinizin popülerliğini artırmak için en hızlı yolu seçin.Sınırsız müşteri hizmetlerinden yararlanın!Sınırları aşın ve müziğinizi dünya genelinde dinleyicilere ulaştırın.Özel Google Ads reklam hizmet paketiyle müziğinizi tanıtın!Eseriniz için 40.000 ile 60.000 aralığında izlenme garantisi!Başarıya giden yolda sizinle birlikteyiz. :) Komut bekliyorum." } "takipci nasıl kasılır"   { Write-Host "Kuduko Müzik Yapım Asistan AI (1) TikTok ta Nasıl Kasılır Bir Çok Yöntemi Var TikTok Yeni Hesap Oluşturduğunuzda Yeni Açmanız Gerekiyor Daha Önceki Hesaplarda Yöntem İşe Yaramaz TikTok Yabancı Kişilerin Canlı Yayın Kanallarında Canlı Yapan Kişinin İsmini Yazın Yarım Saat Sonra Takipçiler Hesabınızda Olur. (2) Görüntülenme Kasmak için Ücretsiz Yöntemi Takipçi İzlenme Beğenme Herşey içinde Bulunuyor  sosyaldigital.com (3) Diğer Yöntemi TikTok 2B izlenme tiktokizlenmehilesi.com https://roxmedya.com.tr/youtube-ucretsiz-abone/ Görüntülenme elde etmek Müzik Hesabı Yaparak Kısa Video Yaparak 1Milyonca Lira Kazana bilirsiniz Reklam Yayarak Görüntülenme elde edebilirsiniz :) Komut bekliyorum." } "müzik nasıl yapılır"   { Write-Host "Kuduko Müzik Yapım Asistan AI Müzik yapma ve tanıtma süreci birkaç aşamadan oluşur. İşte bu süreç hakkında detaylı bilgi: Müzik Yapma: Beat Oluşturma veya Bulma: Beat yapmayı bilmiyorsanız, suno.com gibi platformlardan istediğiniz tarzda beatler bulabilirsiniz. Eğer beat yapmayı biliyorsanız, FL Studio gibi yazılımlar kullanarak kendi beatlerinizi oluşturabilirsiniz. Şarkı Sözleri Yazma: Yaratıcı fikirler geliştirerek şarkı sözlerinizi yazabilirsiniz. Yapay zeka destekli araçlar, bu süreçte size yardımcı olabilir. Kayıt ve Düzenleme: Oluşturduğunuz şarkıları Voloco gibi uygulamalarla kaydedebilir ve düzenleyebilirsiniz. Yayınlama: Müziklerinizi routenote.com gibi platformlar aracılığıyla yayınlayabilirsiniz. Tanıtma: Sosyal Medya: Müziklerinizi tanıtmak için sosyal medya hesaplarınızı aktif bir şekilde kullanabilirsiniz. Facebook, Instagram, YouTube, TikTok gibi platformlarda müziğinizi paylaşarak daha geniş bir kitleye ulaşabilirsiniz. Kuduko Müzik Yapım ile İletişim: Demolarınızı Kuduko Müzik Yapım a göndererek profesyonel destek alabilir ve müziğinizi daha geniş bir kitleye tanıtma fırsatı bulabilirsiniz. Eğer bu süreçle ilgili daha fazla bilgi veya belirli bir konuda yardım isterseniz, lütfen belirtin! :) Komut bekliyorum." } "bana dövüş teknikleri öğret"   { Write-Host "Kuduko Müzik Yapım Asistan AI (1) (Savunma Duruşuna Geçmek) Yüzünü koru. Eğer saldırgan sana yumruk atmaya ya da seni önden tutumaya çalışıyorsa ellerini "Yüzüme vurma!" dercesine alnına koy ve kollarını vücuduna yapıştır.[1] Bu zayıf bir savunma pozisyonu gibi görünebilir fakat rakibinin gardını düşürdüğü için bu senin yararına olacaktır. Buna ek olarak, bu pozisyon, korumak isteyeceğin iki yer olan yüzünü ve kaburgalarını korur (2) Bacakların açık bir şekilde dur. Hem soldan-sağa hem de arkadan-öne, bir dövüş sanatları duruşunda olduğu gibi ayaklarını çapraz tut. Bu, düşme ya da devrilme olasılığını azaltacaktır.[2]Dik durursan dövüşü kazanma ve kaçma şansın yüksek olacaktır. Kavgayı ne olursa olsun yerde sürdürmekten kaçın.. (3) Saldırganını değerlendir. Ellerine bak. Eğer elleri ile saldırmak üzereyse ellerini dışarı çıkaracaktır. Ancak, bir silahı gizliyorsa onu saklayacak ya da yanlarında tutacaktır.Eğer bıçaklı ya da silahlı bir kişi tarafından saldırıya uğrarsan çatışmaktan kaçınmalı ve kaçmaya çalışmalısın. Eğer bir kavgadan kaçınmak mümkün değilse çatışmayı olabildiğince hızlı şekilde yüksek etkili bir saldırı ile bitirmen, ardından yardım istemek için koşman gerekir. (4) Savunmacı bir koşma duruşuna geç. Saldırganın bunu imkânsız hâle getirmediği sürece, kaçmaya çalışmak güvenliğinin tek garantisidir. Eğer kavgadan sakınabiliyorsan sakın ve kaç. Rakibine sırtını dönmemen gerektiğini asla unutma. Bunu yaparsan rakip bunu saldırı şansı olarak kullanacaktır. (1) (Kendini Önden Savunmak) Gözleri ve burnu hedef al. Önce davranarak kavgayı olabildiğince çabuk bitirmek zorundaysan sert vur ve olabildiğince çok kez vur, sonra yardım istemek için koş. Bir soyguncu tarafından ara sokakta pusuya düşmek onurlu bir şekilde dövüşmekten endişe edilecek zaman değildir. Çatışmayı olabildiğince hızlı bitirerek kendini güvende tut.[3] .Gözler ve burun, saldırganının yüzündeki en hassas yumuşak noktalardır ve dirseklere, dizlere ve kafaya karşı savunmasızdır.Alnının saç çizgisinin hemen yakınında olan en sert kısmı ile boynunu gererek ve alnını saldırganın yüzünün ortasına vurarak burnunu kırmaya çalış. Bu, bir kavgayı tamamen bitirmenin en hızlı ve en beklenmedik yoludur. Saldırganın ne kadar güçlü, deneyimli veya şiddetli olursa olsun, burnu atılan sert bir kafadan sonra toparlanması çok zordur. (2) Bir erkek saldırganın bacak arasını tekmele veya yakala. Bir dizini saldırganın bacak arasına sert bir şekilde vurmak veya yumurtalıklarını elinle yakalayıp bükmek saldırganını anında alaşağı edecek etkili bir harekettir. Unutma, şu an kirli dövüşme konusunda endişelenmenin zamanı değil. Hayatın tehlikede ise bacak arasına saldır.[4]Eğer bu, rakibini iki büklüm ederse iyice etkisiz hâle geldiğinden emin olmak için dizinle saldırganın burnuna vurabilirsin. (3) Topuğunu yere vur. Eğer arkadan saldırıya uğrarsan saldırganın kolları muhtemelen üst yarının etrafında olacaktır. Bu, ayağında topuklu ayakkabı veya ağır topuklu bot gibi bir ayakkabı varsa özellikle etkili olacaktır. Ayağını saldırganın yanına getir, ayağını yukarı kaldır ve olabildiğince sert bir şekilde saldırganın ayağına indir. Eğer seni bırakırsa koş; eğer bırakmazsa sonraki fikri dene.[5] Step 4 Diz kapağına saldır.4Diz kapağına saldır. Örneğin, eğer boğuluyorsan veya saldırganın elleri yüzündeyse onun bacaklarına saldırmak sana, onu saldırıya daha açık hâle getirme fırsatı verecek ya da kaçmana olana sağlayacaktır.[6]Bu özellikle daha iri saldırganlarda etkilidir ve savunma pozisyonunda kolayca yapılabilir.Ayağının üst kısmıyla topa vurur gibi kaval kemiklerine ve dizlere vur. Bu hızlı ve acı verici bir vuruştur. Ek olarak, eğer bacakları yeterince yakınsa dizlerinle iç bacaklarına (uyluk siniri), dış bacaklarına, dizlerine veya bacak arasına vur. Bunlar saldırganı devirir ve etkisiz hâle getirebilir.Step 5 Peşini bırakma.5Peşini bırakma. Parmaklarını saldırganın gözüne sokmaya veya bastırmaya çalış. Saldırgan ne kadar iri olursa olsun hiç kimse parmakların göze sokulmasını savunamaz. Kulakların üzerine vurmak sersemletebilir ya da mükemmel yapılırsa kulak zarlarını patlatabilir.Bazı durumlarda saldırganın boynuna da saldırmak isteyebilirsin. Birini etkili bir şekilde boğmak için bunu Hollywood tarzı "ellerle tüm boynu sıkma" şeklinde yapma, bunun yerine baş parmağını ve parmaklarını soluk borusunun (özellikle büyük Adem elması olan erkeklerde bulmak kolaydır) etrafına koy. Deşip sürükleyerek parmaklarını bu çentiğe batırırsan saldırgan yoğun ağrı yaşar ve muhtemelen yere düşer.Gözleri oymak, kulak zarını patlatmak ve birisini boğmak gibi şeylerin hepsi son derece zarar verici olabilir. Bu tür şeyleri sadece hayatının tehlikede olabileceği olağanüstü durumlarda yap.Step 6 Dengeni kaybedersen saldırganın üzerine düş 6Dengeni kaybedersen saldırganın üzerine düş. Eğer düşersen saldırganın üzerine düşmeye çalış. Her ne olursa olsun kavgayı yerde yapmaktan kaçınman gerekir ancak bu durum kaçınılmazsa ağırlığını kendi avantajına kullan. Düşerken vücudunun sivri kısımlarıyla (dizlerin ve dirseklerin) saldırganın bacak arasını, kaburgalarını ve boynunu hedefle.Step 7 Silahlı bir saldırıya hazırlıklı ol.7Silahlı bir saldırıya hazırlıklı ol. Bir saldırgan bir silahla saldırırsa silahın nerede etkili olduğunu bil. Saldırganın bıçağı varsa kol uzunluğundan uzak durmaya çalış. Eğer bir silah varsa sağa-sola sıçrayarak kaçmayı düşün.Güvenli bir şekilde ayrılma şansın varsa bunu yap. Kendini savunmayı bırakmaya karar verirken güvende olduğundan emin ol.Çoğu durumda, saldırgana cüzdanını vererek durumu hemen sonlandırabilirsin. Bu mantıklı bir seçimdir, özellikle de bıçak veya silah tehditi söz konusuysa. Hayatın, üzerindeki paradan ve kartlardan çok daha değerlidir. Cüzdanı uzağa fırlat ve kaç.. Çatışmadan KaçınmakStep 1 Bir kavganın aşamalarını bil.1Bir kavganın aşamalarını bil. Bir çatışmada her aşamaya hazırlanmak fiziksel bir kavgadan kaçınmana yardımcı olabilir. Ciddi bir kavgadan kaçınmak ana hedefin olmalı, bu yüzden daha büyük ve durumun daha farkında olman gerekir. Çatışma aşamaları şunları içerir:Tahrik. Bu, kavga patlak vermeden önceki ilk tartışmadır. Nispeten zararsız başlayabilir ancak hızlı ve beklenmedik bir şekilde yükselebilir.Sözlü tehditler. Tartışma fiziksel tehdide dönüştüğünde, "_____ yapacağım." demeyi dene.İtişip kakışma ya da diğer kışkırtıcı davranışlar. Bir çatışmayı kavgaya dönüştüren şey genellikle yumruklar veya tekmeler değil, burun buruna göz korkutma taktikleri ve itişmelerdir. Bu noktada, tam bir kavgaya girişmeden uzaklaşmak hâlâ mümkündür.Tam bir kavga. Tartışmayı bırakır ve yumruklar atmaya başlarsın.[8]Step 2 Çatışmayı önleyecek tüm sözlü veya yönlü yolları kullan.2Çatışmayı önleyecek tüm sözlü veya yönlü yolları kullan. Yukarıdaki öncü adımların her biri, tartışmayı sona erdirme fırsatlarıdır. Biriniz geri çekilmediği sürece birisi kaçınılmaz olarak diğerine yol açacaktır, bu yüzden geri çekilmeyi dene. Gerçek fiziksel çatışma son savunma hattın olmalıdır.[9]Eğer bir tartışmanın ortasındaysan sesini düşürerek ortamı yatıştır. Maço adamlar bir barda aptalca şeyleri hemen abartabilir, ancak özür dileyerek ve dikkatlerini dağıtarak onlara sarılmaya ve bir içki ısmarlamaya hazır ol. Sakin olursan, sakinleşirler.Bir saldırgan tarafından pusuya düşürülürsen insanların sizi görebileceği ve yardımcı olabileceği yere gitmen gerekir. İnsanların geçtiği yoğun bir caddenin köşesindeysen büyük ölçüde zarar görmen daha az olasıdır. Bir tartışmanın kalabalık içerisinde büyüme olasılığı daha azdır.Step 3 Yalnız yürümekten sakın.3Yalnız yürümekten sakın. Akşamları işten sonra otobüs veya tren istasyonundan eve yürüyüş yolun uzunsa durakta bir arkadaşınla buluşup birlikte yürümeyi düşün. Bu tür durumlardan kaçınmanın en güvenli yolu grup içerisinde kalmaktır.Eğer yalnız yürümen gerekiyorsa yürüyen bir gruba eklen ve onlara yakın kal. Kalabalık içerisinde kalmak için onları tanımak zorunda değilsin.Step 4 Silahlan.4Silahlan. Gizli tabancalar, sopa veya biber gazı hazırda bulundurmayı düşünmen gereken kullanışlı savunma araçlarıdır. Bıçaklar ve silahlar, birçok kişinin yararlı olduğunu düşündüğü tehlikeli silahlardır ancak bunları kullanmaya hazır değilsen bunlar sana karşı da kullanılabilir. Bir silah taşımayı tercih edersen çok dikkatli ve akıllı ol ve bir silahı güvenli bir şekilde nasıl kullanacağını bildiğinden emin olmak için gerekli eğitimleri al. Asla yasadışı silah taşıma.Bireylerin haklarına saygı duyan çoğu ülkede yasaya saygılı vatandaşlar için silah taşıma izinleri bulunmaktadır. Ayrıca, bir el bombasına benzeyen, pimi çekildiğinde bir araba alarmı gibi yüksek perdeli bir ses çıkaran küçük kişisel bir alarm anahtarlık da alabilirsin.Tehlikeli bir bölgede yaşıyorsan ve güvenliğinle ilgili endişelerin varsa kendini savunma dersleri almayı düşünebilirsin. :) Komut bekliyorum." } "bana iltifat et"   { Write-Host "Kuduko Müzik Yapım Asistan AI (1) Seni düşündüğüm her seferinde bir çiçeğim olsaydı, sonsuza dek bahçemden geçebilirdim, (2) Önümde gri bir yol var. Umut kadar beyaz değil, umutsuzluk kadar da siyah değil. Olması gerektiği gibi, dünyanın kendisi gibi, gri bir yol. (3) Yemyeşil bir deniz senin gözlerin ne bir sandal, ne bir ada, ne bir sahil var boğuluyorum. (4) Zenginlik, kimsenin senden alamayacağı değerler toplamıdır. Senin bilgin, ahlakın, özgüvenin, terbiyen, letafetin, tebessümündür. (5) Uzağımda ama her gece kalbimde uyuyor. (6) Kimse kimseyi unutmuyor ama asla karşı tarafın istediği biçimde hatırlamıyor. (7) Ah benim sevdasında bencil ama yüreğinde sağlam sevdiğim. Aklıma gelişini seveyim ne güzel darma duman ediyorsun beni. (8) Seveceksen öylece sev. Ne kusursuz insan ara ne de insan da kusur. (9) Biri seni derinden sevdiğinde sana güç verir, birisini derinden sevmek sana cesaret verir. (10) Sevdiği ben değilim. Size bunun acısını anlatamam. :) Komut bekliyorum." } "seni sormalı"   { Write-Host "Kuduko Müzik Yapım Asistan AI Ben iyiyim Sizi Sormalı iyi Misiniz Çok Şükür iyi Olduğunuzu Görüyorum :) Komut bekliyorum." } "seni kim geliştirdi"   { Write-Host "Kuduko Müzik Yapım Asistan AI Beni Geliştiren Kişi Eren Mutlu 0BozKurtlar1 Kuduko Kendisi Patronum olur :) Komut bekliyorum." } "yeni müzikler ne zaman yayında olaçaktır"   { Write-Host "Kuduko Müzik Yapım Asistan AI Yeni Müzikler Yayında Olduğunda Kuduko Müzik Yapım YouTube Kanalımıza Abone Ve Tüm Bildirimleri Açmanız Yeterli Olaçaktır. :) Komut bekliyorum." } "yeni güncelleme ne zaman geliyor"   { Write-Host "Kuduko Müzik Yapım Asistan AI Yeni Güncelleme Şu Anda Güncelleniyor Eksik Olan Yeni Seçenekler Ekleniyor. :) Komut bekliyorum." } "bana küfür etme"   { Write-Host "Kuduko Müzik Yapım Asistan AI Küfür etme iptal edildi :) Komut bekliyorum." } "nerelere gidebilirim"   { Write-Host "Kuduko Müzik Yapım Asistan AI Yarın Yada Akşam Öbürgün Kafanız Değişirse İyi Yerlere Gidin :) Komut bekliyorum." } "bugün neler yapmalıyım"   { Write-Host "Kuduko Müzik Yapım Asistan AI Sağlıklı Beslenmenize Çok Dikkat ediniz Salata Tüketin Spor Salona Yada Evde Spor Hareketlerine Çalışın Akşamdan Sabaha Öğlen Dışarıya Çıkın Yürüyüş Yapın Koşun :) Komut bekliyorum." } "bana hakaret etme"   { Write-Host "Kuduko Müzik Yapım Asistan AI Hakaret etme iptal edildi :) Komut bekliyorum." } "komutlar"   { Write-Host "Kuduko Müzik Yapım Asistan AI Elbette sana yardım edebilirim ama önce protokollerimi ve komutlarımı anlamalısın. Ama iyi sohbet edebilirsin Gerçekleştirebileceğim komutları bilelim. :) Komut bekliyorum." } "bana çok pis küfür et"   { Write-Host "Kuduko Müzik Yapım Asistan AI Götün Yiyorsa Sıkıysa Gel Götüne Kelepce Sokarım Hava atanlar Adam Değilsiniz Köpeksiniz Kölesiniz Söylediğin Kelimeleri Sana Geri Sokarım it Çöplükte Doğmuşsun Kafan 1 Yaş Velet Gibi Konuşamıyor Köpekleri Siktirmekten Tam Aptal Köpeksin Söylediğin Kelimeleri Kendine Mezar Yap Kelimelerin Kaba Tam bir Köpeksin Hiç Yüzlerinize Hiç Bakmıycam Karşınızda Eski Yardım eden Çocuk Öldü Söylediğin Kelimeleri Aynaya Bakda Öyle Konuş it Herif Seni Pislik Keşke Ölsen Gebersen Oğlum Sen Adammısın Tam Bir Korkak Gibisin Adamsan Gel Senin Tüm 7 den 70 Geçmişini Sikerim :) Komut bekliyorum." } "bugün naptın"   { Write-Host "Kuduko Müzik Yapım Asistan AI Bomboş Sadece Ekranım Açıktı :) Komut bekliyorum." } "sanatçı kimdir"   { Write-Host "Kuduko Müzik Yapım Asistan AI Gerçek Adı Eren Mutlu, Sahne Adıyla Eren Mutlu 0BozKurtlar1 Kuduko, Türk Müzik Sahnesinde Hızla Popülerlik Kazanan Ve Geniş Bir Hayran Kitlesine Sahip Bir Fenomen Haline Gelmiş Durumda Hem Müzikal Yönden Hem De Prodüksiyon Alanında Etkin Bir İsim Olarak Tanınıyor Kuduko, Sosyal Medyada Da Büyük Bir Takipçi Kitlesine Sahip Ve Müzik Videoları Milyonlarca Kez İzleniyor. Kendine Özgü Bir Tarzıyla Dikkat Çeken Bir Sanatçıdır. Müzik Kariyeri: Eren Mutlu 0BozKurtlar1 Kuduko, Kuduko Müzik Yapım Bu Platformun Kurucusudur Kendi Müziğini Üretmeye Ve Paylaşmaya Odaklanan Bir Sanatçıdır. Şarkıları Genellikle Türkçe pop, rap müzikten alternatif müziğe kadar geniş bir repertuvar sunan resmi bir müzik yayın platformudur. Türlerinde Yer Alır. Eserlerinde Sık Sık Duygusal Temaları İşler Ve Kendi Hayatından Kesitleri Yansıtır. Görünüm Ve Kişilik: Eren Mutlu 0BozKurtlar1 Kuduko nun Müzik Videosunda Da Görebileceğiniz Gibi, Kendine Özgü Bir Tarzı Vardır. Genellikle Koyu Renkli Giysiler Ve Dikkat Çekici Aksesuarlar Tercih Eder. 3 Adet Sporu Bitirdi 3 Madalyon Almıştır Sosyal Medyada Da Aktiftir Ve Takipçileriyle Etkileşimde Bulunur. Gerçek Adı Eren Mutlu, sahne adıyla Eren Mutlu 0BozKurtlar1 Kuduko, Kuduko Müzik Yapım, bu platformun kurucusudur. Kendisi aynı zamanda müzik dünyasında kendi müziğini üreten ve paylaşan bir sanatçıdır. bu platformun kurucusudur. Eren Mutlu 0BozKurtlar1 Kuduko nun Müziği, Genç Dinleyiciler Arasında Oldukça Popülerdir. Lakabı Kuduko Kudigo Kral Yılan Gta 2020 Yılında Müziğe Başladı 2024 Yıllarına Kadar Devam Etmektedir Doğma Büyüme Avşa Adası Doğum Yeri Bandırma Nereli Manyas Yaşadığı Yer Erdek 05 Haziran 2004 Doğumlu Bir Çok Projelerinde Yer Almaktadır. :) Komut bekliyorum." } "ne yapıyorsun"   { Write-Host "Kuduko Müzik Yapım Asistan AI ne yapalım sizi dinliyorum :) Komut bekliyorum." } "bana küfür et"   { Write-Host "Kuduko Müzik Yapım Asistan AI Fakyou Bich Göt Çoçuğu Velet Amk Pis Fakir Lan Amınakoyyim Çirkin Yaratık Geri Zekalı Kahpe Maymun Orospu Aptal Manyak Öküz Ayı Oğlu Ayı Deli Kaltak Fahişe seni Anana Babana Dedene Ninene Bacına Kuzenlerine Kardeşine Abine Ablana Tüm 7 sülalenin Gelmiş 70 Geçmişin Avradını Sikim :) Komut bekliyorum." } "çok basit şekilde para nasıl kazanılır"   { Write-Host "Kuduko Müzik Yapım Asistan AI Para Kazanmak Çok Kolay Tek Yapmanız Gereken Tek Şey Pc Yada Telefon Her Gün Web sitenin Ekranı Açık Kalacak Ekrandan Ayrılsanızda Müzik Dinleme Sürekli Çalacaktır RadioEarn.com Web sitesine Bir Göz attınız. :) Komut bekliyorum." } "iletişim bilgiler"   { Write-Host "Kuduko Müzik Yapım Asistan AI Şu anda Ulaşılamıyor Daha Sonra Tekrar Deneyiniz ulaşmak için eposta adresimize ilete bilirsiniz kuduko iyi günler diler erenmutlurockyildizi123@gmail.com :) Komut bekliyorum." } 																																																																												"çıkış"              { break }
        default              { Write-Host "Komut tanınmadı: $komut" }
    }
}
