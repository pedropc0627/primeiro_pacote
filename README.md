primeiro_pacote
================
Pedro
2024-09-30

# primeiro_pacote

Um pacote para realizar análises de regressão linear de forma flexível e
simples, fornecendo uma função para ajuste de modelo, obtenção de
coeficientes, predição de novos dados e gráfico de diagnóstico.

## Funcionalidades do Pacote

O pacote permite:

- Ajustar modelos de regressão linear;

- Obter os coeficientes de regressão;

- Gerar predições para novos dados;

- Visualizar gráficos de diagnóstico, como preditos vs resíduos e reais
  vs preditos;

- Testar e validar a qualidade do ajuste do modelo.

## Instalação

Você pode instalar o pacote diretamente do GitHub usando o pacote
`devtools`. Execute o seguinte comando no R:

``` r
# Instale o devtools se ainda não o tiver
install.packages("devtools")

# Instale primeiro_pacote
devtools::install_github("seu_usuario/primeiro_pacote")
```

## Exemplo de Uso

Abaixo segue um exemplo de como usar o pacote para ajustar um modelo de
regressão linear, visualizar os coeficientes e gerar predições para
novos dados.

``` r
# Carregue o pacote
library(nome_do_seu_pacote)

# Simule um conjunto de dados com duas variáveis preditoras e uma resposta
set.seed(4321)
dados <- data.frame(
  X1 = rnorm(100),
  X2 = rnorm(100),
  Y = rnorm(100)
)

# Ajuste o modelo de regressão linear
modelo <- linear_regression(dados, "Y", c("X1", "X2"))

# Veja os coeficientes do modelo
print(modelo$coefficients)

# Gere predições para novos dados
novos_dados <- data.frame(X1 = rnorm(5), X2 = rnorm(5))
predicoes <- predict_new(modelo, novos_dados)
print(predicoes)

# Gráfico de Preditos vs Resíduos
plot_regression_residuos(modelo)

# Gráfico de Reais vs Preditos
plot_regression_predict(modelo)
```

## Testes e Validações

O pacote foi projetado para lidar com diferentes cenários e situações
onde a regressão pode falhar ou gerar resultados inesperados. Testes
foram implementados para:

- Verificar se uma coluna de preditores é constante, e se a matriz de
  design tem posto completo.
- Retornar um erro apropriado caso o vetor de resposta `Y` possa ser
  descrito perfeitamente como uma combinação linear das variáveis
  preditoras (resíduos iguais a zero).

Se qualquer um desses problemas for detectado, a função
`linear_regression()` retornará uma mensagem de erro clara para o
usuário.
