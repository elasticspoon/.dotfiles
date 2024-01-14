" Reformat Obisdian Callouts for Blog
:%substitute/>[ ]\?\[!WARNING\][-]\? \(.*\)\(\%(\n>.*\)*\)/{: .box-warning .ignore-blockquote }\r\r<!-- prettier-ignore -->\r>**\1**\\\\\2/g
:%substitute/>[ ]\?\[!NOTE\][-]\? \(.*\)\(\%(\n>.*\)*\)/{: .box-note .ignore-blockquote }\r\r<!-- prettier-ignore -->\r>**\1**\\\\\2/g
:%substitute/!\[\(.*\)\](\(.*\))/{% include picture_tag.html src="\2" alt="\1" %}
:%substitute/\t/  /g
:write
