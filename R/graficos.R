#' Gráfico de Valores Preditos vs Resíduos
#'
#' Dado o modelo de regressão, a função plot_regression_residuos retorna o gráfico dos valores preditos pelo modelo no eixo X, e os resíduos no eixo y.
#' @param model Resultado da função linear_regression.
#' @examples 
#' linear_regression(simulated_data, "Y", "X1", conf.level = 0.95)
#' plot_regression_residuos(modelo)
#' @export
plot_regression_residuos <- function(model) {
  plot(model$predicted, model$residuals, 
       xlab = "Valores Preditos", 
       ylab = "Resíduos", 
       main = "Gráfico de Resíduos")
}

#' Gráfico de Valores Reais vs Preditos
#'
#' Dado o modelo, a função plot_regression_predict retorna um gráfico com os dados reais no eixo X e os valores preditos no eixo y.
#' @param model Resultado da função de regressão linear, contendo valores preditos e resíduos.
#' @examples 
#' linear_regression(simulated_data, "Y", "X1", conf.level = 0.95)
#' plot_regression_predict(modelo)
#' @export
plot_regression_predict <- function(model) {
  # Calcular os valores reais a partir dos valores preditos e resíduos
  real <- model$predicted + model$residuals
  
  # Gráfico dos valores reais vs preditos
  plot(real, model$predicted, 
       xlab = "Valores Reais (Observados)", 
       ylab = "Valores Preditos", 
       main = "Gráfico de Reais vs Preditos",
       pch = 16, col = "blue")
  
  # Adicionar a reta de regressão (linha de 45 graus, onde real = predito)
  abline(a = 0, b = 1, col = "red", lwd = 2)
}
#' Predição
#'
#' A função predict_new, dado seu modelo e novos dados, retorna a predição da variável resposta dadas as novas observações.
#' @param model Resultado da função linear_regression.
#' @param new_data Dataframe com novas observações.
#' @return Valores preditos para as novas observações.
#' @export
predict_new <- function(model, new_data) {
  X_new <- model.matrix(~ ., data = new_data)
  return(X_new %*% model$coefficients)
}
