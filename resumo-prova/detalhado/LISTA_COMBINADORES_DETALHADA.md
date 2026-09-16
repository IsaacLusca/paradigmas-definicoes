# Lista — Combinadores · Explicação detalhada

> Todas as questões da lista de Combinadores resolvidas passo a passo.
> Reduções verificadas (redutor de ordem normal + à mão). Referências: `estudo/RESUMO_PROVA_1.md` (§8).

---

## Parte A — Combinadores (lógica)

### 1. Reescrever com apenas a negação conjunta (↓ = NOR)

A definição: $p \downarrow q = \lnot p \land \lnot q$. Duas identidades resolvem **tudo**:

- $\lnot p = p \downarrow p$ (negação com uma letra)
- $a \land b = (a \downarrow a) \downarrow (b \downarrow b)$ (conjunção via De Morgan)

**(a) $p \land q$:**

$$p \land q = (p \downarrow p) \downarrow (q \downarrow q)$$

**(b) $p \lor q$:** note que $p \lor q = \lnot(\lnot p \land \lnot q) = \lnot(p \downarrow q)$; aplicando a negação com ↓:

$$p \lor q = (p \downarrow q) \downarrow (p \downarrow q)$$

**(c) $\lnot p$:**

$$\lnot p = p \downarrow p$$

> **Nota sobre a folha:** a definição chama ↓ de "negacão conjunta" e o enunciado pede "negação disjunta" — é a **mesma coisa** (NOR). Não se confunda com o NAND (↑), que é outro conectivo.

### 2. Os conectivos ⊕ e ⊙ equivalem a `¬p ∧ q`

Pelo enunciado: $p \oplus q$ é verdadeira **só** quando $p = F$ e $q = V$ — exatamente o caso de $\lnot p \land q$. E $p \odot q$ é falsa quando $p = V$ **ou** $q = F$; negando, é verdadeira quando $p = F$ **e** $q = V$ — também $\lnot p \land q$. Logo **os dois são a mesma proposição**: $\lnot p \land q$.

**(a) Usando negação e conjunção:**

$$\lnot p \land q$$

**(b) Usando apenas a negação conjunta (↓):** aplique a identidade $a \land b = (a \downarrow a) \downarrow (b \downarrow b)$ com $a = \lnot p = p \downarrow p$:

$$\big((p \downarrow p) \downarrow (p \downarrow p)\big) \downarrow (q \downarrow q)$$

**(c) Usando negação e condicional:** lembre que $q \to p \equiv \lnot q \lor p$. Negando: $\lnot(q \to p) \equiv q \land \lnot p$:

$$\lnot(q \to p)$$

### 3. "x não é múltiplo de 3 e y é primo"

Simplifique: $p$ = "x é múltiplo de 3", $q$ = "y é primo". A frase é $\lnot p \land q$.

**(a) Conectivos tradicionais:** $\lnot p \land q$.

**(b) Negação em notação simbólica:** $\lnot(\lnot p \land q) \equiv p \lor \lnot q$ (De Morgan).

**(c) Só com a negação conjunta (↓):** igual à Q2(b):

$$\big((p \downarrow p) \downarrow (p \downarrow p)\big) \downarrow (q \downarrow q)$$

**(d) Só com o conectivo fundamental de Schönfinkel ($|^x$):** o conectivo é $f\,|^x\,g \equiv \lnot f \lor \lnot g$. Duas identidades:

- $\lnot a = a\,|^x\,a$
- $a \lor b = \lnot a\,|^x\,\lnot b$ e, por De Morgan, $a \land b = (a\,|^x\,b)\,|^x\,(a\,|^x\,b)$

Logo $\lnot p \land q$ fica (com $\lnot p = p\,|^x\,p$):

$$\big((p\,|^x\,p)\,|^x\,q\big)\,|^x\,\big((p\,|^x\,p)\,|^x\,q\big)$$

---

## Parte B — Base SK

### 4. Escrever os pássaros com S, K, I, C, B

| Pássaro | Regra | Forma SK | Como conferir |
|---|---|---|---|
| Blackbird $B_1$ | $B_1abcd = a(bcd)$ | $BBB$ | $BBBabcd = a(bcd)$ (aplique $Bfgx = f(gx)$ três vezes) |
| Dove $D$ | $Dabcd = ab(cd)$ | $BB$ | $BBabcd = (ab)(cd)$ |
| Goldfinch $G$ | $Gabcd = ad(bc)$ | $BBC$ | $BBCabcd = (ad)(bc)$ |
| Owl $O$ | $Oab = b(ab)$ | $SI$ | $SIab = (Ib)(ab) = b(ab)$ |

Derivação curta do Owl (para entender o padrão): $SIab$, com $Sfgx = (fx)(gx)$, $f = I$, $g = a$, $x = b$:

$$S\,I\,a\,b = (I\,b)(a\,b) = b\,(a\,b) \quad ✔$$

> A folha chama o Goldfinch de $D$ por engano (o correto é $G$); as formas $BBB/BB/BBC/SI$ foram verificadas por redução.

### 5. Reduções na base SK

Lembre: $Sfgx = (fx)(gx)$ · $Kxy = x$ · $I = SKK$ · $B = S(KS)K$ · $M = SII$ · aplique **sempre à esquerda**.

**(a) `S(K(S(K((S(KS))K))))abcde` = `abc(de)`**

Os blocos `S(K(...))` empilham **composições**: cada $S(Kf)g$ equivale a $Bfg$. Reduzindo da esquerda, a expressão final vira $a\,b\,c\,(d\,e)$. Resultado verificado: `abc(de)`.

**(b) `S(K((S((SK)K))((SK)K)))ab` = `(ab)(ab)`**

```text
(SK)K = I                       (pois S K K = I)
(S((SK)K))((SK)K) = S I I = M    (miolo vira o tordo-imitador)
S(KM)ab = (KM b)(a b) = M(ab)    (regra do S)
M(ab) = (ab)(ab)                 (Mx = xx)
```

**(c) `S(K((S(K(S((SK)K))))K))abc` = `c(ab)`**

```text
(SK)K = I  →  S((SK)K) = SI
Y = S(K(SI))  →  YK x = SI(Kx)
S(K(YK))abc = YK(ab)c = SI(K(ab))c = (I c)((K(ab)) c) = c(ab)
```

> Esta é a correção de um erro que circulava no material (antes dizia `cK`); o valor correto é **`c(ab)`**.

### 6. Prova do pássaro egocêntrico (`EE = E`)

Hipóteses: (1) para quaisquer $A, B$ existe $C$ com $Cx = A(Bx)$; (2) existe $M$ com $Mx = xx$.

Use o "1º rumor" (todo pássaro gosta de alguém): aplicando (1), existe $C$ com $Cx = A(Mx)$. Então:

$$C\,C = A(M\,C) \quad \text{(com } x = C\text{)}$$

Mas, por (2), $M\,C = C\,C$. Juntando:

$$A(M\,C) = C\,C = M\,C \quad \Rightarrow \quad A(M\,C) = M\,C \ \text{ para todo } A.$$

Agora escolha **$A := M$**:

$$M(M\,C) = M\,C.$$

E pela definição do tordo-imitador, $M(M\,C) = (M\,C)(M\,C)$. Logo:

$$(M\,C)(M\,C) = M\,C \quad \Rightarrow \quad E := M\,C \ \text{ satisfaz} \ E\,E = E \quad ✔$$

---

> **Resumo de ouro:** NOR gera tudo com $\lnot p = p \downarrow p$ e $a \land b = (a\downarrow a)\downarrow(b\downarrow b)$; os pares para decorar são $I=SKK$, $B=S(KS)K$, $C=S(BBS)(KK)$, $M=SII$; e as reduções sempre andam **da esquerda para a direita**, uma regra por vez.
