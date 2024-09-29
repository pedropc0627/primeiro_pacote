#' Gráfico de Valores Preditos vs Resíduos
#'
#' @param model Resultado da função linear_regression.
#' @export
plot_regression_residuos <- function(model) {
  plot(model$predicted, model$residuals, 
       xlab = "Valores Preditos", 
       ylab = "Resíduos", 
       main = "Gráfico de Resíduos")
}

#' Gráfico de Valores Reais vs Preditos
#'
#' @param model Resultado da função de regressão linear, contendo valores preditos e resíduos.
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
#' @param model Resultado da função linear_regression.
#' @param new_data Dataframe com novas observações.
#' @return Valores preditos para as novas observações.
#' @export
predict_new <- function(model, new_data) {
  X_new <- model.matrix(~ ., data = new_data)
  return(X_new %*% model$coefficients)
}