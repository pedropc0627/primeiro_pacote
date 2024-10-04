
# primeiro_pacote

Um pacote para realizar análises de regressão linear de forma flexível e
simples, fornecendo uma função para ajuste de modelo, obtenção de
coeficientes, predição de novos dados e gráfico de diagnóstico. Ele foi
desenhado para ser simples de usar, mas poderoso o suficiente para lidar
com cenários comuns de análise de dados.

## Funcionalidades do Pacote

O pacote utiliza a fórmula clássica da regressão linear para calcular os
coeficientes. Essencialmente, essa fórmula resolve um sistema de
equações que minimiza a soma dos quadrados dos erros (resíduos) entre os
valores observados e os valores preditos. A ideia é encontrar os valores
dos coeficientes que melhor ajustam o modelo aos dados.

O pacote permite aos usuários:

- Ajustar modelos de regressão linear manualmente, calculando os
  coeficientes com a fórmula clássica da regressão linear
  $\widehat{\beta} = (X^{´}X)^{-1}X^{´}Y$;

- Obter os coeficientes estimados do modelo;

- Gerar predições para novos dados;

- Visualizar gráficos de diagnóstico, como preditos vs resíduos e reais
  vs preditos;

- Testar e validar a qualidade do ajuste do modelo.

O pacote também inclui funcionalidades robustas de validação, gerando
mensagens de erro claras e detalhadas quando as condições ideais para o
ajuste do modelo não são atendidas.

## Instalação

Você pode instalar o pacote diretamente do GitHub usando o pacote
`devtools`. Execute o seguinte comando no R:

``` r
# Instale o devtools se ainda não o tiver
install.packages("devtools")

# Instale primeiro_pacote
devtools::install_github("pedropc0627/primeiro_pacote")
```

## Exemplo de Uso

Abaixo segue um exemplo de como usar o pacote para ajustar um modelo de
regressão linear, visualizar os coeficientes e gerar predições para
novos dados.

``` r
# Carregue o pacote
library(primeiropacote)

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
```

    ##                   [,1]
    ## (Intercept) 0.14656606
    ## X1          0.02091294
    ## X2          0.07371789

``` r
# Gere predições para novos dados
novos_dados <- data.frame(X1 = rnorm(5), X2 = rnorm(5))
predicoes <- predict_new(modelo, novos_dados)
print(predicoes)
```

    ##         [,1]
    ## 1 0.17615521
    ## 2 0.13215768
    ## 3 0.14142474
    ## 4 0.15766569
    ## 5 0.07118917

``` r
# Gráfico de Preditos vs Resíduos
plot_regression_residuos(modelo)
```

![](README_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
# Gráfico de Reais vs Preditos
plot_regression_predict(modelo)
```

![](README_files/figure-gfm/unnamed-chunk-1-2.png)<!-- -->

### Situações Esperadas e Inesperadas

#### Exemplo 1: Ajuste Normal

Neste exemplo, ajustamos um modelo de regressão linear com dois
preditores sem problemas.

``` r
# Carregue o pacote
library(primeiropacote)

# Simule um conjunto de dados com duas variáveis preditoras e uma resposta
set.seed(123)
dados_normais <- data.frame(
  X1 = rnorm(100),
  X2 = rnorm(100),
  Y = 1 + 2 * rnorm(100)
)

# Ajuste o modelo de regressão linear
modelo_norm <- linear_regression(dados_normais, "Y", c("X1", "X2"))

# Veja os coeficientes
print(modelo_norm$coefficients)

# Gráfico de Preditos vs Resíduos
plot_regression_residuos(modelo_norm)
```

#### Exemplo 2: Matriz de Design com Posto Incompleto

Quando a matriz de design (composta pelos preditores) não tem posto
completo, não é possível estimar todos os coeficientes de forma única.
Neste exemplo, $X_2$ é uma cópia exata de $X_1$, resultando em uma
matriz singular.

``` r
# Dados com matriz de design singular (X2 é uma cópia exata de X1)
set.seed(789)
dados_singulares <- data.frame(
  X1 = rnorm(100),
  X2 = rnorm(100),
  Y = rnorm(100)
)

# Forçar X2 a ser uma cópia de X1 (gerando uma matriz de design singular)
dados_singulares$X2 <- dados_singulares$X1

# Ajuste o modelo de regressão linear
modelo_singular <- linear_regression(dados_singulares, "Y", c("X1", "X2"))
# O pacote retorna uma mensagem de erro sobre a singularidade da matriz
```

#### Exemplo 3: Resíduos Todos Iguais a Zero

Esse exemplo demonstra uma situação em que o vetor de resposta $Y$ pode
ser descrito perfeitamente como uma combinação linear dos preditores,
resultando em resíduos todos iguais ou muito próximos a zero.

``` r
# Simule um conjunto de dados onde Y é uma combinação linear exata de X1 e X2
set.seed(9874)
dados_perfeitos <- data.frame(
  X1 = rnorm(100),
  X2 = rnorm(100)
)
dados_perfeitos$Y <- 3 + 2 * dados_perfeitos$X1 - 1.5 * dados_perfeitos$X2

# Ajuste o modelo de regressão linear
modelo_perfeito <- linear_regression(dados_perfeitos, "Y", c("X1", "X2"))

# Como Y é uma combinação exata de X1 e X2, os resíduos devem ser zero
print(modelo_perfeito$residuals)

# Gráfico de resíduos vs preditos deve mostrar que todos os resíduos são zero
plot_regression_residuos(modelo_perfeito)
```

Neste caso, como a resposta $Y$ é uma combinação exata dos preditores, o
primeiro_pacote retornará resíduos iguais ou muito próximos a zero, e
isso será refletido no gráfico de resíduos.

## Gráficos de Diagnóstico

O pacote inclui duas funções principais de gráficos para ajudar a
diagnosticar a qualidade do ajuste do modelo de regressão linear:
`plot_regression_residuos` e `plot_regression_predict`. Esses gráficos
são fundamentais para verificar se os pressupostos do modelo de
regressão linear foram atendidos.

### 1. Gráfico de Valores Preditos vs Resíduos

#### Descrição

O gráfico gerado pela função `plot_regression_residuos` exibe os valores
preditos pelo modelo no eixo X e os resíduos no eixo Y. Resíduos são as
diferenças entre os valores observados e os valores preditos pelo
modelo. Este gráfico é utilizado para verificar se os resíduos
apresentam um padrão específico, o que indicaria problemas com o ajuste
do modelo.

#### Interpretação

- *Resíduos aleatórios*: Se os resíduos estão distribuídos de forma
  aleatória em torno da linha horizontal (resíduo = 0), isso sugere que
  o modelo ajustou bem os dados e que os erros são homogêneos.
- *Padrões*: Se você observar um padrão (como uma curva ou um funil),
  isso pode indicar que o modelo não está capturando corretamente a
  relação entre as variáveis, sugerindo a presença de não linearidade ou
  variância heterogênea (heterocedasticidade).
- *Outliers*: Pontos que estão muito afastados da maioria dos resíduos
  podem indicar observações atípicas (outliers) que estão influenciando
  o modelo.

#### Exemplo de Uso

``` r
# Simule um conjunto de dados e ajuste o modelo
dados <- data.frame(X1 = rnorm(100), X2 = rnorm(100), Y = rnorm(100))
modelo <- linear_regression(dados, "Y", c("X1", "X2"))

# Gera o gráfico de preditos vs resíduos
plot_regression_residuos(modelo)
```

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- --> O gráfico
resultante ajudará a identificar potenciais problemas no modelo.

### 2. Gráfico de Valores Reais vs Preditos

#### Descrição

A função `plot_regression_predict` gera um gráfico com os valores reais
(observados) no eixo X e os valores preditos pelo modelo no eixo Y. Este
gráfico é útil para verificar a precisão do modelo ao prever os dados.

#### Interpretação

- *Linha de 45 graus*: Se o modelo estiver funcionando bem, os pontos
  deverão estar distribuídos ao longo da linha de 45 graus (linha
  vermelha), o que indicaria que os valores preditos estão próximos dos
  valores observados.
- *Desvios da linha*: Desvios consideráveis da linha de 45 graus indicam
  que o modelo está cometendo erros de predição significativos.

#### Exemplo de Uso

``` r
# Ajuste o modelo
modelo <- linear_regression(dados, "Y", c("X1", "X2"))

# Gera o gráfico de reais vs preditos
plot_regression_predict(modelo)
```

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- --> Esse gráfico
permite que você avalie visualmente a precisão das predições do modelo.

## Testes e Validações

O pacote foi projetado para lidar com diferentes cenários e situações
onde a regressão pode falhar ou gerar resultados inesperados. Testes
foram implementados para:

- Verificar se uma coluna de preditores é constante, e se a matriz de
  design tem posto completo;
- Checagem da completude da matriz de design (evitando matrizes
  singulares);
- Retornar um erro apropriado caso o vetor de resposta `Y` possa ser
  descrito perfeitamente como uma combinação linear das variáveis
  preditoras (resíduos iguais a zero).

Aqui está um exemplo de como o pacote trata essas situações:

``` r
# Caso em que a matriz de design não tem posto completo
dados_singulares <- data.frame(
  X1 = rnorm(100),
  X2 = rnorm(100),
  Y = rnorm(100)
)

# Forçar X2 a ser uma cópia exata de X1 (colinearidade perfeita)
dados_singulares$X2 <- dados_singulares$X1

# Ajustar o modelo com matriz singular
modelo_singular <- linear_regression(dados_singulares, "Y", c("X1", "X2"))
# O pacote retorna uma mensagem de erro
```

Se qualquer um desses problemas for detectado, a função
`linear_regression()` retornará uma mensagem de erro para o usuário.

## Limitações Conhecidas

- A função `linear_regression` só aceita o nome da variável resposta e
  das variáveis preditoras entre aspas (““), o que pode exigir atenção
  ao passar os argumentos.
- O pacote não suporta variáveis categóricas como preditores no modelo.
- O modelo assume que os resíduos têm distribuição normal com variância
  constante.
- Transformações automáticas de variáveis para lidar com relações não
  lineares não são implementadas.
- Não há suporte para termos de interação entre variáveis.
- O pacote não lida com dados ausentes (missing data), sendo necessário
  tratar esses casos previamente.
