# mystic-twitupd
global blacklist update script thingy

## recommended automation
using crontab, you could set it up thus;

```
0 0 * * * /mystic/scripts/twitupd.sh /path/to/mystic && logger -t "mystic_badips" "[crontab] blacklist.txt/denylist.txt updated"
```

## recommended logrotate config
in the directory `logrotate.d` there's a file called twitupd which is a suggested basic log rotation config
if you change the mystic dirs in the main twitupd.sh, make sure to change the log file location in the logrotate.d config too
