# Themes

Galaxyline now supports themes (only NTBBloodbath's fork atm).

Theming is divided in two types:

1. The actual themes, changing all UI and functionalities
2. Colorschemes for using in your themes

---

> Type 1

These are themes for galaxyline, we can also call them "preconfigured galaxyline".
Actually the only themes included are the example ones, [eviline](../lua/galaxyline/themes/eviline.lua)
and [spaceline](../lua/galaxyline/themes/spaceline.lua), feel free to open a PR to add your own too!

To use these themes you can do the following

```lua
require("galaxyline.themes.theme_name")
```

where `theme_name` is the actual theme name, e.g. `eviline`.

> Type 2

These are colorschemes and just colorschemes. So if you want to use your own theme
but you want to use a popular colorscheme (e.g. gruvbox) and you don't want to look for
the colors palette then you can simply use the built-in one.

```lua
local colors = require("galaxyline.themes.colors").gruvbox
```

And start using it, see [Colors standards](#colors-standards) to know how are colors called
and how to name your own theme colors.

## Dynamic colors

Galaxyline also supports dynamic theme colors changes so you can always have a good looking statusline with your
current colorscheme.

### List of built-in supported colorschemes

- doom-one
- dracula
- nord
- gruvbox

So, how to use dynamic colors? We can make use of the `get_color` function, exposed by `galaxyline.themes.colors` module.

This function takes a parameter, the color name that we're looking for. As an example, if we want to get the blue color we can
do `get_color("blue")` and this will return the blue color hex of the actual colorscheme.

**Note that there are some differences between how we use standard themes and how we use dynamic theming.**

These differences are the following:

1. Since color themes are Lua tables, we can call their values using dots (`.`), e.g. `colors.blue` but
   this doesn't work with our `get_color` function because it is a function and we are already extracting
   the color that we're looking for.
2. Our `get_color` function returns a function that actually returns the color hex (weird, isn't it?), but is
   the only way that I found to make it work, and our ViMode will not like this, so we need to add an extra `()`
   at the end of our `mode_color` table result to actually get the color hex, e.g. `mode_color[vim.fn.mode()]()`.

So by example, for using dynamic colorschemes:

```lua
local colors = require("galaxyline.themes.colors").get_color

-- Left side
  gls.left[1] = {
    RainbowLeft = {
      provider = function()
        return "▊ "
      end,
      highlight = { colors("blue"), colors("bg") },
    },
  }
```

And when using static colors (e.g. when using a specific color theme):

```lua
local colors = require("galaxyline.themes.colors").gruvbox

-- Left side
  gls.left[1] = {
    RainbowLeft = {
      provider = function()
        return "▊ "
      end,
      highlight = { colors.blue, colors.bg },
    },
  }
```

## Making your own themes

> Please see [Colors standards](#colors-standards) to know the colors naming conventions.

Making your own theme is easy as requiring galaxyline colors module, add your theme name and your colors!

By example, to create a theme for [Code dark colorscheme](https://github.com/tomasiser/vim-code-dark):

```lua
-- Check if the end user is using this fork with themes support
-- before trying to add the theme
local present, galaxyline_colors = pcall(require, "galaxyline.themes.colors")
if not present then
  return
end

galaxyline_colors.codedark = {
  bg = "#1e1e1e",
  fg = "#dcdcdc",
  fg_alt = "#808080",
  yellow = "#dcdcaa",
  cyan = "#4ec9b0",
  green = "#608b4e",
  orange = "#ce9178",
  magenta = "#c586c0",
  blue = "#569cd6",
  red = "#f44747",
}
```

> Where should I place this code snippet?

Well since we don't have internal standards for this you can place it everywhere. But I would highly recommend adding
this under a directory like this `lua/your_colorscheme_name/galaxyline/theme.lua` and then source this file
in your colorscheme.

## Colors standards

Color schemes should contain only _and obligatorily_ the following fields:

- bg
- fg
- fg_alt
- yellow
- cyan
- green
- orange
- magenta
- blue
- red

> But, why do we need standards for naming them?

We need these standards because everyone can do his own colorscheme for galaxyline and the end user has the possibility
to dynamically change his galaxyline colorscheme to match is actual Neovim colorscheme, as we saw before.

The only exception could be the personal themes, where only you are going to use your theme (obviously).
