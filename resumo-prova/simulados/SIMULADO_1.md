# Paradigmas de Programação – Simulado 1 (código SIM1)

**Nome:** ______________________  **Matrícula:** ____________  **Data:** ____/____/______

**Instruções:**
(a) O simulado é individual e sem consulta.
(b) A interpretação dos comandos das questões faz parte da avaliação.
(c) O gabarito deve ser marcado **à caneta**. Marcação à lápis, com rasuras, em branco ou com
múltiplas alternativas assinaladas recebe pontuação zero.
(d) Nas questões abertas (Parte B), marque a resposta no formato **CDU** (centena, dezena, unidade).

**Parte A.** Assinale a alternativa correta. Cada marcação correta vale 2 pontos.

**Q1.** Em relação à lógica proposicional booleana, qual conectivo é **falso apenas quando**
as duas proposições são falsas?
(A) ¬ (B) ∨ (C) ∧ (D) → (E) ↔

**Q2.** Considere os fatos abaixo, relativos ao predicado `xor/2`:
```prolog
xor(true, false).
xor(false, true).
```
Neste cenário (base fechada), o predicado `xor/2` implementa, em Prolog, qual conectivo?
(A) conjunção
(B) disjunção
(C) condicional
(D) disjunção exclusiva
(E) bicondicional

**Q3.** Considere o predicado:
```prolog
f(X) :- X is (2 + 3) * 2 - 1.
```
Qual é o resultado da consulta `?- f(Y).`?
(A) Y = 9.
(B) Y = 10.
(C) Y = 11.
(D) Y = 12.
(E) Y = 13.

**Q4.** Em SWI-Prolog, qual predicado consulta a precedência, a associatividade e a posição de
um operador **já definido**?
(A) `op/3`
(B) `current_op/3`
(C) `dynamic/1`
(D) `is/2`
(E) `meta_predicate/1`

**Q5.** Considere, em Prolog, uma consulta composta pela conjunção das consultas Q1, Q2 e Q3,
nesta ordem, que obteve sucesso. O usuário digita o ponto-e-vírgula. Por qual porta o fluxo
reentra e em qual consulta?
(A) `call`, na consulta Q1
(B) `exit`, na consulta Q3
(C) `redo`, na consulta Q3
(D) `fail`, na consulta Q1
(E) `redo`, na consulta Q1

**Q6.** Considere o código Prolog abaixo:
```prolog
r(a, 1).
s(2, b, c).
t(X) :- s(X, _, _).
```
Qual é a aridade do predicado `s` e quantas **regras** existem no código?
(A) `s/2` e 0 regras
(B) `s/3` e 0 regras
(C) `s/3` e 1 regra
(D) `s/2` e 1 regra
(E) `s/1` e 1 regra

**Q7.** Considere o predicado `h/2` definido a seguir:
```prolog
h(0, 0).
h(N, X) :-
    N > 0,
    M is N - 1,
    h(M, Y),
    X is Y + N.
```
Qual é o resultado da consulta `?- h(4, X).`?
(A) X = 4.
(B) X = 6.
(C) X = 8.
(D) X = 10.
(E) X = 12.

**Q8.** Quantas, dentre as quatro consultas abaixo, retornam **verdadeiro**?
```prolog
?- 1 + 1 =:= 2.
?- 3 =:= 4.
?- f(a) = f(b).
?- X = 1, Y = 2, X \= Y.
```
(A) 0 (B) 1 (C) 2 (D) 3 (E) 4

**Q9.** Em seu artigo sobre combinadores, Schönfinkel utilizou a letra maiúscula **Z** para
representar qual função particular?
(A) Função identidade
(B) Função constância
(C) Função de intercâmbio
(D) Função de composição
(E) Função de fusão

**Q10.** Reduzindo a expressão `S(KS)Kabc`, com $Sfgx = fx(gx)$ e $Kxy = x$, obtém-se:
(A) `a`
(B) `b`
(C) `c`
(D) `abc`
(E) `a(bc)`

**Q11.** Considere o predicado abaixo:
```prolog
p(1, 0).
p(N, K) :-
    N > 1,
    0 =:= N mod 3,
    M is N div 3,
    p(M, K1),
    K is K1 + 1.
```
Qual é o resultado da consulta `?- p(81, K).`?
(A) K = 3.
(B) K = 4.
(C) K = 5.
(D) K = 6.
(E) false.

**Q12.** Considere o predicado abaixo:
```prolog
soma(N) :-
    between(1, N, A),
    between(A, N, B),
    A < B,
    N =:= A + B.
```
Quantas **soluções distintas** produz a consulta `?- soma(5).`?
(A) 0 (B) 1 (C) 2 (D) 3 (E) 4

---

**Parte B.** Resolva as questões a seguir. Cada questão correta vale 3 pontos (resposta em CDU).

**Q13.** Qual é o número de linhas da tabela-verdade da proposição composta abaixo?
$$P : (p \land \lnot q) \lor (\lnot p \to (q \land r))$$

**Q14.** Quantas são as **regras** definidas no código Prolog abaixo?
```prolog
1  p(a).
2  p(b).
3  q(X) :- p(X).
4  q(c).
5  r(X) :- q(X).
6  s(X) :- r(X).
7  s(X) :- q(X).
```

---

**Folha de respostas (modelo):** Q1–Q12 (marque A–E) · Q13 e Q14 em CDU (C, D, U).

> Gabarito comentado em [`SIMULADO_1_GABARITO.md`](SIMULADO_1_GABARITO.md).
