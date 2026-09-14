# Paradigmas de Programação – Simulado 2 (código SIM2)

**Nome:** ______________________  **Matrícula:** ____________  **Data:** ____/____/______

**Instruções:**
(a) O simulado é individual e sem consulta.
(b) A interpretação dos comandos das questões faz parte da avaliação.
(c) O gabarito deve ser marcado **à caneta**. Marcação à lápis, com rasuras, em branco ou com
múltiplas alternativas assinaladas recebe pontuação zero.
(d) Nas questões abertas (Parte B), marque a resposta no formato **CDU** (centena, dezena, unidade).
(e) Na Parte C, escreva o código Prolog.

**Parte A.** Assinale a alternativa correta. Cada marcação correta vale 2 pontos.

**Q1.** Qual conectivo da lógica proposicional booleana é **verdadeiro apenas quando as duas
proposições têm valores lógicos diferentes**?
(A) ∧ (B) ∨ (C) ↔ (D) ⊻ (disjunção exclusiva) (E) →

**Q2.** Considere os fatos abaixo, relativos ao predicado `ou/2`:
```prolog
ou(true, true).
ou(true, false).
ou(false, true).
```
Neste cenário (base fechada), o predicado `ou/2` implementa qual conectivo?
(A) conjunção
(B) disjunção
(C) condicional
(D) bicondicional
(E) negação

**Q3.** Considere o predicado:
```prolog
f(X) :- X is 2 ^ 3 + 1.
```
Qual é o resultado da consulta `?- f(Y).`?
(A) Y = 6.
(B) Y = 7.
(C) Y = 8.
(D) Y = 9.
(E) Y = 16.

**Q4.** Para que um predicado próprio possa ser usado como **função aritmética** (por exemplo,
em `X is meu_pred(3)`), qual diretiva deve ser usada?
(A) `:- dynamic`
(B) `:- op`
(C) `:- arithmetic_function`
(D) `:- meta_predicate`
(E) `:- consult`

**Q5.** No construto condicional `(A -> B ; C)`, em que situação `C` é avaliado?
(A) Sempre.
(B) Quando `A` é verdadeiro.
(C) Quando `A` falha.
(D) Nunca.
(E) Quando `B` falha.

**Q6.** Considere que a base Prolog contenha um único fato, `cidade(df).`. Quantas, dentre as
quatro consultas abaixo, retornam **verdadeiro**?
```prolog
?- cidade(df).
?- cidade(sp).
?- cidade(X).
?- cidade(X), cidade(Y), X \= Y.
```
(A) 0 (B) 1 (C) 2 (D) 3 (E) 4

**Q7.** Considere o predicado `mdc/3` (máximo divisor comum):
```prolog
mdc(A, 0, A).
mdc(A, B, X) :-
    B > 0,
    R is A mod B,
    mdc(B, R, X).
```
Qual é o resultado da consulta `?- mdc(48, 18, X).`?
(A) X = 2.
(B) X = 3.
(C) X = 6.
(D) X = 12.
(E) X = 18.

**Q8.** Quantas, dentre as quatro consultas abaixo, retornam **verdadeiro**?
```prolog
?- f(X, X) = f(a, b).
?- 5 =:= 5.
?- g(a) = g(A), A \= b.
?- 2 + 3 = 5.
```
(A) 0 (B) 1 (C) 2 (D) 3 (E) 4

**Q9.** O que caracteriza um **combinador**?
(A) Possuir variáveis livres.
(B) Ser sempre uma função binária.
(C) Ser um termo fechado, sem variáveis livres.
(D) Existir apenas na base $SK$.
(E) Depender de valores externos.

**Q10.** O tordo-imitador $M$, definido por $Mx = xx$, tem qual forma na base $SK$?
(A) $SKK$
(B) $SII$
(C) $KK$
(D) $S(KS)K$
(E) $BBB$

---

**Parte B.** Resolva as questões a seguir. Cada questão correta vale 2 pontos (resposta em CDU).

**Q11.** Qual é o número de linhas da tabela-verdade da proposição composta abaixo?
$$P : \lnot(p \land q) \leftrightarrow (\lnot p \lor \lnot q)$$

**Q12.** Quantas são as **regras** definidas no código Prolog abaixo?
```prolog
1  a(1).
2  b(2).
3  c(X) :- a(X) ; b(X).
4  d(X) :- c(X), a(X).
5  e(X) :- c(X), b(X).
```

---

**Parte C.** Implemente, em Prolog, os predicados descritos a seguir. Cada implementação correta
vale 3 pontos.

**Q13.** O predicado `count_odds/2` recebe como primeiro argumento uma lista de inteiros e unifica
o segundo argumento com a **quantidade de números ímpares** presentes na lista.
Exemplos:
```prolog
?- count_odds([1, 2, 3, 4], X).       % X = 2
?- count_odds([2, 4, 6], X).          % X = 0
?- count_odds([], X).                 % X = 0
```

**Q14.** O predicado `power_of_2/1` recebe como argumento um inteiro positivo $N$ e retorna
verdadeiro somente quando $N$ pode ser escrito na forma $2^k$, onde $k$ é um inteiro
não-negativo.
Exemplos:
```prolog
?- power_of_2(1).       % true
?- power_of_2(64).      % true
?- power_of_2(100).     % false
```

---

**Folha de respostas (modelo):** Q1–Q10 (marque A–E) · Q11 e Q12 em CDU (C, D, U) ·
Q13 e Q14 escritas no espaço de código.

> Gabarito comentado em [`SIMULADO_2_GABARITO.md`](SIMULADO_2_GABARITO.md).
