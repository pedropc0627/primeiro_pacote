#' Grafico de Valores Preditos vs Residuos
#'
#' Dado o modelo de regressao, a funcao `plot_regression_residuos` retorna o grafico dos valores
#' preditos pelo modelo no eixo X e os residuos no eixo Y. Esse grafico e util para diagnosticar
#' a qualidade do ajuste do modelo.
#'
#' @param model Resultado da funcao `linear_regression`, que deve incluir os valores preditos e residuos.
#' @examples
#' modelo <- linear_regression(simulated_data, "Y", c("X1", "X2"), conf.level = 0.95)
#' plot_regression_residuos(modelo)
#' @export
plot_regression_residuos <- function(model) {
  plot(model$predicted, model$residuals,
       xlab = "Valores Preditos",
       ylab = "Residuos",
       main = "Grafico de Residuos")
}

#' Grafico de Valores Reais vs Preditos
#'
#' Dado o modelo, a funcao `plot_regression_predict` retorna um grafico com os dados reais no eixo
#' X e os valores preditos no eixo Y. Esse grafico e util para visualizar a precisao do modelo de
#' regressao.
#'
#' @param model Resultado da funcao `linear_regression`, contendo valores preditos e residuos.
#' @examples
#' modelo <- linear_regression(simulated_data, "Y", c("X1", "X2"), conf.level = 0.95)
#' plot_regression_predict(modelo)
#' @export
#' @importFrom graphics abline
plot_regression_predict <- function(model) {
  # Calcular os valores reais a partir dos valores preditos e residuos
  real <- model$predicted + model$residuals
  
  # Grafico dos valores reais vs preditos
  plot(real, model$predicted,
       xlab = "Valores Reais (Observados)",
       ylab = "Valores Preditos",
       main = "Grafico de Reais vs Preditos",
       pch = 16, col = "blue")
  
  # Adicionar a reta de regressao (linha de 45 graus, onde real = predito)
  abline(a = 0, b = 1, col = "red", lwd = 2)
}

#' Predicao
#'
#' A funcao `predict_new`, dado seu modelo e novos dados, retorna a predicao da variavel resposta
#' para as novas observacoes.
#'
#' @param model Resultado da funcao `linear_regression`, que inclui os coeficientes ajustados.
#' @param new_data Dataframe com novas observacoes, que deve ter as mesmas variaveis preditoras
#' que foram usadas no modelo.
#' @return Valores preditos para as novas observacoes.
#' @examples
#' modelo <- linear_regression(simulated_data, "Y", c("X1", "X2"), conf.level = 0.95)
#' new_data <- data.frame(X1 = rnorm(5), X2 = rnorm(5))
#' predicted_values <- predict_new(modelo, new_data)
#' predicted_values  # Valores preditos para as novas observacoes
#' @export
#' @importFrom stats model.matrix
predict_new <- function(model, new_data) {
  X_new <- model.matrix(~ ., data = new_data)
  return(X_new %*% model$coefficients)
}> tools::showNonASCIIfile("R/graficos.R")

