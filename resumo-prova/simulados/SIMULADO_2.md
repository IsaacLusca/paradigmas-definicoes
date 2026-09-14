# Paradigmas de Programação – Simulado 2 (código SIM2)

**Nome:** ______________________  **Matrícula:** ____________  **Data:** ____/____/______

**Instruções:**
(a) O simulado é individual e sem consulta.
(b) A interpretação dos comandos das questões faz parte da avaliação.
(c) O gabarito deve ser marcado **à caneta**. Marcação à lápis, com rasuras, em branco ou com
múltiplas alternativas assinaladas recebe pontuação zero.
(d) Nas questões abertas (Parte B), marque a resposta no formato **CDU** (centena, dezena, unidade).

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

**Q11.** Considere o predicado abaixo:
```prolog
conta([], 0).
conta([H|T], X) :-
    conta(T, Y),
    (0 =:= H mod 2 -> X is Y + 1 ; X = Y).
```
Qual é o resultado da consulta `?- conta([2, 3, 4, 5, 6], X).`?
(A) X = 0.
(B) X = 2.
(C) X = 3.
(D) X = 4.
(E) X = 5.

**Q12.** Considere o predicado abaixo:
```prolog
p(1, 0).
p(N, K) :-
    N > 1,
    0 =:= N mod 2,
    M is N div 2,
    p(M, K1),
    K is K1 + 1.
```
Qual é o resultado da consulta `?- p(64, K).`?
(A) K = 4.
(B) K = 5.
(C) K = 6.
(D) K = 7.
(E) false.

---

**Parte B.** Resolva as questões a seguir. Cada questão correta vale 3 pontos (resposta em CDU).

**Q13.** Qual é o número de linhas da tabela-verdade da proposição composta abaixo?
$$P : \lnot(p \land q) \leftrightarrow (\lnot p \lor \lnot q)$$

**Q14.** Quantas são as **regras** definidas no código Prolog abaixo?
```prolog
1  a(1).
2  b(2).
3  c(X) :- a(X) ; b(X).
4  d(X) :- c(X), a(X).
5  e(X) :- c(X), b(X).
```

---

**Folha de respostas (modelo):** Q1–Q12 (marque A–E) · Q13 e Q14 em CDU (C, D, U).

> Gabarito comentado em [`SIMULADO_2_GABARITO.md`](SIMULADO_2_GABARITO.md).
