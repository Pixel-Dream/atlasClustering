# Example
library(spatialLIBD)
library(atlasClustering)
## Connect to ExperimentHub
#ehub <- ExperimentHub::ExperimentHub()
## Download the small example sce data
#spe <- fetch_data(type = "spe", eh = ehub)
#saveRDS(spe,"/Users/zhouhaowen/Documents/GitHub/atlasClustering/example/DLPFC_spe.RDS")
spe <- readRDS("/Users/zhouhaowen/Documents/GitHub/atlasClustering/example/DLPFC_spe.RDS")

seurat_ls <- spe2SeuList(spe,
                         sample_id = "sample_id",
                         sel_assay = "counts",
                         sel_col = c("layer_guess_reordered_short","spatialLIBD"),
                         col_name = c("layer","spatialLIBD"))

seurat_ls <- stage_1(seurat_ls, find_HVG = T, top_pcs = 8, cor_threshold = 0.6, cor_met = "PC",
                     edge_smoothing = T, nn = 6, use_glmpca = T, verbose = T)


rtn_ls <- stage_2(seurat_ls, cl_key = "merged_cluster",
                  rtn_seurat = T, nn_2 = 10, method = "MNN",
                  top_pcs = 8, use_glmpca = T, rare_ct = "m", resolution = 1)
seurat_ls <- assign_label(seurat_ls, rtn_ls$cl_df, "MNN", 0.6, cl_key = "merged_cluster")

layer_pal <- RColorBrewer::brewer.pal(7,"Set1")
names(layer_pal) <- c("L1", "L2", "L3", "L4", "L5", "L6", "WM")


ggarrange(plotlist = list("MNN1"= draw_slide_graph(seurat_ls[["151507"]]@meta.data,NULL,NULL,"sec_cluster_MNN"),
                          "GT1"=  draw_slide_graph(seurat_ls[["151507"]]@meta.data,NULL,NULL,"layer", layer_pal),
                          "MNN2"= draw_slide_graph(seurat_ls[["151669"]]@meta.data,NULL,NULL,"sec_cluster_MNN"),
                          "GT2"=  draw_slide_graph(seurat_ls[["151669"]]@meta.data,NULL,NULL,"layer", layer_pal),
                          "MNN3"= draw_slide_graph(seurat_ls[["151673"]]@meta.data,NULL,NULL,"sec_cluster_MNN"),
                          "GT3"=  draw_slide_graph(seurat_ls[["151673"]]@meta.data,NULL,NULL,"layer", layer_pal)),
          ncol = 2,nrow = 3)

ari_vec <- sapply(seq_along(seurat_ls),function(i){
  mclust::adjustedRandIndex(seurat_ls[[i]]@meta.data[["layer"]],
                            seurat_ls[[i]]@meta.data[["sec_cluster_MNN"]])

})

message(paste0("Sample\tARI:\n",paste(names(seurat_ls),'\t',format(ari_vec,digits = 3), collapse = "\n") ))

