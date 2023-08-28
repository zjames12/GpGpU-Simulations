library(GpGpU)

set.seed(1)
for (n1 in c(1e1, 5e3)){
  # n1 <- 100
  n2 <- 100
  n <- n1*n2
  locs <- as.matrix( expand.grid( (1:n1)/n1, (1:n2)/n2 ) )
  X <- cbind(rep(1,n),locs[,2])
  covparms <- c(2, 0.2, 0.75)
  # y <- fast_Gp_sim(covparms, "exponential_isotropic", locs, 50 )
  y <- rnorm(n)
  for (m in c(10, 20, 30)) {
    NNarray <- find_ordered_nn(locs, m)
    t <- proc.time()
    loglik2 <- GpGp::vecchia_profbeta_loglik_grad_info(covparms, "exponential_isotropic", y, X, locs, NNarray)
    tt <- proc.time()
    print(paste("n=",n," m=",m,"," ,(tt-t)[[3]]), sep = "")
  }
}
