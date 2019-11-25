myfn <- list.files("/pfs/input/", full.names=TRUE)
slices <- list()

for(fn in myfn){
	temp <- readRDS(fn)
	parTable <- do.call(rbind,temp[[3]])
	# print(head(rownames(parTable)))
	# print(str(temp[[3]]))
	n <- cbind("aac_recomputed" = as.numeric(unlist(temp[[1]]))/100, 
					"ic50_recomputed" = as.numeric(unlist(temp[[2]])), 
					"HS" = as.numeric(unlist(parTable[,1])),
					"E_inf" = as.numeric(unlist(parTable[,2])),
					"EC50" = as.numeric(unlist(parTable[,3]))) 
	print(head(rownames(n)))
	rownames(n) <- names(temp[[3]])
	slices[[fn]] <- n
}

res <- do.call(rbind, slices)

save(res, file="/pfs/out/profiles.RData")