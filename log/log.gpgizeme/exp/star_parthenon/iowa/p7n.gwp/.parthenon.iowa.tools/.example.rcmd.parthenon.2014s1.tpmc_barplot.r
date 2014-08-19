d <- read.table('dat.tpmc.txt')
#d
#d[2]
#matrix(data=unlist(d[2]), ncol=3, byrow=T)
mat <- matrix(data=unlist(d[2]), ncol=3, byrow=T)
colnames(mat) = c("XFS", "Ext4", "F2FS")

#rownames(mat) <- c("1of4:1", "2of4:4", "3of4:16", "4of4:64") # L3_C002:read_io_threads
#rownames(mat) <- c("1of4:1", "2of4:4", "3of4:16", "4of4:64") # L3_C003:write_io_threads
#rownames(mat) <- c("1of5:1", "2of5:2", "3of5:4", "4of5:8", "5of5:32") # L3_C009:purge_threads
rownames(mat) <- c("1of5:1", "2of5:30", "3of5:300", "4of5:3000", "5of5:5000") # L3_C010:purge_batch_size
#rownames(mat) <- c("1of6:5", "2of6:12", "3of6:37", "4of6:62", "5of6:87", "6of6:95") # L3_C013:old_blocks_pct
#rownames(mat) <- c("1of6:128", "2of6:256", "3of6:512", "4of6:1024", "5of6:2048", "6of6:4096") # L3_C018:lru_scan_depth
#rownames(mat) <- c("1of5:200", "2of5:1000", "3of5:10000", "4of5:100000", "5of5:1000000") # L3_C019:io_capacity
#rownames(mat) <- c("1of5:1", "2of5:10", "3of5:30", "4of5:100", "5of5:1000") # L3_C020:flushing_avg_loops 

barplot(t(mat), beside=T, legend.text=c("XFS", "Ext4", "F2FS"), col=rainbow(3), main="TpmC Result (Higher is Better)")
