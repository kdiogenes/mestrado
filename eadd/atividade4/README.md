# Especificação da atividade

## Objetivo

Aplicar e corroborar conceitos adquiridos com relação ao método de ordenação Quicksort analisando-se seu desempenho
quando implementado de forma recursiva frente à uma implementação iterativa.

## Tarefa

Implementar as seguintes estratégias de ordenação:
1. Quicksort recursivo;
2. Quicksort iterativo.

Deve-se avaliar o comportamento dos métodos perante um conjunto de testes com diferentes características. Durante a
execução dos testes o critério de análise será o **tempo cronológico** gasto para a execução dos métodos.

## Como

* A linguagem utilizada no desenvolvimento é de sua escolha.
* A forma com que os métodos serão implementados é determinada pelo(a) aluno(a).
* Para a determinação do pivô deve-se escolher o elemento central do vetor.
* A entrada dos dados deve ser feita com base nos arquivos texto disponíveis:
  * Valores Aleatórios: [inputs/random](./inputs/random)
  * Valores Decrescentes: [inputs/ordered_decreasing](./inputs/ordered_decreasing)
  * Valores Ordenados Crescentes: [inputs/ordered](./inputs/ordered)
  * Valores Parcialmente Ordenados: [inputs/partial_ordered](./inputs/partial_ordered)

Devem ser construídos quatro conjutnos de testes, conforme os arquivos disponíveis nos links apresentados acima:
* Os dois métodos de ordenação trabalhando sobre conjunto aleatórios;
* As duas estratégias de ordenação trabalhando sobre conjuntos ordenados de forma decrescente;
* Todos os métodos sobre conjuntos ordenados de forma crescente;
* Todas as abordagens sobre conjutnso parcialmente ordenados de forma crescente.

Além disso, devem ser analisado o comportamento de cada técnica sobre diferentes entradas conforme descrito a seguir:
* Quicksort recursivo sobre os quatro tipos de entrada;
* Quicksort iterativo sobre os quatro tipos de entrada.

# Implementação

O arquivo [quicksort.rb](./quicksort.rb) implementa as duas versões do algoritmo Quicksort através das classes
`Quicksort::Recursive` e `Quicksort::Iterative`. Ambas implementações compartilham o
[esquema de particionamento Hoare](https://en.wikipedia.org/wiki/Quicksort#Hoare_partition_scheme). Tal esquema de
particionamento é mais eificiente que o
[esquema de particionamento Lomuto](https://en.wikipedia.org/wiki/Quicksort#Lomuto_partition_scheme), realizando 3x
vezes menos trocas na média. Dado a utilização do elemento central como pivô, este esquema também apresenta o melhor
caso do algoritmo para dados ordenados, não realizando nenhuma troca.

O arquivo [script.rb](./script.rb) faz a leitura dos arquivos de entrada e executa cada algoritmo 5x sobre esses dados
armazenando os tempos de execução. As informações de todas as execuções são salvas no arquivo
[outputs/results.json](./outputs/results.json).