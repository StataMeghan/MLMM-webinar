use https://www.stata-press.com/data/r19/fifeschool.dta, clear
keep if pid==2 | pid==4 |  pid==90

twoway (scatter attain vrq, msize(2.5) mcolor(black)) (lfit attain vrq, lcolor(black) lwidth(thick)), legend(off) xtitle("X") ytitle("Y")
graph export ols.png


twoway (scatter attain vrq, colorvar(pid) colordiscrete colorlist(stc1 stc2 stc3) msize(2.5) clegend(off)), xtitle("X") ytitle("Y")
graph export scatter_col.png

twoway (scatter attain vrq, colorvar(pid) colordiscrete colorlist(stc1 stc2 stc3) msize(2.5) clegend(off)) (lfit attain vrq, lcolor(black) lwidth(thick)), legend(off) xtitle("X") ytitle("Y")
graph export ols_col.png


twoway (scatter attain vrq, colorvar(pid) colordiscrete colorlist(stc1 stc2 stc3) msize(2.5) clegend(off)) ///
(lfit attain vrq if pid==2, lcolor(stc1) lwidth(thick)) (lfit attain vrq if pid==4, lcolor(stc2) lwidth(thick)) (lfit attain vrq if pid==90, lcolor(stc3) lwidth(thick)), xtitle("X") ytitle("Y") 

addlegend: (circle, msize(2.5)) "Cluster 1" || (circle, msize(2.5)) "Cluster 2" || (circle, msize(2.5)) "Cluster 3" 


* loop through
twoway (scatter attain vrq, colorvar(pid) colordiscrete colorlist(stc1 stc2 stc3) msize(2.5)  clegend(off)) ///
(lfit attain vrq, lcolor(black) lwidth(thick)), xtitle("X") ytitle("Y") legend(off) ylabel(0(2)11)
graph export graph1.svg, replace


twoway (scatter attain vrq, colorvar(pid) colordiscrete colorlist(stc1 stc2 stc3) msize(2.5)  clegend(off)) ///
(lfit attain vrq, lcolor(black) lwidth(thick)) ///
(pci 0.411 72 9.933 120, lcolor(stc1) lwidth(thick)) ///
(pci 2.4880312 80 9.8283354 117, lcolor(stc2) lwidth(thick)) ///
(pci 3.8553112 88 9.8069092 118, lcolor(stc3) lwidth(thick)) ///
, xtitle("X") ytitle("Y") legend(off) ylabel(0(2)11)
graph export graph2.svg, replace

twoway (scatter attain vrq, colorvar(pid) colordiscrete colorlist(stc1 stc2 stc3) msize(2.5) clegend(off)) ///
(lfit attain vrq, lcolor(black) lwidth(thick)) ///
(lfit attain vrq if pid==2, lcolor(stc1) lwidth(thick)) (lfit attain vrq if pid==4, lcolor(stc2) lwidth(thick)) (lfit attain vrq if pid==90, lcolor(stc3) lwidth(thick)), xtitle("X") ytitle("Y") legend(off) ylabel(0(2)11)
graph export graph3.svg, replace
