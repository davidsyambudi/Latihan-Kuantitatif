*==============================================================*
* Analisis Harga Rumah Berdasarkan Lokasi: Golden Oaks vs University Town
*==============================================================*

* Muat data
use utown, clear

* Deskripsi dan ringkasan data
describe
summarize

*==============================================================*
* Visualisasi Distribusi Harga Rumah per Wilayah
*==============================================================*

* Histogram untuk Golden Oaks
histogram price if utown==0, width(12) start(130) percent ///
    xlabel(130(24)350) ///
    title("Golden Oaks: Distribusi Harga Rumah ($1000)") ///
    legend(off)
graph save utown_0, replace

* Histogram untuk University Town
histogram price if utown==1, width(12) start(130) percent ///
    xlabel(130(24)350) ///
    title("University Town: Distribusi Harga Rumah ($1000)") ///
    legend(off)
graph save utown_1, replace

* Gabungkan dua histogram secara vertikal
graph combine "utown_0" "utown_1", col(1) iscale(1)
graph save combined, replace

* Alternatif: histogram by group (otomatis berdasarkan utown)
label define utownlabel 0 "Golden Oaks" 1 "University Town"
label value utown utownlabel

histogram price, by(utown, cols(1)) ///
    start(130) percent ///
    xlabel(130(24)350) ///
    title("Distribusi Harga Rumah Berdasarkan Lokasi") ///
    legend(off)
graph save combined2, replace

*==============================================================*
* Statistik Deskriptif Harga Rumah per Wilayah
*==============================================================*
summarize price if utown==0
summarize price if utown==1
by utown, sort: summarize price
bysort utown: summarize price

*==============================================================*
* Regresi Harga Rumah terhadap Lokasi
*==============================================================*
regress price utown

* Uji beda rata-rata (t-test)
ttest price, by(utown)

*==============================================================*
* Uji Asumsi Klasik Regresi
*==============================================================*

* Prediksi residual dan nilai taksiran (fitted value)
predict resid, resid
predict yhat, xb

* 1. Uji Normalitas Residual (Shapiro-Wilk)
*    H0: residual terdistribusi normal
swilk resid

* 2. Uji Heteroskedastisitas (Breusch-Pagan)
estat hettest

* 3. Visualisasi: Residual vs Nilai Prediksi
rvfplot, yline(0)

* 4. Visualisasi: Distribusi Residual (Q-Q plot)
qnorm resid

* Catatan:
* - Multikolinearitas tidak relevan karena hanya ada satu variabel prediktor.
* - Autokorelasi tidak relevan untuk data cross-sectional.

*==============================================================*
* Selesai
*==============================================================*
