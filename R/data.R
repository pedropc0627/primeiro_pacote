#' Conjunto de Dados Simulados
#'
#' Um dataframe contendo dados simulados para ilustração.
#'
#' @format Um dataframe com 100 observações e 3 variáveis.
#' \describe{
#'   \item{X1}{Variável preditora 1.}
#'   \item{X2}{Variável preditora 2.}
#'   \item{Y}{Variável resposta.}
#' }
#' @export
simulated_data <- data.frame(
  X1 = rnorm(100),
  X2 = rnorm(100),
  Y = rnorm(100)
)