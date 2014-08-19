#_ver=20140602_194416




p7n_barplot_kvVec2DArr <- function(data_file, num_cols, col_names, main_title) {


# b@supernova:c002.++ %3$ cat dat.tpmc.txt 
# L3_C002_1_of_4.m01_xfs 714.167
# L3_C002_1_of_4.m02_ext4 926.100
# L3_C002_1_of_4.m03_f2fs 391.283
# L3_C002_2_of_4.m01_xfs 688.817
# L3_C002_2_of_4.m02_ext4 819.000
# L3_C002_2_of_4.m03_f2fs 368.667
# L3_C002_3_of_4.m01_xfs 651.550
# L3_C002_3_of_4.m02_ext4 762.567
# L3_C002_3_of_4.m03_f2fs 352.983
# L3_C002_4_of_4.m01_xfs 623.100
# L3_C002_4_of_4.m02_ext4 704.700
# L3_C002_4_of_4.m03_f2fs 339.050
# 
# 
# p7n_data_file = "dat.tpmc.txt";
# p7n_main_title = "TpmC performance plot";
# envvar__p7n_num_cols = "P7N_NUM_COLS";
# envvar__p7n_col_names = "P7N_COL_NAMES";
# 
# 
# p7n_num_cols <- as.numeric(Sys.getenv(envvar__p7n_num_cols)); # num_cols <- as.numeric(Sys.getenv("P7N_NUM_COLS"));
# p7n_col_names <- strsplit(Sys.getenv(envvar__p7n_col_names), split=" ")[[1]]; # col_names <- strsplit(Sys.getenv("P7N_COL_NAMES"), split=" ")[[1]];
# p7n_barplot_kvVec2DArr(p7n_data_file, p7n_num_cols, p7n_col_names, p7n_main_title);


	# num_cols <- as.numeric(Sys.getenv(envvar__num_cols)); # num_cols <- as.numeric(Sys.getenv("P7N_NUM_COLS"));
	# col_names <- strsplit(Sys.getenv(envvar__col_names), split=" ")[[1]]; # col_names <- strsplit(Sys.getenv("P7N_COL_NAMES"), split=" ")[[1]];
	for (i in 1:num_cols) {
		print(col_names[i]);
	}

	kvVec2DArr <- read.table(data_file, as.is=T); # kvVec2DArr <- read.table('dat.kvVec2DArr.txt');
	num_items <- dim(kvVec2DArr)[1];
	num_testcases <- num_items / num_cols;
	tcname1 <- strsplit((kvVec2DArr$V1)[1], split="_")[[1]];
	tcname <- paste(tcname1[1], tcname1[2], sep="_");

	kvVec2DArr_mat <- matrix(data=unlist(kvVec2DArr$V2), ncol=num_cols, byrow=T);
	colnames(kvVec2DArr_mat) <- col_names;
	row_names <- list();
	for (i in 1:num_testcases) {
		row_names[i] = paste(i, "of", num_testcases, sep="_");
	}
	rownames(kvVec2DArr_mat) <- row_names;

	ymax <- max(kvVec2DArr_mat) * 1.2;
	yoff <- ymax / 50;
	kvVec2DArr_bp <- barplot(t(kvVec2DArr_mat), beside=T, legend.text=col_names, main=paste(main_title, ":", tcname), angle=45*(1:num_cols), density=30, col='darkgray', ylim=c(0,ymax));
	text(kvVec2DArr_bp, t(kvVec2DArr_mat) + yoff, t(kvVec2DArr_mat));

	return(kvVec2DArr_mat);


}




