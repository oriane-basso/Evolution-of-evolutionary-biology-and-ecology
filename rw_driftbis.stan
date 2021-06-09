data{
  int L;
  vector[L] X;
}

parameters{
  real<lower=0> sigma;
  real aDrift;
}

model {
  for(t in 2:L){
    X[t] ~ normal(aDrift + X[t-1],sigma);
  }
  sigma ~ cauchy(0,2.5);
  aDrift ~ normal(0,0.1);
}
