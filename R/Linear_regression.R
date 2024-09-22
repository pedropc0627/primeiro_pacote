#' Regressão Linear
#'
#' Ajusta um modelo de regressão linear.
#'
#' @param data Dataframe.
#' @param resposta Nome da coluna de variável resposta.
#' @param preditor Lista de nomes das colunas de variáveis preditoras.
#' @return Um objeto com os coeficientes, resíduos e valores preditos.
#' @name linear_regression
#' @export
linear_regression <- function(data, resposta, preditor) {
  # Validações
  if (!is.data.frame(data)) stop("data must be a dataframe.")
  if (!resposta %in% names(data)) stop("response must be a valid column name.")
  if (!all(preditor %in% names(data))) stop("all predictors must be valid column names.")
  
  # Matriz de design
  Y <- as.matrix(data[[resposta]])
  X <- model.matrix(~ ., data = data[preditor])
  
  # Coeficientes
  beta <- solve(t(X) %*% X) %*% t(X) %*% Y
  
  # Resíduos e valores preditos
  predicted <- X %*% beta
  residuals <- Y - predicted
  
  return(list(coefficients = beta, residuals = residuals, predicted = predicted))
}