# Paradigmas de Programação – Simulado 3 (código SIM3)

**Nome:** ______________________  **Matrícula:** ____________  **Data:** ____/____/______

**Instruções:**
(a) O simulado é individual e sem consulta.
(b) A interpretação dos comandos das questões faz parte da avaliação.
(c) O gabarito deve ser marcado **à caneta**. Marcação à lápis, com rasuras, em branco ou com
múltiplas alternativas assinaladas recebe pontuação zero.
(d) Nas questões abertas (Parte B), marque a resposta no formato **CDU** (centena, dezena, unidade).

**Parte A.** Assinale a alternativa correta. Cada marcação correta vale 2 pontos.

**Q1.** Qual conectivo da lógica proposicional booleana é **falso apenas quando** as duas
proposições são verdadeiras?
(A) negação conjunta (NOR, $\downarrow$)
(B) negação disjunta (NAND, $\uparrow$)
(C) conjunção
(D) disjunção
(E) bicondicional

**Q2.** Sobre os combinadores, qual igualdade está **correta**?
(A) $I = SKK$
(B) $I = KK$
(C) $B = SII$
(D) $M = SKK$
(E) $C = KK$

**Q3.** Considere o fato `car(honda, red, 4).`. Qual consulta é **verdadeira**?
(A) `?- car(honda, color(red), 4).`
(B) `?- car(honda, red, doors(4)).`
(C) `?- car(honda, red, 4).`
(D) `?- car(red, honda, 4).`
(E) `?- car(honda, red, 4, extra).`

**Q4.** Qual predicado adiciona um novo fato ao **final** da base Prolog?
(A) `asserta/1`
(B) `assertz/1`
(C) `retract/1`
(D) `consult/1`
(E) `dynamic/1`

**Q5.** Considere que exista a definição `is_odd(X) :- 1 =:= X mod 2.`. Qual é o resultado de
`?- include(is_odd, [1, 2, 3, 4], L).`?
(A) L = [1, 3].
(B) L = [2, 4].
(C) L = [1, 3, 5].
(D) L = [].
(E) false.

**Q6.** Qual é o resultado de `?- X is 2 ^ 3 ^ 2.`?
(A) X = 12.
(B) X = 64.
(C) X = 81.
(D) X = 256.
(E) X = 512.

**Q7.** Considere o predicado abaixo:
```prolog
acc([], Acc, Acc).
acc([H|T], A, X) :-
    NewA is A + H,
    acc(T, NewA, X).
```
Qual é o resultado da consulta `?- acc([1, 2, 3, 4], 0, X).`?
(A) X = 0.
(B) X = 4.
(C) X = 6.
(D) X = 10.
(E) X = 24.

**Q8.** Quantas, dentre as quatro consultas abaixo, retornam **verdadeiro**?
```prolog
?- [H|T] = [1, 2, 3], H = 1.
?- X = f(Y), Y = 2, X = f(2).
?- [A, B | C] = [1], A = 1.
?- X \= X.
```
(A) 0 (B) 1 (C) 2 (D) 3 (E) 4

**Q9.** Considere `member/2` já definido. Qual é o resultado de
`?- findall(X, member(X, [a, b, a]), L).`?
(A) L = [a, b].
(B) L = [a, b, a].
(C) L = [a].
(D) L = [].
(E) false.

**Q10.** Qual expressão abaixo tem redução-β que **não termina** (loop infinito)?
(A) `SKK`
(B) `SII(SII)`
(C) `KS(SII(SII))`
(D) `K a b`
(E) `S K K a`

**Q11.** Considere o predicado abaixo:
```prolog
maior([X], X).
maior([H|T], X) :-
    maior(T, Y),
    (H > Y -> X = H ; X = Y).
```
Qual é o resultado da consulta `?- maior([4, 9, 2, 9], X).`?
(A) X = 2.
(B) X = 4.
(C) X = 9.
(D) false.
(E) [4, 9, 2, 9].

**Q12.** Considere o predicado abaixo:
```prolog
nd(N, X) :- nd_(N, 1, 0, X).
nd_(N, D, A, X) :-
    D =< N,
    (0 =:= N mod D -> B is A + 1 ; B = A),
    D1 is D + 1,
    nd_(N, D1, B, X).
nd_(N, D, A, A) :- D > N.
```
Qual é o resultado da consulta `?- nd(12, X).`?
(A) X = 4.
(B) X = 5.
(C) X = 6.
(D) X = 8.
(E) X = 12.

---

**Parte B.** Resolva as questões a seguir. Cada questão correta vale 3 pontos (resposta em CDU).

**Q13.** Quantas **cláusulas** existem no código Prolog abaixo? (Cláusulas = fatos + regras.)
```prolog
1  filme('Matrix', 1999).
2  filme('Interestelar', 2014).
3  filme('Duna', 2021).
4  diretor('Matrix', 'Wachowski').
5  diretor('Interestelar', 'Nolan').
6  classico(X) :- filme(X, A), A < 2000.
7  recente(X) :- filme(X, A), A >= 2020.
8  indicado(X, Y) :- filme(X, _), diretor(X, Y).
```

**Q14.** Aplique a redução-β em `SKS34`, em que $Sfgx = fx(gx)$ e $Kxy = x$ e cada dígito
decimal representa um termo independente. Marque em CDU a concatenação dos dígitos
remanescentes, na ordem obtida.

---

**Folha de respostas (modelo):** Q1–Q12 (marque A–E) · Q13 e Q14 em CDU (C, D, U).

> Gabarito comentado em [`SIMULADO_3_GABARITO.md`](SIMULADO_3_GABARITO.md).
> **Debug linha a linha** em [`../detalhado/SIMULADO_3_DETALHADO.md`](../detalhado/SIMULADO_3_DETALHADO.md).
