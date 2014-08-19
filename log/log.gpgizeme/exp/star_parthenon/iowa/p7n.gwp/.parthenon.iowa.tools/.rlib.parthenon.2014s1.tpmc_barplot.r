#_ver=20140602_194416


source('.rlib.parthenon.2014s1.barplot.r'); # to use p7n_barplot_kvVec2DArr();


p7n_data_file = "dat.tpmc.txt";
p7n_main_title = "TpmC performance plot";
envvar__p7n_num_cols = "P7N_NUM_COLS";
envvar__p7n_col_names = "P7N_COL_NAMES";


p7n_num_cols <- as.numeric(Sys.getenv(envvar__p7n_num_cols)); # num_cols <- as.numeric(Sys.getenv("P7N_NUM_COLS"));
p7n_col_names <- strsplit(Sys.getenv(envvar__p7n_col_names), split=" ")[[1]]; # col_names <- strsplit(Sys.getenv("P7N_COL_NAMES"), split=" ")[[1]];
tpmc_mat <- p7n_barplot_kvVec2DArr(p7n_data_file, p7n_num_cols, p7n_col_names, p7n_main_title);




