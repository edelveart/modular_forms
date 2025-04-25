# Modular forms

A primer on Modular Forms and their mathematical symmetries, made into music through algorithmic composition and live coding with [Sonic Pi](https://sonic-pi.net/).

![Modular Forms - Image](modular_forms.png)

## Features

- **Accessible to both musicians and coders**: No need to be a math expert to jump in. Whether you are a musician curious about code or a coder intrigued by sound, this tool lets you explore modular forms in a creative and intuitive way. Create musical patterns, rhythms, timbres, and harmonies while experimenting with mathematical concepts like they were instruments.
- **Interactive Educational Tool**: Use **Sonic Pi** to teach number theory concepts in a hands-on and immersive way. Allow students to experiment with live coding, hear math in action, and gain insights into abstract concepts through the medium of sound.

## Purpose and Scope

Given the vastness of the field, we intentionally focused on a limited subset of concepts, such as Eisenstein series or Dedekind functions, which are often introduced in early number theory courses.
[See the full list of implemented generators and operations below](#implemented-modular-forms-generators-and-operations)

- **Not optimized for high performance**: This library is designed for creative exploration rather than maximum computational efficiency. It is not a replacement for advanced mathematical software.
- **Normalized modular functions**: Several of these modular functions are normalized, ensuring consistent and standard q-expansions for musical applications.

The goal is simple: to offer an inviting starting point for those who wish to explore, learn, and possibly uncover new ideas, regardless of their mathematical background.

## Installation

You can install the `modular_forms` gem directly from **RubyGems** or clone it from GitHub.

```bash
gem install modular_forms
```

## How to use?

You can dive into the beauty of math, both in Ruby and Sonic Pi, creating music in real-time. Here is a simple example of how to use **modular_forms** to generate a basic musical pattern:

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
