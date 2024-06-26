% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/atlasClustering.R
\name{assign_label}
\alias{assign_label}
\title{Assign labels}
\usage{
assign_label(seu_ls, cl_df, anno, cor_threshold, cl_key = "merged_cluster")
}
\arguments{
\item{seu_ls}{A list of Seurat Objects from \code{stage_1} results}

\item{cl_df}{A Dataframe from \code{stage_2}, containing the clustering results}

\item{anno}{Annotation string}

\item{cor_threshold}{Threshold for edge pruning in stage 1}

\item{cl_key}{Column for clustering labels}
}
\value{
A list of Seurat Objects
}
\description{
Assign labels to each spot based on integrated clustering results
}
\examples{
TBD
}
