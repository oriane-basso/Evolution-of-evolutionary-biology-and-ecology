data{
  int Ob;  //number of samples across all series
  int N; // number of series
  real X[Ob]; 
  int groups[Ob]; // identificator of each observations 
  int index[N];
  int series_start[Ob];
}


parameters{
  real<lower=0> sigma;
  real rho[N];
  real aDrift[N];
  real mu;
  real<lower=0> rho_sig;
}

model {
  for(i in 1:Ob){   
    if(series_start[i]!=1)
      X[i] ~ normal(aDrift[groups[i]] + rho[groups[i]]*X[i-1],sigma);
    }
   
  sigma ~ cauchy(0,2.5);
  rho ~ normal(mu,rho_sig);
  mu ~ normal(0,1);
  aDrift ~ normal(0,0.1);
}

generated quantities{
  real XSim[Ob];
  real rho_overall;
  for(i in 1:N){
    XSim[index[i]] = 0; //?? I'm not sure about this part 
  }
  rho_overall = normal_rng(mu,rho_sig);
  
   for(i in 2:Ob){
      if(series_start[i]!=1)
      XSim[i] = normal_rng(aDrift[groups[i]] + rho[groups[i]]*XSim[i-1],sigma);
    }
   
  }

