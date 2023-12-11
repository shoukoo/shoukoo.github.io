+++
title = "Zellij ❤️ Neovim"
date = "2023-12-09T07:45:25+11:00"

#
# description is optional
#
# description = "An optional description for SEO. If not provided, an automatically created summary will be used."

tags = ["neovim","zellij"]
+++

## Intro
Hello, I recently made a switch from Tmux to [Zellij](https://zellij.dev/), and I have been very happy with the move. It was quite an easy switch, I didn't need to customise much of my setup, thank to the intuitive design of Zellij. For example, the builtin keybindings are easy to remember and also logical; you can press **+** or **-** to resize panes and navigating between panes with arrow keys. And the interface provides you helpful tips to remind you the keybindings for each action. Overtime, all these little details have added up, and significantly reduce the need to google "How to do X". 

I could go on forever on the features I love in Zellij, but for now, let's focus on the primary subject: Neovim + Zellij.

## Problem
I've to admit that the title of this blog is misleading. The reality is that using Neovim with the builtin setup in Zellij can be quite challenging. The main reason is Zellij's use of the "Ctrl" key as the modifier key to switch between [modes](https://zellij.dev/documentation/keybindings-modes), which overlaps with many existing shortcuts in Neovim. For instance, **Ctrl o** switch to the `Session` mode in Zellij, but that key is associated with the jumplist in Neovim. And **Ctrl t** switches to the `Tabs` mode in Zellij, but it's used for interacting with the tagstack. 

Rebinding to a different modifier key is challenging because Zellij only supports Alt and Ctrl modifier keys, and [does not handle composition keys](https://github.com/zellij-org/zellij/issues/735) like `Ctrl Shift o`. 

The common workaround of this issue is to stay in the Lock mode when working with Neovim to block Zellij's shortcuts and then exiting the Lock mode to use Zellij features. 

I gave this solution a shot for a few days, but it didn't quite work for me. I found myself often forgetting to lock/unlock, so I knew I needed to figure out a different approach.

## Solution
My solution is quite simple - make use of the Tmux mode and clear out all key bindings in the Normal mode. The Normal mode in Zellij is similar to the one in Neovim, where you always return when exiting from other modes. And by clearing all the defaults in Normal mode enables me to work freely in Neovim and switch to other modes from the Tmux mode. 

Let's walk through these changes step by step.

First, I removed all the keybindings in the Normal modes. You can achive this in the configuration in the following code:

```kdl

keybinds {
    normal clear-defaults=true {
    }
}

```

As I mentioned earlier, Zellij already supports the Tmux mode, so I brought it back into the workflow. I also rebound the modifier key from `Ctrl b` to `Ctrl f` to switch to the Tmux mode.
 
**Quick Note**: I went with Ctrl f as the modifier key because that's my personal preference – feel free to stick with what works best for you.

```kdl

keybinds {
    normal clear-defaults=true {
        // tmux
        bind "Ctrl f" { SwitchToMode "Tmux"; }
        unbind "Ctrl b"
    }
}

```

Lastly, I made some adjustments in the Tmux mode by clearing the defaults and rebinding the keys. This allows me to jump into the mode with just a single key when in the Tmux mode.

```kdl
    tmux clear-defaults=true {
        bind "Ctrl f" { Write 2; SwitchToMode "Normal"; }
        bind "Esc" { SwitchToMode "Normal"; }
        bind "g" { SwitchToMode "Locked"; }
        bind "p" { SwitchToMode "Pane"; }
        bind "t" { SwitchToMode "Tab"; }
        bind "n" { SwitchToMode "Resize"; }
        bind "h" { SwitchToMode "Move"; }
        bind "s" { SwitchToMode "Scroll"; }
        bind "o" { SwitchToMode "Session"; }
        bind "q" { Quit; }
    }
```

This is it! With this setup I can use `Ctrl f t` in Normal mode to switch to the Tab mode, mirroring a workflow similar to that in Tmux.
As a former Tmux user, this approach feels like returning home. I also added other common shortcuts that bind along with Alt key, you can see the final configuration [here](https://github.com/shoukoo/dotfiles/blob/master/zellij.kdl). 
