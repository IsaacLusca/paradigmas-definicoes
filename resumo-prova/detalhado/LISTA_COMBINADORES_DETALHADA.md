# Lista de Combinadores — explicado do zero

> Cada questão diz **o que você precisa saber** (as regras) e a resolução passo a passo.
> Fontes: lista do curso (Q1–Q6) + exercícios dos simulados e da prova 704C60.

---

## Kit mínimo (leia antes de tudo)

**1. Aplicação.** `fx` = "f aplicado a x". Aplicação associa **à esquerda**: `Sfgx` = `((Sf)g)x`.
Parênteses só mudam a ordem.

**2. Combinador.** Função de pura aplicação: **sem variáveis livres** → `FV(M) = ∅`.

**3. Currying.** Toda função é **unária**: `f(x,y)` se escreve `(fx)y`. Por isso `Sfgx` é uma cadeia de aplicações.

**4. Os cinco de Schönfinkel.**

| Letra | Regra | Nome atual |
|---|---|---|
| I | `Ix = x` | identidade |
| K | `Kxy = x` | constância |
| T | `(Tφ)xy = φyx` | C (troca argumentos) |
| Z | `Zφχx = φ(χx)` | B (composição) |
| S | `Sφχx = φx(χx)` | fusão |

**5. Base SK (decore).** `I = SKK` · `B = S(KS)K` · `C = S(BBS)(KK)` · `M = SII`

**6. Reduzir = trocar padrão pelo resultado.** Sempre da esquerda para a direita, um passo por vez:

| Padrão | Vira |
|---|---|
| `Sfgx` | `(fx)(gx)` |
| `Kxy` | `x` |
| `Ix` | `x` |
| `Bfgx` | `f(gx)` |
| `Cxyz` | `xzy` |
| `Mx` | `xx` |

**7. Preguiça (lazy).** O lado direito **não é avaliado** se não for usado:
`KS(SII(SII)) = S` termina, mas `SII(SII)` **não termina** (`MM → MM → ...`).

---

## Parte 1 — Lista do curso

### 1) P∧Q, P∨Q, ¬P usando só a NOR (↓)

**O que você precisa saber:**
- `p ↓ q = ¬p ∧ ¬q`
- `¬p = p ↓ p`
- `a ∧ b = (a ↓ a) ↓ (b ↓ b)`
- `a ∨ b = (a ↓ b) ↓ (a ↓ b)`

**Resolução:**
- (a) `p ∧ q = (p ↓ p) ↓ (q ↓ q)`
- (b) `p ∨ q = (p ↓ q) ↓ (p ↓ q)`
- (c) `¬p = p ↓ p`

*(A folha mistura "negação conjunta" e "negação disjunta" — é o mesmo conectivo, a NOR.)*

### 2) Mostrar que p⊕q e p⊙q são ¬p ∧ q

**O que você precisa saber:**
- `p ⊕ q` é verdadeiro só com p=F, q=V → exatamente `¬p ∧ q`.
- `p ⊙ q` é falso se p=V ou q=F → negando, também é `¬p ∧ q`.
- Para a versão com →: `q → p ≡ ¬q ∨ p`, logo `¬(q → p) ≡ ¬p ∧ q`.

**Resolução:**
- (a) negação e conjunção: `¬p ∧ q`
- (b) só ↓: `((p ↓ p) ↓ (p ↓ p)) ↓ (q ↓ q)`
- (c) negação e →: `¬(q → p)`

### 3) "x não é múltiplo de 3 e y é primo", em 4 notações

**O que você precisa saber:** p = "x é múltiplo de 3", q = "y é primo" → a frase é `¬p ∧ q`;
De Morgan `¬(a ∧ b) ≡ ¬a ∨ ¬b`; e as regras do item 1 + `¬a = a |^x a`.

**Resolução:**
- (a) tradicional: `¬p ∧ q`
- (b) negação: `p ∨ ¬q`
- (c) só ↓: `((p ↓ p) ↓ (p ↓ p)) ↓ (q ↓ q)`
- (d) só `|^x`: `((p |^x p) |^x q) |^x ((p |^x p) |^x q)`

### 4) Formas SK dos pássaros

**O que você precisa saber:** as formas do Kit (item 5) e aplicação à esquerda.

**Resolução:**

| Pássaro | Regra | Em SK |
|---|---|---|
| Blackbird B₁ | `B₁abcd = a(bcd)` | `BBB` |
| Dove D | `Dabcd = ab(cd)` | `BB` |
| Goldfinch G | `Gabcd = ad(bc)` | `BBC` |
| Owl O | `Oab = b(ab)` | `SI` |

*(A folha chama o Goldfinch de D por engano.)*

### 5) Reduzir as três expressões

**O que você precisa saber:** `Sfgx = (fx)(gx)` · `Kxy = x` · `(SK)K = I` · `SII = M`.

**Resolução:**
- (a) `S(K(S(K((S(KS))K))))abcde = abc(de)`
- (b) `S(K((S((SK)K))((SK)K)))ab`: o miolo `(SK)K = I` dá `SII = M`, então
  `S(KM)ab = (KMb)(ab) = M(ab) = (ab)(ab)`
- (c) `S(K((S(K(S((SK)K))))K))abc = c(ab)`

### 6) Pássaro egocêntrico (existe E com EE = E)

**O que você precisa saber:** as hipóteses (existe C com `Cx = A(Bx)`; existe M com `Mx = xx`) e a ideia:
usar o 1º rumor e depois tomar **A = M**.

**Resolução:**
1. Tome C com `Cx = A(Mx)`. Com `x = C`: `CC = A(MC)`.
2. Como `Mx = xx`, vale `MC = CC`. Logo `A(MC) = MC`.
3. Agora **A = M**: `M(MC) = MC`. Mas `M(MC) = (MC)(MC)`.
4. Portanto `E := MC` satisfaz `EE = E`. ✔

---

## Parte 2 — Exercícios extra (simulados + prova 704C60)

> Todos são **só de combinadores**. Gabarito completo no fim.

### E1) Letra Z de Schönfinkel
**Fonte:** SIM1 Q9 · SIM4 Q13 · 704C60 Q1 — **Resp.: D**
**O que precisa saber:** `Zφχx = φ(χx)` é a **composição** (hoje chamada B).
**Resolução:** Z = função de composição.

### E2) Reduzir `S(KS)Kabc`
**Fonte:** SIM1 Q10 — **Resp.: E (`a(bc)`)**
**O que precisa saber:** `S(KS)K = B` e `Bfgx = f(gx)`.
**Resolução:** `S(KS)Kabc = B a b c = a(bc)`.

### E3) Reduzir `SKSabc`
**Fonte:** SIM4 Q14 · 704C60 Q2 — **Resp.: E (`abc`)**
**O que precisa saber:** `Sfgx = (fx)(gx)` · `Kxy = x` · aplicar à esquerda.
**Resolução:** `((SKS)a)bc = (Ka(Sa))bc = abc`.

### E4) Definição de combinador
**Fonte:** SIM2 Q9 (**C**) · SIM4 Q15 (**D**) · 704C60 Q3 (**D**)
**O que precisa saber:** combinador = termo **fechado**: `FV(M) = ∅`.
**Resolução:** a opção correta é a que diz "sem variáveis livres".

### E5) Forma SK do tordo-imitador M (`Mx = xx`)
**Fonte:** SIM2 Q10 — **Resp.: B (`SII`)**
**O que precisa saber:** `Ix = x` e `Sfgx = (fx)(gx)`.
**Resolução:** `Ma = aa = Ia(Ia) = SIIa`.

### E6) Qual igualdade está correta
**Fonte:** SIM3 Q2 — **Resp.: A (`I = SKK`)**
**O que precisa saber:** as 4 formas do Kit: `I = SKK`, `B = S(KS)K`, `C = S(BBS)(KK)`, `M = SII`.
**Resolução:** só `I = SKK` está certa.

### E7) Qual redução não termina (loop)
**Fonte:** SIM3 Q10 — **Resp.: B (`SII(SII)`)**
**O que precisa saber:** `SII = M`, `Mx = xx` e a preguiça.
**Resolução:** `SII(SII) = MM → MM → ...`; já `KS(SII(SII)) = S` termina (K descarta sem avaliar).

### E8) Reduzir `SKS34` (resposta em CDU)
**Fonte:** SIM3 Q14 — **Resp.: 034**
**O que precisa saber:** regras de S e K.
**Resolução:** `((SKS)3)4 = (K3(S3))4 = 3 4` → dígitos **3, 4**.

### E9) Reduzir `S((S(K((S(KS))K)))S)(KK)307` (resposta em CDU)
**Fonte:** SIM4 Q18 · 704C60 Q13 — **Resp.: 370**
**O que precisa saber:** regras de S e K e `S(KS)K = B`.
**Resolução:**
1. `S(US)(KK)3 = (US3)(KK3)` (U = `S(K((S(KS))K))`)
2. `US3 = B(S3)` e `KK3 = K`
3. `B(S3)K0 = (S3)(K0)`
4. `(S3)(K0)7 = (37)0` → dígitos **3, 7, 0**

---

### Gabarito (conferência rápida)

**E1** D · **E2** E · **E3** E · **E4** `FV(M)=∅` (SIM2: C; SIM4/704C60: D) · **E5** B · **E6** A · **E7** B · **E8** 034 · **E9** 370
