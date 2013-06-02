library(arules)
data <- list(
			 c("_a", "_b", "_c"),
			 c("_a", "_b"),
			 c("_a", "_b", "_d"),
			 c("_b", "_e"),
			 c("_b", "_c", "_e"),
			 c("_a", "_d", "_e"),
			 c("_a", "_c"),
			 c("_a", "_b", "_d"),
			 c("_c", "_e"),
			 c("_a", "_b", "_d", "_e")
			 )

t <- as(data, "transactions")
f <- eclat(data, parameter=list(support=0, tidLists=T))
dim(tidLists(f))
as(tidLists(f), "list")
image(tidLists(f))
inspect(f)
