# Modular forms

Integrate the deep mathematical symmetry of `Modular Forms` into the realm of algorithmic composition and live coding with [Sonic Pi](https://sonic-pi.net/).

![Modular Forms - Image](modular_forms.png)

## Features

- **Accessibility for musicians and coders**: No need for a heavy mathematical background—explore the beauty of modular forms through music.
- **Interactive Educational Tool**: Use Sonic Pi to teach advanced number theory concepts in an engaging, hands-on way. Let students experiment with live coding and experience the immediate connection between mathematics and music.
- **Real-Time Live Coding**: Create dynamic music in real-time using Sonic Pi, exploring the evolution of modular forms through algorithmic manipulation.
- **Mathematical Sound Design**: Generate complex musical patterns, rhythms, timbres, and harmonies based on modular forms, blending math and music seamlessly.

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
eisenstein_melody = ModularForms.eisenstein_series(4)

# Play the melody in a loop with a mathematical transformation
120.times do
  play eisenstein_melody.next % 12 * 7
  sleep 0.5
end
```

## Implemented Modular Forms Generators and Operations

- `ModularForms.eisenstein_series(k)`

## Purpose and Focus

> `modular_forms` is designed to transform complex mathematical functions into a creative tool for composition and live performance. While it provides accurate and precise implementations of these functions, its primary focus is on sonic exploration and musical improvisation rather than theoretical analysis.
>  However, this doesn’t exclude the possibility of discovering interesting mathematical insights through playful experimentation. As you engage with the gem, you may uncover new ideas and patterns that seamlessly blend mathematical beauty with musical creativity.
