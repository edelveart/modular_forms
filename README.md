# Modular forms

Explore the deep mathematical symmetries of `Modular Forms` in the realm of algorithmic composition and live coding with [Sonic Pi](https://sonic-pi.net/).

![Modular Forms - Image](modular_forms.png)

## Features

- **Accessibility for musicians and coders**: No need for a heavy mathematical background—explore the beauty of modular forms through music.
- **Interactive Educational Tool**: Use Sonic Pi to teach number theory concepts in an engaging, hands-on way. Let students experiment with live coding and experience the immediate connection between mathematics and music.
- **Mathematical Sound Design**: Generate complex musical patterns, rhythms, timbres, and harmonies based on modular forms, seamlessly blending math and music. Explore the evolution of modular forms through algorithmic manipulation.

## Installation

You can install the `modular_forms` gem directly from **RubyGems** or clone it from GitHub.

```bash
gem install modular_forms
```

## How to use?

You can dive into the beauty of math, both in Ruby and Sonic Pi, creating music in real-time.  Here’s a simple example of how to use **modular_forms** to generate a basic musical pattern:

```rb
require 'modular_forms'

# Calculate the Eisenstein series of weight k = 4
eisenstein_melody = ModularForms.eisenstein_serie(4)

# Play the melody in a loop with a mathematical transformation
120.times do
  play eisenstein_melody.next % 12 * 7
  sleep 0.5
end
```

## Implemented Modular Forms Generators and Operations

<!-- Normalized -->
1. `ModularForms.eisenstein_serie(weight_k, galois_field = nil)`
2. `ModularForms.eisenstein_series_product(weight_k1, weight_k2, precision)`
3. `ModularForms.eisenstein_serie_power(weight_k, power, precision)`
4. `ModularForms.dedekind_eta_function(pentagonal_coefs = false)`
5. `ModularForms.dedekind_eta_power(power, precision)`
6. `ModularForms.ramanujan_tau_function`
7. `ModularForms.jacobi_theta_function(jacobi_index = 3, square_coefs = false)`
8. `ModularForms.jacobi_theta_power(jacobi_index, power, precision)`
9. `ModularForms.j_invariant(precision)`

## Purpose and Focus

> `modular_forms` is designed to transform complex mathematical functions into a creative tool for composition and live performance. While it provides **accurate** and **precise** implementations of these functions, its primary focus is on sonic exploration and musical improvisation rather than theoretical analysis.
>
>  However, this doesn’t exclude the possibility of discovering interesting mathematical insights through **playful experimentation**. As you engage with the gem, you may uncover **new ideas** and patterns that seamlessly blend mathematical beauty with musical creativity.
