# Combinadores — resumo direto (revisão rápida)

> Só o que cai, em ordem de importância. Versão longa: seção 8 do `RESUMO_PROVA_1.md` e
> `../detalhado/LISTA_COMBINADORES_DETALHADA.md`.

## 1. Conceitos (as duas perguntas clássicas)

- **Combinador = termo fechado, sem variáveis livres:** `FV(M) = ∅`.
- **Aplicação:** justaposição, associando **à esquerda**: `Sfgx` = `((Sf)g)x`.
- **`=` entre combinadores** = **mesmo comportamento** (ex.: `II = I`), não igualdade lógica.

## 2. Os cinco de Schönfinkel (o Z cai!)

| Letra | Nome | Regra | Hoje chamamos |
|---|---|---|---|
| I | identidade | Ix = x | — |
| K | constância | Kxy = x | — |
| T | intercâmbio | (Tφ)xy = φyx | C |
| **Z** | **composição** | Zφχx = φ(χx) | B |
| S | fusão | Sφχx = φx(χx) | — |

**Pegadinha:** letra **Z** = **função de composição** (é o `B` moderno).

## 3. Base SK (decore as 4 igualdades)

```
I = SKK        B = S(KS)K        C = S(BBS)(KK)        M = SII
```

## 4. Regras de redução (uma por vez, da esquerda para a direita)

- Sfgx = (fx)(gx)
- Kxy = x
- Ix = x
- Bfgx = f(gx)
- Cxyz = xzy
- Mx = xx

**Reduções que caem:**

- `SKSabc` = ((SKS)a)bc = (Ka(Sa))bc = **abc**
- `SKS34` → dígitos remanescentes: **34**
- `S((S(K((S(KS))K)))S)(KK)307` (com U = S(K((S(KS))K))):
  1. S(US)(KK)3 = (US3)(KK3)
  2. US3 = B(S3) e KK3 = K
  3. B(S3)K0 = (S3)(K0)
  4. (S3)(K0)7 = (37)0 → dígitos **3, 7, 0** → **370**

## 5. Avaliação preguiçosa (lazy) — cai como conceito

- Reduz só o necessário; o **lado direito não é avaliado** antes da hora.
- `SII(SII)` **não termina** (SII = M, e MM se copia). Mas `KS(SII(SII)) = S` **termina**: o K
  **descarta** o 2º argumento sem avaliá-lo.

## 6. Pássaros (só se sobrar tempo)

| Pássaro | Regra | Em SK |
|---|---|---|
| Bluebird B | Bfgx = f(gx) | S(KS)K |
| Cardinal C | Cxyz = xzy | S(BBS)(KK) |
| Mockingbird M | Mx = xx | SII |
| Blackbird B₁ | B₁abcd = a(bcd) | BBB |
| Dove D | Dabcd = ab(cd) | BB |
| Goldfinch G | Gabcd = ad(bc) | BBC |
| Owl O | Oab = b(ab) | SI |

## 7. Um conectivo gera tudo (NAND/NOR)

- Clássicas: `p → q ≡ ¬p ∨ q` · `p ∧ q ≡ ¬(¬p ∨ ¬q)`
- **NAND (↑):** `¬p = p|p` · `p ∧ q = (p|q)|(p|q)` · `p ∨ q = (p|p)|(q|q)`
- **NOR (↓):** `¬p = p↓p` · `p ∧ q = (p↓p)↓(q↓q)` · `p ∨ q = (p↓q)↓(p↓q)`
- **Conectivo de Schönfinkel:** `f |^x g ≡ (x)[¬f ∨ ¬g]`

## 8. Checklist de 1 minuto

- [ ] Combinador: `FV(M) = ∅`
- [ ] **Z = composição** (e C = T, B = Z)
- [ ] `I = SKK` · `B = S(KS)K` · `C = S(BBS)(KK)` · `M = SII`
- [ ] `SKSabc` → **abc** · dígitos → **370** (concatena na ordem)
- [ ] `SII(SII)` trava; `KS(SII(SII))` termina (lazy)
- [ ] NAND/NOR: as 3 fórmulas de cada
