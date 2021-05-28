# Noto font issues

## Font priority

Modify the CJK font order in

```
/etc/fonts/conf.avail/64-language-selector-prefer.conf
```

put SC/TC before JP

## Emoji not showing correctly in top bar

This may because you've installed a new emoji font and refreshed the font cache, but without restart the gnome shell
