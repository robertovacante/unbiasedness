
clear
local N = 5000
local rep = 100
matrix stats = J(`rep', 1, .)
forv i = 1/`rep' {
	clear
	qui set obs `N'
	gen x = runiform()
	qui sum x
	matrix stats[`i', 1] = r(sd)
}	
clear
qui set obs `rep'
svmat stats, n(sd)
gen sample_var = sd1^2
drop sd1

local var_unif = 1/12
ttest sample_var == `var_unif'

estpost sum
esttab using "$dir1/sample_var.tex", replace cells("mean(fmt(5)) sd(fmt(5)) min(fmt(5)) max(fmt(5))") nomtitle nonumber
drop sample_var
