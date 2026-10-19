clear
set linesize 90

** load dataset and take a look
use math
list in 50/60, sepby(schid)
codebook schid

** linear regression
regress math homework ses c.ratio##schtype
quietly  margins, at(homework=(0/7)) plot
regress math homework ses c.ratio##schtype, vce(cluster schid)

** mlmms
xtset schid
xtreg math homework ses c.ratio##schtype, mle
mixed math homework ses c.ratio##schtype || schid: , stddev
estat icc

** interpretation
quietly margins, at(homework=(0/7)) plot
predict u, reffects reses(s)
egen tagme = tag(schid)
egen rank = rank(u) if tagme
serrbar u s rank if tagme, scale(1.96) yline(0) mvopts(mlabel(schid))

** random-intercept model
mixed math homework || schid: , stddev
predict yhat1, fitted
sort schid homework
twoway (line yhat1 homework, connect(ascending))

** random-slope model
mixed math homework || schid: homework, cov(unstructured) stddev
predict yhat2, fitted
sort schid homework
twoway (line yhat2 homework, connect(ascending))
