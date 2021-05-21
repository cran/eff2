## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(eff2)
library(qgraph)
data("ex1")

## ---- fig.align='center', fig.retina=2, fig.width=4---------------------------
q.dag <- qgraph(t(ex1$amat.dag), layout="spring", repulsion=0.5)

## -----------------------------------------------------------------------------
str(ex1$data)

## -----------------------------------------------------------------------------
estimateEffect(ex1$data, 1, 10, ex1$amat.dag)

## -----------------------------------------------------------------------------
eff2:::getEffectsFromSEM(ex1$B, 1, 10)  # truth

## -----------------------------------------------------------------------------
estimateEffect(ex1$data, c(1,2), 10, ex1$amat.dag)
eff2:::getEffectsFromSEM(ex1$B, c(1,2), 10)   # truth

## ---- fig.align='center', fig.retina=2, fig.width=4---------------------------
qgraph(t(ex1$amat.cpdag), bidirectional=TRUE, layout=q.dag$layout)

## -----------------------------------------------------------------------------
estimateEffect(ex1$data, 1, 10, ex1$amat.cpdag)
eff2:::getEffectsFromSEM(ex1$B, 1, 10)  # truth

## ---- error=TRUE--------------------------------------------------------------
isIdentified(ex1$amat.cpdag, c(1,2), 10)
isIdentified(ex1$amat.cpdag, c(1,6), 10)

## ---- error=TRUE--------------------------------------------------------------
isIdentified(ex1$amat.cpdag, 3, 7)
isIdentified(ex1$amat.cpdag, 5, 7)
isIdentified(ex1$amat.cpdag, c(3,5), 7)

## -----------------------------------------------------------------------------
result <- estimateEffect(ex1$data, c(3,5), 7, ex1$amat.cpdag, bootstrap=TRUE);
print(result$effect)
# 95% CI
print(result$effect - 1.96 * sqrt(diag(result$se.cov)))
print(result$effect + 1.96 * sqrt(diag(result$se.cov)))
# truth
eff2:::getEffectsFromSEM(ex1$B, c(3,5), 7)

