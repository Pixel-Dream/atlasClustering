% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting_functions.R
\name{plotConfusionMatrix}
\alias{plotConfusionMatrix}
\title{Plot Confusion Matrix}
\usage{
plotConfusionMatrix(x, y, col_title = "")
}
\arguments{
\item{x, y}{vector with discrete values}

\item{col_title}{Heatmap title}
}
\value{
A Heatmap-class object.
}
\description{
Draw Confusion Matrix using ComplexHeatmap
}
\examples{
x_ <- sample(1:4,100,replace = T)
y_ <- sample(1:5,100,replace = T)
plotConfusionMatrix(x_,y_,col_title = "Confusion Matrix")

}
