#' Gráfico de Valores Preditos vs Observados
#'
#' @param model Resultado da função linear_regression.
#' @export
plot_regression <- function(model) {
  plot(model$predicted, model$residuals, 
       xlab = "Valores Preditos", 
       ylab = "Resíduos", 
       main = "Gráfico de Resíduos")
  abline(h = 0, col = "red")
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