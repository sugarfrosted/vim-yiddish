My little Yiddish settings and keymaps for Vim

Dependencies: For normal usage require `+arabic` or at least `+rightleft` , which is included in Vim compiled with `--with-features=huge` and `--with-features=big`. In order to use custom composition lists the possible dependencies are: Compiled with Python Support (2.7), the program `uconv`, or any installation of `python2.7`(by default uses the program named `python2.7` to select another name or to use a complete path modify `let g:python27location="<location>"`, 2.6 should also work, but is untested.) 

Apple's terminal does not appear compatible with right to left characters in vim, as it displays characters based on their unicode direction. For a replacement I recommend iTerm2, which can be found at http://iTerm2.com. Use either the current beta or the original release. The update of the original release can't display combining characters.

Install with pathogen by cloning into your bundle folder.

To access set the shortcuts for toggling language and to compose characters use the command
`:YiddishSC` after startup or add `let g:YiddishEnabled = 1` (must be set prior to startup)
to your .vimrc file. Non-standard mappings can be assigned to `g:YiddishKeys` as a list, (of the form [char1, char2, ..., charn]). A single can
be assigned a string and multiple as a list of strings. For them to take effect `YiddishSC`
must be called again. Tested on Vim compiled with the `--with-features=huge` option, with
and without python support.

Phonetic keymaps mostly based on: http://www.shoshke.net/uyip/qwerty_os_10.htm

| Mapping                           | Function                                              |
|:---------------------------------:| ----------------------------------------------------- |
| `t`/`T`                           | toggles between Yiddish and English modes             |
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
