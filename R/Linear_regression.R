#' @title Regressao Linear
#' @name Linear_regression
#'
#' @description Ajusta um modelo de regressao linear com base em um dataframe fornecido. A funcao retorna um
#' objeto contendo coeficientes, residuos, valores preditos, p-valores e intervalos de confianca.
#'
#' @param data Dataframe contendo os dados de entrada.
#' @param resposta Nome da coluna que contem a variavel resposta (dependente).
#' @param preditor Lista de nomes das colunas que contem as variaveis preditoras (independentes).
#' @param conf.level Nivel de confianca para os intervalos de confianca, padrao e 0.95.
#' @return Um objeto com os coeficientes, residuos, valores preditos, p-valores e intervalos de confianca.
#' @importFrom stats model.matrix pt qt
#' @examples
#' library (primeiropacote)
#' modelo <- linear_regression(simulated_data, "Y", c("X1", "X2"), conf.level = 0.95)
#' summary(modelo)  # Resumo do modelo ajustado
#' @export
linear_regression <- function(data, resposta, preditor, conf.level = 0.95) {
  # Validacoes
  if (!is.data.frame(data)) stop("Os dados tem que ser um dataframe.")
  if (!resposta %in% names(data)) stop("A variavel resposta deve ser uma coluna do dataframe.")
  if (!all(preditor %in% names(data))) stop("Todos os preditores devem ser colunas do dataframe.")
  
  # Matriz de design
  Y <- as.matrix(data[[resposta]])
  X <- model.matrix(~ ., data = data[preditor])
  
  # Coeficientes
  beta <- solve(t(X) %*% X) %*% t(X) %*% Y
  
  # Valores preditos e residuos
  predicted <- X %*% beta
  residuals <- Y - predicted
  
  # Verificacao de residuos: caso sejam todos zero, lanca erro
  if (all(residuals == 0)) {
    stop("Erro: Y pode ser descrito perfeitamente como Xbeta. Os residuos sao todos zero.")
  }
  
  # Numero de observacoes e preditores
  n <- nrow(X)
  p <- ncol(X)
  
  # Soma dos quadrados dos residuos
  residual_sum_of_squares <- sum(residuals^2)
  
  # Estimativa da variancia dos residuos
  residual_variance <- residual_sum_of_squares / (n - p)
  
  # Matriz de covariancia dos coeficientes
  var_beta <- residual_variance * solve(t(X) %*% X)
  
  # Erros padrao dos coeficientes
  std_error <- sqrt(diag(var_beta))
  
  # Estatisticas t para os coeficientes
  t_values <- beta / std_error
  
  # p-valores para os coeficientes (usando distribuicao t)
  p_values <- 2 * pt(-abs(t_values), df = n - p)
  
  # Intervalos de confianca
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
