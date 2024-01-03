![alt text](__assets__/crossroad.svg)
# *Crossroad Venture Studio:* Design System

[Crossroad Venture Studio](crossroadventurestudio.com) is a company that creates and builds startups. We typically help startups by providing an initial team, strategic direction, and operational support.

## Table of content
- [*Crossroad Venture Studio:* Design System](#crossroad-venture-studio-design-system)
  - [Table of content](#table-of-content)
- [Terms and conditions](#terms-and-conditions)
- [Core](#core)
  - [Colors \& Gradients](#colors--gradients)
  - [Shadows](#shadows)
  - [Fonts and Typography](#fonts-and-typography)
  - [Icons](#icons)
- [Components](#components)
  - [Buttons \& Pills](#buttons--pills)
  - [Flexbox](#flexbox)

# Terms and conditions
By working with *Crossroad*, you are agreeing to the following term and conditions:
- This is a proprietary suite of softwares, tools, framework, design sytem, etc.
- Do not distribute, modify, sell unless consulted and agreed before by William Brendel (brendel.william@gmail.com)

# Core

At the core of the design system lies the definition for colors, gradients, shadows, typography and icons used everywhere in the product we develop.

## Colors & Gradients

[![Figma file](__assets__/figma.svg)](https://www.figma.com/file/Vszpy1wYzuol556bh6gtty/Design-system?type=design&node-id=0-1&mode=design)
[![Css file](__assets__/css.svg)](/css/core/colors.css)

[This](/css/core/colors.css) is where we define the set of colors, shades of colors (e.g. *--blue*) (e.g. *--blue-1, --blue-2, --blue-3, ...*) and gradients (e.g. *--purple-pink-horizontal, --orange-yellow-vertical, --green-lime-diagonal, etc*). Those variables can access in css with the **var()** keywords. For example:

    ...
    <style>
    button {
      background: var(--green-lime-diagonal);
      color: var(--dark)
    }
    </style>
    ...

## Shadows

[![Figma file](__assets__/figma.svg)](https://www.figma.com/file/Vszpy1wYzuol556bh6gtty/Design-system?type=design&node-id=1-52&mode=design)
[![Css file](__assets__/css.svg)](/css/core/shadows.css)

## Fonts and Typography

[![Figma file](__assets__/figma.svg)](https://www.figma.com/file/Vszpy1wYzuol556bh6gtty/Design-system?type=design&node-id=7-1084&mode=design)
[![Css file](__assets__/css.svg)](/css/core/typography.css)

## Icons

[![Figma file](__assets__/figma.svg)](https://www.figma.com/file/Vszpy1wYzuol556bh6gtty/Design-system?type=design&node-id=22-1209&mode=design)
[![Icon files](__assets__/library.svg)](/icons/)

# Components

## Buttons & Pills

## Flexbox
