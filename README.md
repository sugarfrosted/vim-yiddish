My little yiddish settings and keymaps for vim.

Install with pathogen by cloning into your bundle folder.

To access set the shortcuts for toggling language and to compose characters add the line "call YiddishShortCuts()" to your .vimrc file or call it yourself.

| Mapping                           | Function                                              |
| --------------------------------- | ----------------------------------------------------- |
| `t/T`                             | toggles between Yiddish and English modes             |
| <code>&#124;</code>               | toggles between non-composed and composed glyphs      |
| <code>&#3d;Leader&#3e;</code>tran | translates selection to current glyph types           |
| <code>&#3d;Leader&#3e;</code>tral | translates buffer to current glyph types              |
| <code>&#3d;F8&#3e;</code>         | toggles between Yiddish and English in insert mode    |
