data{
  int L;
  vector[L] X;
}

parameters{
  real<lower=0> sigma;
  real aDrift;
  real aConstant;
}

model {
  for(t in 1:L){
    X[t] ~ normal(aConstant + aDrift*t,sigma);
  }
  sigma ~ cauchy(0,2.5);
  aDrift ~ normal(0,0.1);
  aConstant ~ normal(0,1);
}
