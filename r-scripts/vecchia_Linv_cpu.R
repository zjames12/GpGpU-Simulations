library(GpGp)

print("Testing GpGpU")
set.seed(1)
x <- runif(1e6)
y <- runif(1e6)
df <- as.matrix(data.frame(x,y))

covparms <- c(1,2,3)


for (n in c(1e3, 1e4, 1e5, 1e6)){
        locs <- as.matrix(df[1:n,])
        for (m in c(10, 20, 30)){
                nn <- find_ordered_nn(locs, m)
                t <- proc.time()
                # Linv <- GpGpU::vecchia_Linv_gpu_isotropic_exponential(covparms, locs, nn)
                Lin <- GpGp::vecchia_Linv(covparms, "exponential_isotropic", locs, nn)
                tt <- proc.time()
                if (n != 1e3) {
                        print(paste("n=",n, "m=", m, (tt-t)[3]))
                        # print(paste("error=",  max(abs(Linv-Lin))))
                }
        }
}
