#!/home/blusjune/.b/x/sys/bin/x.0007/R -f
## Apriori algorithm (for Association Rule Mining)
##_ver=20130530_151301




library(arules);
library(arulesViz);




tr <- read.transactions("teste", format="basket", sep=",");
inspect(tr);
image(tr);
itemFrequencyPlot(tr, support=0.1);
length(tr);

rules <- apriori(tr, parameter=list(supp=0.5, conf=0.5));
inspect(rules);
summary(rules);
interestMeasure(rules,
				c("support",
				  "chiSquare",
				  "confidence",
				  "conviction",
				  "cosine",
				  "coverage",
				  "leverage",
				  "lift",
				  "oddsRatio"
				  ),
				tr);

# to calculate a single measure and add it to the quality slot:
quality(rules) <- cbind(quality(rules), hyperConfidence = interestMeasure(rules, method="hyperConfidence", Income));
inspect(head(SORT(rules, by="hyperConfidence")));




