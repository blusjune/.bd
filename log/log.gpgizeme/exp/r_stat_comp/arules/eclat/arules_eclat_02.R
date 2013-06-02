library(arules)
data <- list(
			 c("_addr_1187", "_addr_23813", "_addr_319275"),
			 c("_addr_1187", "_addr_23813"),
			 c("_addr_1187", "_addr_23813", "_addr_4489275"),
			 c("_addr_23813", "_addr_51276758"),
			 c("_addr_23813", "_addr_319275", "_addr_51276758"),
			 c("_addr_1187", "_addr_4489275", "_addr_51276758"),
			 c("_addr_51276758", "_addr_319275"),
			 c("_addr_1187", "_addr_23813", "_addr_4489275"),
			 c("_addr_319275", "_addr_51276758"),
			 c("_addr_1187", "_addr_23813", "_addr_4489275", "_addr_51276758"),
			 c("_addr_1187", "_addr_23813", "_addr_319275"),
			 c("_addr_51276758", "_addr_23813", "_addr_319275"),
			 c("_addr_1187", "_addr_4489275", "_addr_319275"),
			 c("_addr_4489275", "_addr_23813", "_addr_319275"),
			 c("_addr_4489275", "_addr_1187", "_addr_23813", "_addr_319275"),
			 c("_addr_319275", "_addr_23813", "_addr_51276758"),
			 c("_addr_23813", "_addr_4489275", "_addr_319275", "_addr_51276758"),
			 c("_addr_1187", "_addr_319275", "_addr_51276758"),
			 c("_addr_4489275", "_addr_23813", "_addr_51276758"),
			 c("_addr_319275", "_addr_51276758")
			 )

t <- as(data, "transactions")
f <- eclat(data, parameter=list(tidLists=T, support=0.25))
dim(tidLists(f))
as(tidLists(f), "list")
image(tidLists(f))
inspect(f)
