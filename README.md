# mystic-twitupd
global blacklist update script thingy

## recommended automation
using crontab, you could set it up thus;

```
0 0 * * * /mystic/scripts/twitupd.sh && logger -t "mystic_twitupd.sh" "[crontab] blacklist.txt updated"
```
