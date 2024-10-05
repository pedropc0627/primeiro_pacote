#' Conjunto de Dados Simulados
#'
#' Um dataframe contendo dados simulados para ilustracao. Este conjunto e util para testar
#' funcoes de regressao linear e visualizacao.
#'
#' @format Um dataframe com 100 observacoes e 3 variaveis.
#' \describe{
#'   \item{X1}{Variavel preditora 1, gerada aleatoriamente a partir de uma distribuicao normal.}
#'   \item{X2}{Variavel preditora 2, gerada aleatoriamente a partir de uma distribuicao normal.}
#'   \item{Y}{Variavel resposta, gerada aleatoriamente a partir de uma distribuicao normal.}
#' }
#' @examples
#' head(simulated_data)  # Visualizar as primeiras linhas do conjunto de dados simulado
#' summary(simulated_data)  # Resumo estatistico das variaveis
#' @export
simulated_data <- data.frame(
  X1 = rnorm(100),
  X2 = rnorm(100),
  Y = rnorm(100)
)
