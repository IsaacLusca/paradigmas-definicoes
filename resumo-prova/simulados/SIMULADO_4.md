# Paradigmas de Programação – Simulado 4 (código SIM4)

**Nome:** ______________________  **Matrícula:** ____________  **Data:** ____/____/______

**Instruções:**
(a) O simulado é individual e sem consulta.
(b) A interpretação dos comandos das questões faz parte da avaliação.
(c) O gabarito deve ser marcado **à caneta**. Marcação à lápis, com rasuras, em branco ou com
múltiplas alternativas assinaladas recebe pontuação zero.
(d) Nas questões abertas, marque a resposta no formato **CDU** (centena, dezena, unidade).

> **Este simulado reproduz a Prova 1 aplicada (4BAE41)** — Parte A e Parte B com as questões
> originais. A Parte C substitui as questões de escrita de código por **Combinadores/Base SK**
> (conteúdo da antiga Prova 2) e pela **análise** dos predicados que eram pedidos.
> **18 questões · 30 pontos** (sem escrita de código).

**Parte A.** Assinale a alternativa correta. Cada marcação correta vale 2 pontos.

**Q1.** Em relação à lógica proposicional booleana, qual, dentre os conectivos abaixo, representa
a bicondicional?
(A) ∧ (B) ∨ (C) ¬ (D) → (E) ↔

**Q2.** Considere os fatos abaixo, relativos ao predicado `op/2`:
```prolog
op(true, true).
```
Neste cenário, o predicado `op/2` implementa, em Prolog, qual dentre os conectivos da lógica
booleana abaixo?
(A) disjunção
(B) conjunção
(C) condicional
(D) bicondicional
(E) disjunção exclusiva

**Q3.** Considere o predicado
```prolog
f(X) :- X is 2 + 1*3.
```
Qual é o resultado da consulta abaixo?
```prolog
?- f(Y).
```
(A) Y = 5.
(B) Y = 7.
(C) Y = 8.
(D) Y = 9.
(E) Y = 10.

**Q4.** Em SWI-Prolog, qual diretiva permite definir, para um predicado, a precedência, a
associatividade e a posição em relação aos seus argumentos?
(A) `:- op`
(B) `:- dynamic`
(C) `:- use_module`
(D) `:- meta_predicate`
(E) `:- arithmetic_function`

**Q5.** Considere, em Prolog, uma consulta composta pela conjunção das consultas Q1, Q2 e Q3,
nesta ordem. Qual o comando deve ser inserido no listener para que o fluxo de execução entre na
consulta Q3 pela porta **redo**?
(A) ;
(B) call
(C) exit
(D) fail
(E) redo

**Q6.** Considere o código Prolog abaixo:
```prolog
alfa(a, 1, True).
beta(25).
gama(banana, laranja).
delta(norte, 9.0, sul, 4.5).
omega :- f(A, B, C), write(B), nl.
```
Qual é a aridade do predicado `alfa`?
(A) 0 (B) 1 (C) 2 (D) 3 (E) 4

**Q7.** Considere o predicado `f/3` definido a seguir:
```prolog
f(N, M, X) :- g(M, N, X).

g(M, N, X) :-
    N > 0,
    (N mod 2 =:= 0
     -> NewN is N div 2
     ; NewN is 3*N + 1),
    succ(NewM, M),
    g(NewM, NewN, X).

g(0, X, X).
```
Qual é o resultado da consulta abaixo?
```prolog
?- f(10, 4, X).
```
(A) X = 4.
(B) X = 5.
(C) X = 7.
(D) X = 8.
(E) X = 10.

**Q8.** Quantas, dentre as quatro consultas abaixo, retornam **falso**?
```prolog
?- 2 + 2 = 4.
?- X = Y.
?- f(_) = f(x, x).
?- f(_, g(B, c)) = f(A, g(b, C)), B \= C.
```
(A) 0 (B) 1 (C) 2 (D) 3 (E) 4

**Q9.** Qual, dentre os predicados abaixo, retorna verdadeiro apenas quando o seu argumento à
esquerda **não unifica** com o seu argumento à direita?
(A) = (B) \= (C) \+ (D) =:= (E) =\=

**Q10.** Considere o predicado `p/2` definido abaixo.
```prolog
p([_|[]], X) :- p([], X).
p([], 0).

p([A,B|C], X) :-
    p(C, NewX),
    X is NewX + (B - A).
```
Qual é o primeiro retorno da consulta abaixo?
```prolog
?- p([2, 3, 5], X).
```
(A) X = 1 (B) X = 2 (C) X = 3 (D) X = 4 (E) X = 5

---

**Parte B.** Resolva as questões a seguir (resposta em CDU). Cada questão correta vale 2 pontos.

**Q11.** Qual é o número de linhas da tabela-verdade da proposição composta abaixo?
$$P : (p \lor (q \land p)) \land (\sim p \lor (p \land q))$$

**Q12.** Quantas são as **regras** definidas no código Prolog abaixo?
```prolog
1  f(1, 2).
2  f(2, 2).
3  f(3, 1).
4
5  g(1).
6  g(2).
7  g(3).
8  h(10).
9
10 f(X, Y) :- g(X), h(Y).
11 f(X, X) :- g(X) ; h(X).
12 g(Z) :- f(1, Z).
```

---

**Parte C.** Combinadores (Base SK) e análise de código. Cada questão correta vale 1 ponto.

**Q13.** Em seu artigo sobre combinadores, Schönfinkel utilizou a letra maiúscula **Z** para
representar qual função particular?
(A) Função de fusão
(B) Função identidade
(C) Função constância
(D) Função de composição
(E) Função de intercâmbio

**Q14.** Sejam S e K dois combinadores tais que `Sfgx = fx(gx)` e `Kxy = x`. Qual, dentre as
expressões abaixo, pode ser obtida a partir da expressão `SKSabc`, por meio de uma ou mais
aplicações da redução-β?
(A) b
(B) ac
(C) bc
(D) Sbc
(E) abc

**Q15.** Seja x uma variável e M, N termos-λ. Qual, dentre as notações abaixo, expressa o conceito
de combinadores?
(A) MN
(B) λx.M
(C) M[x := N]
(D) FV(M) = ∅
(E) ∀x, Mx ≡ Nx

**Q16.** O predicado `is_sum_of_5/1` recebe um inteiro positivo N e retorna verdadeiro somente
quando N pode ser escrito como soma de **cinco inteiros positivos distintos**. Considere a
implementação correta abaixo e as três consultas:
```prolog
is_sum_of_5(N) :-
    N >= 15,
    between(1, N, A),
    between(A, N, B), A < B,
    between(B, N, C), B < C,
    between(C, N, D), C < D,
    between(D, N, E), D < E,
    N =:= A + B + C + D + E.
```
```prolog
?- is_sum_of_5(5).
?- is_sum_of_5(15).
?- is_sum_of_5(30).
```
Quantas dessas consultas retornam **true**?
(A) 0 (B) 1 (C) 2 (D) 3 (E) 4

**Q17.** O predicado `power_of_5/1` recebe um inteiro positivo N e retorna verdadeiro somente
quando N pode ser escrito na forma 5^k, com k inteiro não-negativo. Considere a implementação
abaixo e as três consultas:
```prolog
power_of_5(1).
power_of_5(N) :-
    N > 1,
    N mod 5 =:= 0,
    M is N div 5,
    power_of_5(M).
```
```prolog
?- power_of_5(1).
?- power_of_5(25).
?- power_of_5(100).
```
Quais são os resultados, respectivamente?
(A) true · true · true
(B) true · true · false
(C) false · true · false
(D) true · false · false
(E) true · false · true

**Q18.** Determine a redução-β da expressão
`S((S(K((S(KS))K)))S)(KK)307`
em que `Sfgx = fx(gx)`, `Kxy = x` e cada dígito decimal representa um termo independente. A
resposta deve ser formada pela concatenação dos dígitos remanescentes, na ordem obtida, ignorando
eventuais parênteses.

---

**Folha de respostas (modelo):** Q1–Q10 e Q13–Q17 (marque A–E) · Q11, Q12 e Q18 em CDU (C, D, U).

> Gabarito comentado em [`SIMULADO_4_GABARITO.md`](SIMULADO_4_GABARITO.md).
> **Debug linha a linha** em [`../detalhado/SIMULADO_4_DETALHADO.md`](../detalhado/SIMULADO_4_DETALHADO.md).
