#' Regressão Linear
#'
#' Ajusta um modelo de regressão linear.
#'
#' @param data Dataframe.
#' @param resposta Nome da coluna de variável resposta.
#' @param preditor Lista de nomes das colunas de variáveis preditoras.
#' @param conf.level Nível de confiança para os intervalos de confiança.
#' @return Um objeto com os coeficientes, resíduos, valores preditos, p-valores e intervalos de confiança.
#' @name linear_regression
#' @examples 
#' modelo <- linear_regression(simulated_data, "Y", "X1", conf.level = 0.95)
#' @export
linear_regression <- function(data, resposta, preditor, conf.level = 0.95) {
  # Validações
  if (!is.data.frame(data)) stop("Os dados têm que ser um dataframe.")
  if (!resposta %in% names(data)) stop("A variável resposta deve ser uma coluna do dataframe.")
  if (!all(preditor %in% names(data))) stop("Todos os preditores devem ser colunas do dataframe.")
  
  # Matriz de design
  Y <- as.matrix(data[[resposta]])
  X <- model.matrix(~ ., data = data[preditor])
  
  # Coeficientes
  beta <- solve(t(X) %*% X) %*% t(X) %*% Y
  
  # Valores preditos e resíduos
  predicted <- X %*% beta
  residuals <- Y - predicted
  
  # Verificação de resíduos: caso sejam todos zero, lança erro
  if (all(residuals == 0)) {
    stop("Erro: Y pode ser descrito perfeitamente como Xβ. Os resíduos são todos zero.")
  }
  
  # Número de observações e preditores
  n <- nrow(X)
  p <- ncol(X)
  
  # Soma dos quadrados dos resíduos
  residual_sum_of_squares <- sum(residuals^2)
  
  # Estimativa da variância dos resíduos
  residual_variance <- residual_sum_of_squares / (n - p)
  
  # Matriz de covariância dos coeficientes
  var_beta <- residual_variance * solve(t(X) %*% X)
  
  # Erros padrão dos coeficientes
  std_error <- sqrt(diag(var_beta))
  
  # Estatísticas t para os coeficientes
  t_values <- beta / std_error
  
  # p-valores para os coeficientes (usando distribuição t)
  p_values <- 2 * pt(-abs(t_values), df = n - p)
  
  # Intervalos de confiança
  alpha <- 1 - conf.level
  critical_value <- qt(1 - alpha / 2, df = n - p)
  conf_intervals <- cbind(
    beta - critical_value * std_error,
    beta + critical_value * std_error
  )
  
  return(list(
    coefficients = beta,
    residuals = residuals,
    predicted = predicted,
    p_values = p_values,
    conf_intervals = conf_intervals
  ))
}
