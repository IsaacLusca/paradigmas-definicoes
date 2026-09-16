# Prolog explicado — fluxo, aritmética, recursão e backtracking

> Guia **didático e independente**: explica como o Prolog *pensa* enquanto executa, com foco em
> **código + passo a passo**. Linguagem simples, sem pressupor nada além do básico de fatos e regras.
>
> Complementa o resumo geral (`resumo-prova/estudo/RESUMO_PROVA_1.md`), mas pode ser estudado sozinho.
> **Todos os exemplos foram testados no SWI-Prolog.**

---

## 0. Antes de tudo: como testar (e o erro que todo mundo comete)

**Regra de ouro:** o prompt do SWI **não declara fatos** — tudo que você digita lá é uma **consulta**
(uma pergunta). Se você digitar `cor(vermelho).` no prompt, o Prolog vai tentar *chamar* `cor/1`
e responder:

```
ERROR: Unknown procedure: cor/1 (DWIM could not correct goal)
```

Isso quer dizer: "não conheço esse predicado" — porque ele **não foi carregado**.

### Formas certas de trabalhar

```powershell
# 1) abrir o SWI já com o arquivo carregado (PowerShell)
swipl -s "C:\caminho\para\meu_arquivo.pl"
```

```prolog
% 2) dentro de uma sessão já aberta: carregar/recarregar
?- ['C:/caminho/para/meu_arquivo.pl'].   % barras normais evitam problema com \
?- [meu_arquivo].                        % se estiver na mesma pasta
?- make.                                 % recarrega só o que mudou (depois de editar)
```

- Depois de **editar** o arquivo: salve e rode `?- make.` (ou recarregue com `[meu_arquivo].`).
- `?- halt.` sai; `Ctrl+C` interrompe algo que travou.

### Testar sem arquivo: criando fatos e regras direto no prompt

Dá para "digitar o programa" no prompt com `assertz/1` — inclusive **regras** (com parênteses
em volta da cláusula, por causa do `:-`):

```prolog
?- assertz(cor(verde)).                  % fato simples
?- assertz((fact(0, F) :- F is 1)).      % REGRA: (cabeça :- corpo) entre parênteses
?- assertz((fact(N, F) :- N > 0, succ(NewN, N), fact(NewN, F1), F is F1 * N)).

?- fact(3, F).                           % já pode testar a recursão!
F = 6.

?- listing(fact/2).                      % ver o que ficou na base
?- retract((fact(0, F) :- F is 1)).      % remover UMA cláusula (regra: a cláusula INTEIRA)
?- retract(cor(verde)).                  % fato: só a cabeça basta
?- retractall(fact(_, _)).               % remover TODAS as cláusulas de uma vez
?- abolish(fact/2).                      % apagar o predicado inteiro
```

- `asserta` insere no **início** da base; `assertz` no **fim** (muda a ordem de tentativa).
- No prompt, o SWI cria o predicado como **dinâmico** sozinho (o `listing` mostra `:- dynamic fact/2.`).
- Para **regra**, o `retract` exige a cláusula **completa** `(cabeça :- corpo)` — só a cabeça não casa.
- Se o predicado veio de um **arquivo consultado**, ele é estático: `assertz`/`retract` dão
  `permission_error(modify, static_procedure)`. Nesse caso, edite o arquivo (com
  `:- dynamic nome/aridade.` se precisar modificar em execução) ou use outro nome.
- O que foi criado no prompt **se perde** ao sair (`halt.`).
- Alternativa clássica: `?- [user].`, digite as cláusulas e encerre com **Ctrl+Z + Enter**
  (Windows) ou **Ctrl+D** (Linux).

---

## 1. Aritmética: o cálculo só acontece dentro do `is`

### 1.1 Prolog não calcula sozinho — `2 + 2` é um *termo*

Para o Prolog, `2 + 2` não é o número 4: é uma **árvore congelada**:

```
2 + 1*3   ≡   +(2, *(1,3))

        +
      /   \
     2     *
          / \
         1   3
```

Quem **derrete** essa árvore (avalia) é só o predicado **`is/2`**. O `=` apenas **unifica**
(casa termos), sem calcular nada.

### 1.2 `is` calcula · `=` congela · `=:=` compara

```prolog
?- X is 3 + 4.        % X = 7        ← is avalia e ATA o resultado
?- X = 3 + 4.         % X = 3+4      ← = só guarda o termo congelado!
?- 2 + 2 = 4.         % false        ← +(2,2) não é o átomo 4
?- 2 + 2 =:= 4.       % true         ← =:= compara VALORES (calcula os dois lados)
?- 1 + 2 = 2 + 1.     % false        ← estrutura diferente: +(1,2) ≠ +(2,1)
?- 1 + 2 =:= 2 + 1.   % true         ← valores: 3 = 3
```

| Operador | O que faz | Exemplo |
|---|---|---|
| `=` | unifica (não calcula) | `X = 3+4` → `X = 3+4` |
| `is` | avalia a direita e ata a esquerda | `X is 3+4` → `X = 7` |
| `=:=` | verdadeiro se os **valores** são iguais | `2+2 =:= 4` → true |
| `=\=` | verdadeiro se os **valores** são diferentes | `2+2 =\= 5` → true |
| `<` `>` `=<` `>=` | comparação de valores | `3 < 5` → true |

> Cuidado no teclado: "menor ou igual" em Prolog é **`=<`**, não `<=`.

### 1.3 Precedência: **menor número liga mais forte**

`*` tem precedência 400, `+` tem 500 → o `*` "gruda" antes:

```prolog
?- X is 2 + 1*3.      % 5   (primeiro 1*3=3, depois 2+3)
?- X is (2 + 1)*3.    % 9   (parênteses mudam a árvore)
```

### 1.4 Divisões, resto e potência

```prolog
?- X is 7 / 2.        % 3.5    ← / é divisão real
?- X is 7 // 2.       % 3      ← // é divisão inteira
?- X is 7 mod 2.      % 1      ← mod é o resto
?- X is 2 ** 10.      % 1024   ← ** e ^ são potência
```

### 1.5 O fluxo completo de `X is 2 + 1*3.`

| Passo | O que o Prolog faz | Estado |
|---|---|---|
| 1 | monta o termo da direita | `+(2, *(1,3))` |
| 2 | avalia de baixo para cima: `1*3` | `3` |
| 3 | continua: `2 + 3` | `5` |
| 4 | unifica a esquerda com o resultado | `X = 5` |

### 1.6 Pegadinhas

- `X is Y + 1.` com `Y` **livre** → erro: `Arguments are not sufficiently instantiated`
  (o `is` precisa que o lado direito esteja **calculável**).
- `X = Y + 1.` **não** dá erro: só guarda o termo (com o `Y` dentro).
- `2 + 2 = 4.` → **false**: esse é o erro conceitual nº 1 de quem vem de Python.

---

## 2. Recursão: descer até o fundo e subir calculando

### 2.1 A receita (sempre as mesmas 2 partes)

1. **Caso base** — a resposta conhecida: encerra a descida.
2. **Caso recursivo** — resolve uma parte e **chama a si mesmo** com um problema menor.

Sem caso base (ou sem diminuir o problema), a recursão **nunca termina**.

```prolog
fact(0, F) :- F is 1.                     % BASE: 0! = 1
fact(N, F) :-                             % RECURSIVO
    N > 0,                                %   só para N positivo
    succ(NewN, N),                        %   NewN = N - 1 (leia: "o sucessor de NewN é N")
    fact(NewN, F1),                       %   DESCE: fatorial de N-1
    F is F1 * N.                          %   SOBE: multiplica na volta
```

### 2.2 Trace de `?- fact(3, F).`

**Descida** — cada chamada fica "pendurada" esperando o resultado de baixo:

```
fact(3, F)      espera F1 e fará F = F1*3
└─ fact(2, F1)  espera F1' e fará F1 = F1'*2
   └─ fact(1, F1')   espera F1'' e fará F1' = F1''*1
      └─ fact(0, F1'') → BASE: F1'' = 1
```

**Subida** — agora a conta acontece, de baixo para cima:

```
fact(0) = 1
1*1 = 1   → fact(1) = 1
1*2 = 2   → fact(2) = 2
2*3 = 6   → fact(3) = 6      ✅ ?- F = 6.
```

> **A descida é uma corrente linear**, não uma bifurcação: cada nível chama **exatamente um**
> nível abaixo e fica esperando. A conta (`F is F1*N`) só executa **na volta**, de baixo para
> cima: a última chamada a descer é a primeira a terminar, e assim por diante até o topo.
> "Bifurcação" de verdade só aparece no **backtracking** (seção 3), quando há múltiplas
> cláusulas/soluções a tentar em cada nível.

### 2.3 O mesmo padrão em listas: `soma/2`

```prolog
soma([], 0).                              % BASE: lista vazia soma 0
soma([H|T], S) :-                         % RECURSIVO
    soma(T, S1),                          %   soma do resto
    S is S1 + H.                          %   + o primeiro elemento
```

Trace de `?- soma([1,2,3], S).`:

| Nível | Chamada | Espera | Volta calculando |
|---|---|---|---|
| 1 | `soma([1,2,3], S)` | `S1` | `S = S1 + 1` |
| 2 | `soma([2,3], S1)` | `S1'` | `S1 = S1' + 2` |
| 3 | `soma([3], S1')` | `S1''` | `S1' = S1'' + 3` |
| 4 | `soma([], S1'')` | — | **BASE: 0** |
| ↑ | subindo | | `0+3=3` · `3+2=5` · `5+1=6` → **S = 6** ✅ |

### 2.4 Recursão de cauda: levando a conta pronta

Na `fact/2`, o cálculo acontece **depois** da chamada (por isso a pilha cresce: são
chamadas penduradas). Na versão **de cauda**, um **acumulador** carrega a conta pronta:

```prolog
factTR(0, Acc, F) :- F is Acc.                        % BASE: devolve o acumulado
factTR(N, Acc, F) :-
    N > 0,
    succ(NewN, N),
    NewAcc is Acc * N,                                % atualiza a conta
    factTR(NewN, NewAcc, F).                          % repassa para o próximo

factorial(N, F) :- factTR(N, 1, F).                   % wrapper: começa com 1
```

Trace de `?- factorial(3, F).` — repare que **não há "subida"**:

| Chamada           | Atualiza o acumulador | Vai para          |
| ----------------- | --------------------- | ----------------- |
| `factTR(3, 1, F)` | `NewAcc = 1*3 = 3`    | `factTR(2, 3, F)` |
| `factTR(2, 3, F)` | `NewAcc = 3*2 = 6`    | `factTR(1, 6, F)` |
| `factTR(1, 6, F)` | `NewAcc = 6*1 = 6`    | `factTR(0, 6, F)` |
| `factTR(0, 6, F)` | base                  | **F = 6** ✅       |

### 2.5 Erros comuns em recursão

- **Esquecer a base** (ou o guard `N > 0`) → o programa não termina (interrompa com `Ctrl+C`).
- **Base sobreposta ao caso geral:** na volta, um `redo` (o `;` do usuário) pode reentrar no caso
  recursivo com valores que já eram caso base → laços infinitos. Garanta que os casos não se misturam.
- **Trocar a ordem dos argumentos** na chamada: `fact(NewN, F1)` ≠ `fact(F1, NewN)`.
- Achar que `F` "já tem valor": **cada nível tem suas próprias variáveis** (`F`, `F1`, `F1'` são distintas).

---

## 3. Backtracking: tentar, falhar, voltar e tentar de novo

### 3.1 A ideia (analogia do labirinto)

Imagine um labirinto com bifurcações. O Prolog:

1. segue um caminho (a 1ª alternativa de cada escolha);
2. se **empaca** (falha), **volta até a última bifurcação** e tenta a próxima alternativa;
3. repete até achar uma resposta ou esgotar tudo.

Cada "escolha" é uma **cláusula** do predicado (tentadas de cima para baixo) ou uma **cláusula que
deu certo e pode dar outra solução** (ponto de escolha). O fluxo aparece em 4 portas:

| Porta | Em palavras |
|---|---|
| **call** | "vou tentar este objetivo agora" |
| **exit** | "consegui! unifiquei" |
| **fail** | "não tenho (mais) nenhuma cláusula que sirva" |
| **redo** | "me pediram outra resposta: volto ao último ponto de escolha" |

### 3.2 Exemplo mínimo (interativo)

```prolog
cor(vermelho).
cor(azul).
```

```
?- cor(X).
X = vermelho          ← exit
;
X = azul              ← redo (você digitou ;), depois exit
;
false.                ← redo, depois fail (acabaram as cláusulas)
```

### 3.3 Conjunção: em falha no meio, o `redo` vem sozinho

```prolog
?- cor(X), X = azul.
   call cor(X)   → exit X = vermelho
   call X = azul → fail                  (vermelho ≠ azul)
   redo cor(X)   → exit X = azul         (tentou a próxima cláusula)
   call X = azul → exit                  → X = azul ✅
```

Moral: você **não** precisa digitar `;` — quando um objetivo falha, o Prolog já volta e tenta
a alternativa anterior automaticamente.

### 3.4 Exemplo com "banco de dados": irmãos

```prolog
pai(joao, maria).
pai(joao, pedro).
pai(maria, ana).
pai(pedro, lucas).

irmao(X, Y) :- pai(P, X), pai(P, Y), X \= Y.
```

Trace de `?- irmao(maria, X).` — leia de cima para baixo, como uma árvore de tentativas:

```
1) pai(P, maria)    → P = joao
2) pai(joao, X)     → X = maria
3) maria \= maria?  → FALHA ✗   (a mesma pessoa)
   ↑ redo: volta para o passo 2 e tenta a próxima cláusula
2') pai(joao, X)    → X = pedro
3') maria \= pedro? → OK ✓
    → X = pedro ✅   (única resposta; se você pedir ;, ele volta e no fim dá false)
```

### 3.5 Vendo o fluxo ao vivo: `trace`

```prolog
?- trace.
?- irmao(maria, X).
```

Saída real do SWI (limpa; a cada passo aperte **espaço** para avançar):

```
   Call: (12) irmao(maria, _2194)
   Call: (13) pai(_3288, maria)
   Exit: (13) pai(joao, maria)
   Call: (13) pai(joao, _2194)
   Exit: (13) pai(joao, maria)
   Call: (13) maria\=maria
   Fail: (13) maria\=maria
   Redo: (13) pai(joao, _2194)
   Exit: (13) pai(joao, pedro)
   Call: (13) maria\=pedro
   Exit: (13) maria\=pedro
   Exit: (12) irmao(maria, pedro)
X = pedro.
```

Desligue com:

```prolog
?- notrace.
?- nodebug.
```

### 3.6 Listar todas as respostas sem apertar `;`

```prolog
todos :- irmao(A, B), write(A - B), nl, fail.   % fail força o backtracking
todos.                                          % cláusula final: sucesso no fim
```

```
?- todos.
maria-pedro
pedro-maria
true.
```

Por que funciona: o `fail` faz o Prolog voltar e procurar o próximo irmão; quando o `irmao/2`
se esgota, a **cláusula final** `todos.` casa e a consulta termina com sucesso (sem o `false.` final).

### 3.7 Mundo fechado, em uma frase

Quando uma consulta dá `false`, o Prolog não está dizendo "isto é falso no mundo real":
está dizendo **"não há prova disso na base"**. Tudo que não está declarado é tratado como falso.

---

## 4. Juntando as três coisas

### 4.1 Contagem regressiva (recursão + aritmética + escrita)

```prolog
contagem(0) :- write(0), nl.                              % base: imprime o 0
contagem(N) :-
    N > 0,
    write(N), nl,
    N1 is N - 1,                                          % aritmética
    contagem(N1).                                         % desce
```

```
?- contagem(3).
3
2
1
0
true.
```

### 4.2 Tabuada (backtracking + aritmética + `fail`)

```prolog
tabuada(N) :-
    between(1, 10, I),              % GERADOR: o backtracking traz I = 1, 2, ..., 10
    R is N * I,                     % aritmética
    write(N), write(' x '), write(I), write(' = '), write(R), nl,
    fail.                           % falha de propósito: pede o próximo I
tabuada(_).                         % sucesso ao final

?- tabuada(3).
3 x 1 = 3
3 x 2 = 6
3 x 3 = 9
3 x 4 = 12
3 x 5 = 15
3 x 6 = 18
3 x 7 = 21
3 x 8 = 24
3 x 9 = 27
3 x 10 = 30
true.
```

Fluxo: `between/3` gera `I = 1` → calcula e imprime → `fail` → **backtracking** → `I = 2` →
... → quando `between` não tem mais valores, ele falha → a cláusula final `tabuada(_).` dá o sucesso.

---

## 5. Erros clássicos (tabela-resumo)

| Sintoma | Causa provável | Correção |
|---|---|---|
| `Unknown procedure: X/N` | arquivo não carregado, nome/aridade errados, ou fato digitado no prompt | carregue o arquivo (`[...]`, `make`) ou use `assertz` |
| `2 + 2 = 4.` → false | `=` não calcula | use `=:=` para comparar valores |
| `Arguments are not sufficiently instantiated` | `is` com variável livre à direita | garanta que o lado direito esteja calculável |
| `Singleton variables: [True]` | variável maiúscula usada uma vez só (provável engano) | minúsculo = átomo; `_` = coringa intencional |
| Laço infinito / trava | recursão sem base ou sem redução | adicione/ajuste o caso base; `Ctrl+C` |
| Só sai a 1ª resposta na enumeração | faltou `fail` | `... , write(X), fail.` + cláusula final |
| Predicado "some" no fim da enumeração | faltou a cláusula final | adicione `predicado.` ou `predicado(_, _).` |
| `a ; b , c` com resultado estranho | precedência: `,` liga mais forte que `;` | escreva `(a ; b), c` |

---

## 6. Mapa mental final (cheat-sheet)

- **3 engrenagens do Prolog:** unificação (casa termos) · ordem (cláusulas de cima para baixo,
  objetivos da esquerda para a direita) · backtracking (falhou? volta e tenta outra).
- **Aritmética:** `is` calcula e ata · `=` congela · `=:=`/`=\=`/`<`/`>` comparam valores.
- **Recursão:** base + passo; se o cálculo acontece na volta → precisa de pilha; com acumulador
  (cauda) → a pilha não cresce.
- **Backtracking:** `;` = redo manual; falha em qualquer objetivo = redo automático; `fail` +
  cláusula final = listar tudo; `trace` = ver as portas ao vivo.
- **Filosofia:** o Prolog não "verifica a realidade" — ele **prova** a partir da sua base
  (mundo fechado: sem prova = falso).

---

**Materiais relacionados:**
- `resumo-prova/estudo/RESUMO_PROVA_1.md` — resumo completo da prova (Prolog + Combinadores)
- `definicoes/02_programacao_logica/` — resumos das 6 aulas com os códigos-fonte (`codes/`)
- `resumo-prova/simulador.html` — simulador de prova interativo
