# Modular Forms

A creative toolkit for exploring modular forms and elliptic curves through [Sonic Pi](https://sonic-pi.net/).

<p align="center">
  <img src="https://img.shields.io/gem/v/modular_forms" alt="Gem Version">
  <img src="https://img.shields.io/gem/dt/modular_forms" alt="Gem Total Downloads">
  <img src="https://img.shields.io/github/stars/edelveart/modular_forms" alt="GitHub Repo stars">
  <img src="https://img.shields.io/github/license/edelveart/modular_forms" alt="GitHub License">
</p>

[![Modular Forms - Image](https://raw.githubusercontent.com/edelveart/modular_forms/main/modular_forms.png)](https://rubygems.org/gems/modular_forms)

## ⚙️ Project Status

This is a pre-alpha release of `modular_forms`. At this stage, only a subset of core mathematical definitions and operations is implemented.

Future updates might include a DSL, depending on how the library is used and the interest from the community. A key challenge lies in creating musical mappings that stay true to the underlying mathematics while also sounding intentional, expressive, and naturally fitting within a musical structure.

## 🧊 Features

- **Accessible to both musicians and coders**: No math expertise required. Create musical patterns, rhythms, timbres, and harmonies by experimenting with mathematical ideas and turning them into sound and effects intuitively.
- **Interactive Educational Resource**: Use **Sonic Pi** to discover introductory number theory in a hands-on, immersive way, gaining insights into abstract concepts through math in action.

## 💡 Purpose and Scope

### Overview

Given the vastness of the field, this tool intentionally focuses on a limited subset of definitions, without covering all aspects of each.

- 🧩 List of implemented modules:
  - [Eisenstein Series](#eisenstein-series)
  - [Eta Functions and Eta Quotients](#eta-functions-and-eta-quotients)
  - [Theta Functions](#theta-functions)
  - [Ramanujan Tau Function](#ramanujan-tau-function)
  - [J-Function](#j-function)
  - [Hecke Operators](#hecke-operators)
  - [SL(2,Z) Group](#sl2z-group)
  - [Dirichlet Characters](#dirichlet-characters)
  - [Elliptic Curves over Rationals](#elliptic-curves-over-rationals)
  - [Elliptic Curves over Finite Fields](#elliptic-curves-over-finite-fields)
  - [Newform Invariants](#newform-invariants)
  - [L-functions](#l-functions)
  - [p-adic Fields](#p-adic-fields)

### Not Optimized for Computational Efficiency

This library is designed for creative exploration rather than maximum computational efficiency. It is **not intended** to replace specialized mathematical software optimized for heavy or large-scale computations. Instead, it draws inspiration from tools like **SageMath**, **Pari/GP**, and the **LMFDB database**.

### Goal

The goal is simple: to provide an accessible and creative starting point for those who wish to explore, learn, and uncover new ideas, regardless of their mathematical background.

## 💎 Installation

You can install the `modular_forms` gem directly from **RubyGems** or clone it from GitHub.

```bash
gem install modular_forms
```

If you are **use Ruby**, then import via
```rb
require 'modular_forms'
```

If you are **using Sonic Pi**, replace `<PATH>` with the directory path to the `modular_forms.rb` file inside the gem installation on your system. You can find the full path by running:

```bash
gem which modular_forms
```

Then require the file like this:

```rb
require "<PATH>/modular_forms.rb"
```

## 🧰 How to use?

### 🎶 Explore Fermat’s Last Theorem in Sonic Pi

The Taniyama–Shimura Conjecture (now the Modularity Theorem), proven for semistable cases by Andrew Wiles, connects elliptic curves over the rationals to modular forms. This profound result was crucial in proving **Fermat’s Last Theorem**.

For example, we can explore the relationship between the elliptic curve `144.a3` and the newform orbit `144.2.a.a` through their L-function,
`L(E, s) = L(f, s)`, in a musical sense.

```rb
require "<PATH>/modular_forms.rb"

# Set precision for the Fourier q-expansion
prec = 20

# Construct a weight 2 newform as an eta quotient
n = ModularForms.dedekind_eta_pow(12, prec, 12)
d1 = ModularForms.dedekind_eta_pow(4, prec, 6)
d2 = ModularForms.dedekind_eta_pow(4, prec, 24)
eta_prod = ModularForms.eta_product(d1, d2)

newform = ModularForms.eta_quotient(n, eta_prod, prec)

# Define the elliptic curve E over F_p
p = 13
ellc = ModularForms.elliptic_curve_fp(p, [0, -1]) # y^2 = x^3 - 1
points = ModularForms.cardinality_fp(ellc) # count points on E mod p

# Compute the modular coefficient a_p of L-function(E, s)
a_p = ModularForms.a_p(p, points)

# Sonify the modular relationship
live_loop :modularity_music do
  play (chord (:a3 + a_p), :m11)[newform.ring.tick],
    amp: a_p, release: 0.125
  sleep 0.125
end
```

### 🎶 Merging Machine and Organism - Warp Up

Unlike the structured Fermat example, this finite loop explores more abstract territory, using multiple concepts to create a sonic landscape that, while grounded in mathematical principles, goes beyond conventional musical forms.

```rb
require "<PATH>/modular_forms.rb"

eisenstein_melody = ModularForms.eisenstein_series(8)
p = 3
ellc = ModularForms.elliptic_curve_q([2, 5])
disc = ModularForms.discriminant_q(ellc)
e8 = eisenstein_melody.take(58)
hecke_op = ModularForms.hecke_operator_prime_non_cusp(e8, p, 8, 20)
j_func = ModularForms.j_function(40)
newform_ac = ModularForms.analytic_conductor(15, 2)
pol = ModularForms.def_pol_2deg(41)

(disc * -1).times do
  synth :subpulse, note: ModularForms.padic_valuation(eisenstein_melody.next, p) % 7 + 70,
    release: 0.25 if (spread (disc % 6), 7).tick(:d)

  synth :chiplead, note: hecke_op.tick(:tp) % 7 + 50,
    release: newform_ac, attack: newform_ac

  synth :fm, note: ModularForms.gauss_sum_triv(5, j_func.tick(:j)) + 51,
    release: 0.25, attack: 0.012,
    pan: ModularForms.analytic_conductor(j_func.look % 15, 4) * rrand_i(-1, 1) if
  spread(ModularForms.gamma1_index(p), 11).tick(:g)

  sample 90, release: 0.125 if pol.tick == 'x'
  sample :ambi_drone, beat_stretch: 0.7 if pol.look == '*'
  sample :bass_drop_c, release: 0.125 if pol.look == '6'

  sleep ModularForms.padic_norm(p, p)
end
```

## 🧩 Implemented Modular Forms, Elliptic Curves, and Related Definitions

### Eisenstein Series

1. `ModularForms.eisenstein_series(weight_k, galois_field = nil)`
2. `ModularForms.eisenstein_series_product(weight_k1, weight_k2, prec)`
3. `ModularForms.eisenstein_series_pow(weight_k, power, prec)`

### Eta Functions and Eta Quotients

4. `ModularForms.dedekind_eta_function(m_scale = 1, pentagonal_coefs = false)`
5. `ModularForms.dedekind_eta_pow(power, prec, m_scale = 1)`
6. `ModularForms.dedekind_sum(h, k)`
7. `ModularForms.eta_product(eta1, eta2, prec = nil)`
8.  `ModularForms.eta_quotient(num_eta, den_eta, prec)`

### Theta Functions

9. `ModularForms.jacobi_theta_function(jacobi_index = 3, square_coefs = false)`
10.  `ModularForms.jacobi_theta_function_pow(jacobi_index, power, prec)`

### Ramanujan Tau Function

11. `ModularForms.ramanujan_tau_function`

### J-Function

12. `ModularForms.j_function(prec)`

### Hecke Operators

13. `ModularForms.hecke_operator_prime_non_cusp(non_cusp_form_arr, prime, weight_k, prec)`
14. `ModularForms.hecke_operator_prime_cusp(cusp_form_arr, prime, weight_k, prec)`

### SL(2,Z) Group

15. `ModularForms.t_gen_matrix(n_power)`
16. `ModularForms.s_gen_matrix(n_power)`
17. `ModularForms.u_gen_matrix(mod_n)`
18. `ModularForms.st_gen_matrix(n_power)`
19. `ModularForms.product_gen_mats(gen_mat_a, gen_mat_b)`
20. `ModularForms.gamma0_index(n)`
21. `ModularForms.gamma1_index(n)`

### Dirichlet Characters

22. `ModularForms.dirichlet_trivchar(modq, a)`
23. `ModularForms.conrey_p_pminus1(modp, a)`
24. `ModularForms.gauss_sum_triv(dirichlet_q, a)`
25. `ModularForms.gauss_sum_conrey_p_minus1(dirichlet_q, a, parity)`

### Elliptic Curves over Rationals

26. `ModularForms.elliptic_curve_q(coefs)`
27. `ModularForms.discriminant_q(curve)`
28. `ModularForms.j_invariant_q(curve)`
29. `ModularForms.point_on_curve_q?(curve, point)`
30. `ModularForms.point_addition_q(curve, p, q)`
31. `ModularForms.scalar_mul_point_q(curve, n, point)`
32. `ModularForms.isogeny_2deg_q(curve, point_2tor)`
33. `ModularForms.isogeny_ndeg_q(curve, point_ntor, order)`
34. `ModularForms.weil_height(x_point)`
35. `ModularForms.canonical_height(curve, point, prec = 64)`

### Elliptic Curves over Finite Fields

36. `ModularForms.elliptic_curve_fp(p, coefs)`
37. `ModularForms.point_on_curve_modp?(curve, point)`
38. `ModularForms.discriminant_modp(curve)`
39. `ModularForms.j_invariant_modp(curve)`
40. `ModularForms.point_addition_modp(curve, p_point, q_point)`
41. `ModularForms.scalar_mul_point_modp(curve, n, point)`
42. `ModularForms.points_fp(curve, point_at_infinity = false)`
43. `ModularForms.cardinality_fp(curve)`
44. `ModularForms.quadratic_twist_fp(curve)`

### Newform Invariants

45. `ModularForms.analytic_conductor(level_n, weight_k)`

### L-functions

46. `ModularForms.a_p(p, cardinality)`

### p-adic Fields

47. `ModularForms.padic_valuation(num_b10, p)`
48. `ModularForms.padic_norm(num_b10, p)`
49. `ModularForms.padic_expansion(num_b10, p, prec = 11, reverse_trim = false)`
50. `ModularForms.def_pol_2deg(p = 2, c = 0, num = 1)`

## 🧪 Testing

Install dependencies first:

```bash
bundle install
```

This project features a comprehensive Minitest suite covering core functionality across modules. While not all edge cases are tested, the main mathematical functions are well validated to ensure correctness and stability.

Run tests with:
```bash
rake test
```
