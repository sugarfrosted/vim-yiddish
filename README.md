My little yiddish settings and keymaps for vim.

Install with pathogen by cloning into your bundle folder.

To access set the shortcuts for toggling language and to compose characters use the command `:YiddishSC` after startup or add `let g:YiddishMappings` to your .vimrc file or call it yourself.

Keymaps based on: http://www.shoshke.net/uyip/qwerty_os_10.htm

| Mapping                           | Function                                              |
|:---------------------------------:| ----------------------------------------------------- |
| `Alt+t`/`Alt+T`                   | toggles between Yiddish and English modes             |
| <code>&#8224;</code>/<code>&#711;</code>              | toggles between Yiddish and English modes (for mac US English compatibility) |
| <code>&#124;</code>               | toggles between non-composed and composed glyphs      |
| <code>&#60;Leader&#62;tran</code> | translates selection to current glyph types           |
| <code>&#60;Leader&#62;tral</code> | translates buffer to current glyph types              |
| <code>&#60;F8&#62;</code>         | toggles between Yiddish and English in insert mode    |



| Command                           | Function                                              |
| --------------------------------- | ----------------------------------------------------- |
| `:Yidkey`                         | toggles between Yiddish and English modes             |
| `:Precomp`                        | toggles between non-composed and composed glyphs      |
| `:CompTransAll`                   | translates selection to current glyph types           |
| `:CompTransSel`                   | translates buffer to current glyph types              |
| `:YiddishSC`                      | creates the mappings in the above table               |
