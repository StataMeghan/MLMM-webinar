
use math
list in 50/60, sepby(schid)
codebook schid

regress math homework ses c.ratio##schtype

quietly  margins, at(homework=(0/7)) plot

regress math homework ses c.ratio##schtype, vce(cluster schid)

xtset schid
xtreg math homework ses c.ratio##schtype, mle

mixed math homework ses c.ratio##schtype || schid: , stddev
estat icc

quietly margins, at(homework=(0/7)) plot

predict u, reffects reses(s)
egen tagme = tag(schid)
egen rank = rank(u) if tagme
serrbar u s rank if tagme, scale(1.96) yline(0) mvopts(mlabel(schid))

mixed math homework || schid: , stddev

predict yhat1, fitted
sort schid homework
twoway (line yhat1 homework, connect(ascending))

mixed math homework || schid: homework, cov(unstructured) stddev

predict yhat2, fitted
sort schid homework
twoway (line yhat2 homework, connect(ascending))
