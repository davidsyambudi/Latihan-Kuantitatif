*--------------------------------------------------------------
* Analisis Pengaruh Pendapatan terhadap Pengeluaran Makanan
* Data: food.dta dari Principles of Econometrics
*--------------------------------------------------------------

* 1. Import data
use "http://www.principlesofeconometrics.com/poe4/data/stata/food.dta", clear

* 2. Lihat isi data
browse

* 3. Visualisasi hubungan pengeluaran makanan dan pendapatan
twoway (scatter food_exp income) ///
       (lfit food_exp income), ///
       title("Scatter Plot: Pengeluaran Makanan vs Pendapatan") ///
       legend(label(1 "Data") label(2 "Linear Fit"))

* 4. Transformasi variabel
gen income_kuadrat = income^2
gen ln_income      = ln(income)

* 5. Estimasi model regresi
eststo clear
eststo model1: reg food_exp income
eststo model2: reg food_exp income_kuadrat
eststo model3: reg food_exp ln_income

* 6. Tampilkan hasil regresi di layar
esttab model1 model2 model3, ///
    b(%9.3f) se star(* 0.1 ** 0.05 *** 0.01) ///
    mtitles("Linear" "Kuadrat" "Logaritmik") ///
    label

* 7. (Opsional) Ekspor hasil regresi ke file Word
esttab model1 model2 model3, b(%9.3f) se star(* 0.1 ** 0.05 *** 0.01)