+++
title = "Zellij ❤️ Neovim"
date = "2023-12-09T07:45:25+11:00"

#
# description is optional
#
# description = "An optional description for SEO. If not provided, an automatically created summary will be used."

tags = []
+++
I recently made a switch from Tmux to Zellij, and I am very happy with this decision. Using Zellij feels like a breath of fresh air; the creator designed it with the user in mind. I memorised the keybindings in a short time since the keys associated to those actions are logical for example pressing **+** or **-** to resize panes and navigate bettween panes with arrow keys. The user interface also includes helpful tips to remind you the keybinds for each action, all these adds up and significantly reduce the need to google "How to do X". I can talk about many other cool features in Zellij, but let's focus on the main topic - using Neovim in Zellij

Using Neovim ih Zellij is not great due to serveral conflicting keybindings between Zellij and Neovim. For instance, "Ctrl o" to the "Session mode" but that key is working with jumplist in Neovim and "Ctrl t" to the "Tabs mode", whereas in Neovim, it's used for interacting with the tagstack. Finding a workaround for these conflicts is difficult because Zellij has limited support for key configuration; it only supports a limited set of modifier keys, such as Alt and Ctrl, and does not handle composition keys like `Ctrl Shift o`[0]. The common workaround of this issue is to stay in the Lock mode when working with Neovim to block Zellij's shortcuts and get out of Lock mode to use Zellij features. This solution is not suitable for me as I often forget to lock/unlock, on top of that my brain is alrady filled with Neovim shortcuts, I need a workflow that I'm already familiar with

My solution is quite simple. Zellij already support the Tmux mode, allowing me to maintain my usual Tmux workflow which is to prefix all the Zellij's modes/actions with "Ctrl b" (I use control f). Removing all the shortcuts beside the Tmux mode in the Normal mode, this way I can work in Neovim while in Normal without worrying about the conflicts


