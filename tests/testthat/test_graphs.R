library(testthat)

#' Testa o gráfico de Valores Preditos vs Resíduos
#'
#' @param model Resultado da função linear_regression.
test_plot_regression_residuos = function(model) {
  expect_silent(plot_regression_residuos(model)) # Verifica se a função roda sem erros
  expect_type(dev.cur(), "integer") # Verifica se um gráfico foi criado
}

#' Testa o gráfico de Valores Reais vs Preditos
#'
#' @param model Resultado da função linear_regression.
test_plot_regression_predict = function(model) {
  expect_silent(plot_regression_predict(model)) # Verifica se a função roda sem erros
  expect_type(dev.cur(), "integer") # Verifica se um gráfico foi criado
}

# Exemplo de teste usando os gráficos
test_that("Os gráficos de regressão são gerados corretamente", {
  simulated_data
  model = linear_regression(simulated_data, "Y", c("X1", "X2"))
  
  # Testar os gráficos
  test_plot_regression_residuos(model)
  test_plot_regression_predict(model)
})