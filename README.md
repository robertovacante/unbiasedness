# unbiasedness-simulation

This simulation-study proves the unbiasedness of the Sample Variance through a Monte-Carlo simulation in STATA.

## Introduction
Monte-Carlo methods are numerical techniques relying on random sampling to approximate results. This work performs a Monte-Carlo simulation in order to examine whether the sample variance is an unbiased estimator for the population variance. 

## Data generating

$X$ is a continuous random variable simulated from a uniform distribution such that $X∼U(a,b)$. 
It is known that, for $a=0$ and $b=1$

$$
\text{Var}(X)=\frac{(b-a)^2}{12}=0.8\overline{3}
$$


```s
gen x = runiform()
```

## Method

Firstly, we generate a fixed number of independent repetitions of the rv X with a fixed amount of observations each. Consequently, we replace those repetitions with their sample variances.

```s
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
```
Thus, we expect each sample variance to be approximately equal to $0.8\overline{3}$, as shown in the equation above. As a matter of fact, t-test result suggests a convergence of sample variance to our theoretical value, confirming that sample variance is an unbiased estimator of the population variance.

```s
local var_unif = 1/12
ttest sample_var == `var_unif'
```
## Output

<img width="643" alt="STATA-output" src="https://github.com/robertovacante/unbiasedness/assets/106596623/13842cc4-cb69-4ffc-b91c-8b5cc0bd487e">

