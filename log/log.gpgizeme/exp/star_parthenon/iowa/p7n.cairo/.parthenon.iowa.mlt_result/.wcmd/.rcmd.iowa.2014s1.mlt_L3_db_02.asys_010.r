#_author="Brian M. JUNG <brian.m.jung@gmail.com>";
#_ver=20140511_213226;
#_ver=20140512_230621;
#_ver=20140519_211144;




#sink('/dev/null');

#img_w = 2048
#img_h = 2048
img_w = 1024
img_h = 1024

datafile_in <- Sys.getenv("_DATAFILE_IN")

radix <- datafile_in;
radix <- gsub(pattern=".tmp.", replacement="", radix);
radix <- gsub(pattern=".txt", replacement="", radix);
#print (datafile_in)




#
# https://dev.mysql.com/doc/refman/5.6/en/innodb-buffer-pool-stats-table.html
# mysql> select * from information_schema.innodb_buffer_pool_stats limit 1;
#
# | POOL_ID | POOL_SIZE | FREE_BUFFERS | DATABASE_PAGES | OLD_DATABASE_PAGES | MODIFIED_DATABASE_PAGES | PENDING_DECOMPRESS | PENDING_READS | PENDING_FLUSH_LRU | PENDING_FLUSH_LIST | PAGES_MADE_YOUNG | PAGES_NOT_MADE_YOUNG | PAGES_MADE_YOUNG_RATE | PAGES_MADE_NOT_YOUNG_RATE | NUMBER_PAGES_READ | NUMBER_PAGES_CREATED | NUMBER_PAGES_WRITTEN | PAGES_READ_RATE | PAGES_CREATE_RATE | PAGES_WRITTEN_RATE | NUMBER_PAGES_GET | HIT_RATE | YOUNG_MAKE_PER_THOUSAND_GETS | NOT_YOUNG_MAKE_PER_THOUSAND_GETS | NUMBER_PAGES_READ_AHEAD | NUMBER_READ_AHEAD_EVICTED | READ_AHEAD_RATE | READ_AHEAD_EVICTED_RATE | LRU_IO_TOTAL | LRU_IO_CURRENT | UNCOMPRESS_TOTAL | UNCOMPRESS_CURRENT |
#
# | POOL_ID | POOL_SIZE | FREE_BUFFERS | DATABASE_PAGES | OLD_DATABASE_PAGES | MODIFIED_DATABASE_PAGES | PENDING_DECOMPRESS | PENDING_READS | PENDING_FLUSH_LRU | PENDING_FLUSH_LIST | PAGES_MADE_YOUNG | PAGES_NOT_MADE_YOUNG | PAGES_MADE_YOUNG_RATE | PAGES_MADE_NOT_YOUNG_RATE | NUMBER_PAGES_READ | NUMBER_PAGES_CREATED | NUMBER_PAGES_WRITTEN | PAGES_READ_RATE | PAGES_CREATE_RATE | PAGES_WRITTEN_RATE | NUMBER_PAGES_GET | HIT_RATE | YOUNG_MAKE_PER_THOUSAND_GETS | NOT_YOUNG_MAKE_PER_THOUSAND_GETS | NUMBER_PAGES_READ_AHEAD | NUMBER_READ_AHEAD_EVICTED | READ_AHEAD_RATE | READ_AHEAD_EVICTED_RATE | LRU_IO_TOTAL | LRU_IO_CURRENT | UNCOMPRESS_TOTAL | UNCOMPRESS_CURRENT |
#




d <- read.table(datafile_in)
colnames(d) <- c(
		"bpid_tag", # 1
		"tstamp_a", # 2
		"tstamp_b", # 3
		"bpid",
		"bpsz",
		"bpsz_free",
		"dbpg",
		"dbpg_old",
		"dbpg_mod",
		"pend_decomp",
		"pend_read",
		"pend_flush_lru",
		"pend_flush_list",
		"pg_young",
		"pg_no_young",
		"pg_young_rate",
		"pg_no_young_rate",
		"npg_read",
		"npg_crea",
		"npg_writ",
		"pg_rate_read",
		"pg_rate_crea",
		"pg_rate_writ",
		"npg_get",
		"hit_rate",
		"young_mk_per_1k_gets",
		"no_young_mk_per_1k_gets",
		"npg_ra",
		"npg_ra_evic",
		"ra_rate",
		"ra_evic_rate",
		"lru_io_tot",
		"lru_io_cur",
		"uncomp_tot",
		"uncomp_cur"
		);


library(psych);
png(filename=paste("img.mlt_L3_db_02__corr.", radix, ".png", sep=""), width=img_w, height=img_h, units="px")
pairs.panels(d[c(
			#"bpid",
			#"bpsz",
			"bpsz_free",
			"dbpg",
			"dbpg_old",
			"dbpg_mod",
			"pend_decomp",
			"pend_read",
			"pend_flush_lru",
			"pend_flush_list",
			"pg_young",
			"pg_no_young",
			"pg_young_rate",
			"pg_no_young_rate",
			"npg_read",
			"npg_crea",
			"npg_writ",
			"pg_rate_read",
			"pg_rate_crea",
			"pg_rate_writ",
			"npg_get",
			"hit_rate",
			"young_mk_per_1k_gets",
			"no_young_mk_per_1k_gets",
			"npg_ra",
			"npg_ra_evic",
			"ra_rate",
			"ra_evic_rate",
			"lru_io_tot",
			"lru_io_cur",
			"uncomp_tot",
			"uncomp_cur"
			)]);
dev.off()




