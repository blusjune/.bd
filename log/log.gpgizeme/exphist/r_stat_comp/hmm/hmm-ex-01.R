## http://cran.r-project.org/doc/contrib/Krijnen-IntroBioInfStatistics.pdf



viterbi <- function(A,E,x) {
	v <- matrix(NA, nr=length(x), nc=dim(A)[1]);
	v[1,] <- 0;
	v[1,1] <- 1;
	for (i in 2:length(x)) {
		for (l in 1:dim(A)[1]) {
			v[i,l] <- E[l,x[i]] * max(v[(i-1),] * A[l,]);
		}
	}
	return (v);
}



markov1 <- function(x,P,n) {
	seq <- x;
	for (k in 1:(n-1)) {
		seq[k+1] <- sample(x, 1, replace=T, P[seq[k],]);
	}
	return (req);
}


hmmdat <- function(A,E,n) {
	observationset <- c(1:6);
	hiddenset <- c(1,2);
	x <- h <- matrix(NA, nr=n, nc=1);
	h[1] <- 1;
	x[1] <- sample(observationset, 1, replace=T, E[h[1],]);
	h <- markov(hiddenset, A, n);

