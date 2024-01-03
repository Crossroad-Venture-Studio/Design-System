![alt text](__assets__/crossroad.svg)
# *Crossroad Venture Studio:* Design System

[Crossroad Venture Studio](crossroadventurestudio.com) is a company that creates and builds startups. We typically help startups by providing an initial team, strategic direction, and operational support.

## Table of content
- [*Crossroad Venture Studio:* Design System](#crossroad-venture-studio-design-system)
  - [Table of content](#table-of-content)
- [Terms and conditions](#terms-and-conditions)
- [Default Behavior \& Globals](#default-behavior--globals)
- [Core](#core)
  - [Colors \& Gradients](#colors--gradients)
  - [Shadows](#shadows)
  - [Fonts and Typography](#fonts-and-typography)
- [Components](#components)
  - [Atomic Design](#atomic-design)
    - [History](#history)
    - [Definitions](#definitions)
  - [Atoms](#atoms)
    - [Icons](#icons)
      - [Light Vs. Dark](#light-vs-dark)
      - [Wired Vs. Filled](#wired-vs-filled)
    - [Buttons](#buttons)
    - [Pills](#pills)
    - [Flexboxes](#flexboxes)
  - [Molecules](#molecules)
    - [Nav Bars](#nav-bars)
  - [Organisms](#organisms)
  - [Templates](#templates)
    - [Pages](#pages)
- [Themes](#themes)

# Terms and conditions
By working with *Crossroad*, you are agreeing to the following term and conditions:
- This is a proprietary suite of softwares, tools, framework, design sytem, etc.
- Do not distribute, modify, sell unless consulted and agreed before by William Brendel (brendel.william@gmail.com)

# Default Behavior & Globals

All the design system styles can be loaded using the [index.css](/css/index.css) file:

    <head>
      <link rel="stylesheet" href="../css/index.css">
    </head>

By default:
- padding and spacing are set to 0,
- scrollbars disappear in mobile screen size

# Core

At the core of the design system lies the definition for colors, gradients, shadows, typography used everywhere in the product we develop.
All the core styles can be loaded using the [index.css](/css/core/index.css) file:

    <head>
      <link rel="stylesheet" href="../css/core/index.css">
    </head>

## Colors & Gradients

[![Figma file](__assets__/figma.svg)](https://www.figma.com/file/Vszpy1wYzuol556bh6gtty/Design-system?type=design&node-id=0-1&mode=design)
[![Css file](__assets__/css.svg)](/css/core/colors.css)

[This](/css/core/colors.css) is where we define:
- the set of colors (e.g. *--blue, --red, etc*),
- shades of colors (e.g. *--blue-1, --blue-2, --blue-3, ...*),
- gradients (e.g. *--purple-pink-horizontal, --orange-yellow-vertical, --green-lime-diagonal, etc*).
  
Those variables can access in css with the **var()** keyword. For example:

    ...
    <link rel="stylesheet" href="../css/colors.css">
    <style>
      div {
        background: var(--green-lime-diagonal);
        color: var(--dark);
      }
    </style>
    ...

## Shadows

[![Figma file](__assets__/figma.svg)](https://www.figma.com/file/Vszpy1wYzuol556bh6gtty/Design-system?type=design&node-id=1-52&mode=design)
[![Css file](__assets__/css.svg)](/css/core/shadows.css)

[This](/css/core/shadows.css) is where we define the shadow preset styles. For example:

    <head>
      <link rel="stylesheet" href="../css/shadows.css">
    </head>
    <body>
      <div class="close-shadow"> hello world! </div>
    </body>

## Fonts and Typography

[![Figma file](__assets__/figma.svg)](https://www.figma.com/file/Vszpy1wYzuol556bh6gtty/Design-system?type=design&node-id=7-1084&mode=design)
[![Css file](__assets__/css.svg)](/css/core/typography.css)

The design system [typography](/css/core/typography.css) relies on a set of [font files](/fonts/) and [font definitions](/css/core/fonts.css). We typically use **Avenir Next** (**Metropolis** being the substitute font) for generl text, **Arial Black** for fat titles and buttons, **Anime Ace** for comic book style dialogs, and sometimes **Times** for cursive quotes. For example:

    <head>
      <link rel="stylesheet" href="../css/typography.css">
    </head>
    <body>
      <div class="title"> This is a big title </div>
      <div class="heading"> This is a big heading </div>
      <div class="text"> This is regular text </div>
    </body>

💡 **NOTE:** The font size is already fully responsive to screen sizes.

# Components

At the component level of the design system lies the definition for atom styles, molecule styles, organism styles, template styles and icons used everywhere in the product we develop.
All the component styles can be loaded using the [index.css](/css/components/index.css) file:

    <head>
      <link rel="stylesheet" href="../css/components/index.css">
    </head>

## Atomic Design

For years, designers have been creating style guides, elemental guidelines, mood boards, and various other tools to make our designs more understandable and comprehensive. Developers, meanwhile, have been embracing technologies like Bootstrap, Foundation, Bourbon, and others to make their lives easier when it comes to coding. However, we need compromise and collaboration to make life easier for designers and developers. Atomic design is here to help us with that.

### History

Brad Frost, a passionate young man is the one who deserves credit for the system we are about to discuss in the *Components* section. His insightful book, [Atomic Design by Brad Frost](https://atomicdesign.bradfrost.com/) explores the concept in great detail. Atomic Design was born out of a desire and necessity to have a responsive digital environment. See also [Atomic Design](https://medium.com/galaxy-ux-studio/principles-of-atomic-design-7b03a30c3cb6) blog for a summary.

### Definitions

*Atomic design* is a process that consists of five separate steps that work together to build more coherent, hierarchical, and thoughtful interface design systems. The following are the five stages of atomic design:
- Atoms
- Molecules
- Organisms
- Templates
- Pages

In this design system, we limit ourselves to the top four, since *Pages* involve real assets that are not defined here. Instead, an extension of templates we call *Themes* will be defined after the *Components* section.

## Atoms

In science, an atom is the smallest unit of matter that makes up a chemical element, as well as the smallest unit of a cell. Every solid, liquid, gas, and plasma is made up of neutral or ionized atoms. Similarly, in design, atoms are the most basic components. They are the building blocks of design such as buttons, lines, shapes, icons, text fields, text labels, etc. All atom styles can be loaded using the [index.css](/css/components/atoms/index.css) file:

    <head>
      <link rel="stylesheet" href="../css/components/atoms/index.css">
    </head>

### Icons

[![Figma file](__assets__/figma.svg)](https://www.figma.com/file/Vszpy1wYzuol556bh6gtty/Design-system?type=design&node-id=22-1209&mode=design)
[![Icon files](__assets__/library.svg)](/icons/)

Most [icons](/icons/) are normalized to be 24x24 pixels, exception being made for some social media icons for examples. Icons are oganized in different categories:
- [Actions](/icons/actions/) related type of icons, like *share, add, delete, etc*
- [App store](/icons/app-stores/) icons, i.e. *Google play store* and *Apple app store*
- [Camera](/icons/camera/) icons, like *flash, torch, shutter*
- [Menu](/icons/menu/) icons, like *home, stats, user, etc*
- [Misc](/icons/misc/) icons, like *security, etc*
- [Navigation](/icons/navigation/) icons, like *chevron left, arrow right, etc*
- [Social](/icons/socials/) icons, like *facebook, instagram, etc*
- [Status](/icons/socials/) related icons, like *check, success, warning, etc*
- [Tech stack](/icons/tech-stack/) related icons, like *html, css, javascript, react, etc*

#### Light Vs. Dark

Some icons come in both light and dark color. For example *facebook* has a light version (icon mostly white) [facebook-light.svg](/icons/socials/facebook-light.svg) and a dark version (icon mostly black) [facebook-dark.svg](/icons/socials/facebook-dark.svg). The suffix *-light* or *-dark* in the filename indicates which version it is.

#### Wired Vs. Filled

Some icons come in both wired and filled mode. Wired means the icon is contoured, but not filled. For example *dark calendar* has both a wired and a filled version, [calendar-wired-dark.svg](/icons/menu/calendar-wired-dark.svg) and [calendar-filled-dark.svg](/icons/menu/calendar-filled-dark.svg). The suffix *-filled* or *-wired* in the filename indicates which version it is.

### Buttons

### Pills

### Flexboxes

Flexboxes, *aka Auto layout in Figma*, allow users to create designs that can grow to fill or shrink to fit, and reflow as their contents change.

## Molecules

Molecules are the group of atoms bound together to be the smallest fundamental unit. In design, a molecule can be created by combining two or more atoms. For instance, an input field and a button can combine to become a search form, which can perform the search function on the interface. All molecule styles can be loaded using the [index.css](/css/components/molecules/index.css) file:

    <head>
      <link rel="stylesheet" href="../css/components/molecules/index.css">
    </head>

### Nav Bars

## Organisms

As molecules provide us with a basic unit or building block for designing further, multiple molecules can combine to make an organism. An organism is a collection of molecules that have been bonded together to form complex individual portions of the design such as a login page, form, etc. All organism styles can be loaded using the [index.css](/css/components/organisms/index.css) file:

    <head>
      <link rel="stylesheet" href="../css/components/organisms/index.css">
    </head>

## Templates

Templates are the glues that combine the different organisms or individual sections to create a complete design. For example, the search form (organism) can be used as a template in the hero section of our home page to fetch user information. Multiple such templates, like a login form, carousel, etc. can co-exist to create an interface design. All template styles can be loaded using the [index.css](/css/components/templates/index.css) file:

    <head>
      <link rel="stylesheet" href="../css/components/templates/index.css">
    </head>

### Pages

# Themes
