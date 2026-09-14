# Paradigmas de Programação – Simulado 3 (código SIM3)

**Nome:** ______________________  **Matrícula:** ____________  **Data:** ____/____/______

**Instruções:**
(a) O simulado é individual e sem consulta.
(b) A interpretação dos comandos das questões faz parte da avaliação.
(c) O gabarito deve ser marcado **à caneta**. Marcação à lápis, com rasuras, em branco ou com
múltiplas alternativas assinaladas recebe pontuação zero.
(d) Nas questões abertas (Parte B), marque a resposta no formato **CDU** (centena, dezena, unidade).
(e) Na Parte C, escreva o código Prolog.

**Parte A.** Assinale a alternativa correta. Cada marcação correta vale 2 pontos.

**Q1.** Qual conectivo da lógica proposicional booleana é **falso apenas quando as duas
proposições são verdadeiras**?
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

---

**Parte B.** Resolva as questões a seguir. Cada questão correta vale 2 pontos (resposta em CDU).

**Q11.** Quantas **cláusulas** existem no código Prolog abaixo?
```prolog
1 filme('Matrix', 1999).
2 filme('Interestelar', 2014).
3 filme('Duna', 2021).
4 diretor('Matrix', 'Wachowski').
5 diretor('Interestelar', 'Nolan').
6 classico(X) :- filme(X, A), A < 2000.
7 recente(X) :- filme(X, A), A >= 2020.
8 indicado(X, Y) :- filme(X, _), diretor(X, Y).
```

**Q12.** Aplique a redução-β em `SKS34`, em que $Sfgx = fx(gx)$ e $Kxy = x$ e cada dígito
decimal representa um termo independente. A resposta deve ser a concatenação dos dígitos
remanescentes, na ordem obtida (marque em CDU).

---

**Parte C.** Implemente, em Prolog, os predicados descritos a seguir. Cada implementação correta
vale 3 pontos.

**Q13.** O predicado `max_list/2` recebe como primeiro argumento uma lista **não vazia** de
inteiros e unifica o segundo argumento com o **maior elemento** da lista.
Exemplos:
```prolog
?- max_list([3, 7, 2], X).       % X = 7
?- max_list([9], X).             % X = 9
?- max_list([1, 1, 1], X).       % X = 1
```

**Q14.** O predicado `num_divisors/2` recebe como primeiro argumento um inteiro positivo $N$ e
unifica o segundo argumento com a **quantidade de divisores positivos** de $N$.
Exemplos:
```prolog
?- num_divisors(6, X).       % X = 4  (1, 2, 3, 6)
?- num_divisors(7, X).       % X = 2  (1, 7)
```

---

**Folha de respostas (modelo):** Q1–Q10 (marque A–E) · Q11 e Q12 em CDU (C, D, U) ·
Q13 e Q14 escritas no espaço de código.

> Gabarito comentado em [`SIMULADO_3_GABARITO.md`](SIMULADO_3_GABARITO.md).
