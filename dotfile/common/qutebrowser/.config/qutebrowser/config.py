import subprocess
from pathlib import Path


home = Path.home()


def solarized_color(name):
    return subprocess.check_output(
        [f"{home}/bin/solarized", '-m', 'hex', '-n', name],
        text=True,
    ).rstrip('\n')


config.load_autoconfig()

c.auto_save.session = True
c.completion.height = '30%'
c.content.autoplay = False
c.content.notifications = False
c.editor.command = [f"{home}/bin/st", '-e', f"{home}/bin/nvim", '{}']
c.messages.timeout = 5000
c.scrolling.bar = 'always'
c.tabs.last_close = 'close'
c.tabs.select_on_remove = 'last-used'

config.unbind('J', mode='normal')     # tab-next
config.unbind('K', mode='normal')     # tab-prev
config.unbind('d', mode='normal')     # tab-close
config.unbind('D', mode='normal')     # tab-close -o
config.bind('gt', 'tab-focus --no-last')
config.bind('gT', 'tab-prev')
config.bind('x', 'tab-close')
config.bind('X', 'undo')
config.bind('zi', 'zoom-in')
config.bind('zo', 'zoom-out')
config.bind('z0', 'zoom')
config.bind('<Ctrl-L>', 'search;; clear-messages')

c.tabs.padding = {'top': 0, 'bottom': 0, 'left': 0, 'right': 4}
c.tabs.indicator.padding = {'top': 0, 'bottom': 0, 'left': 0, 'right': 4}
c.tabs.indicator.width = 1
c.colors.tabs.even.bg = 'lightgray'
c.colors.tabs.even.fg = 'black'
c.colors.tabs.indicator.start = 'black'
c.colors.tabs.indicator.stop = 'black'
c.colors.tabs.indicator.system = 'none'
c.colors.tabs.odd.bg = 'lightgray'
c.colors.tabs.odd.fg = 'black'
c.colors.tabs.selected.even.bg = 'darkgray'
c.colors.tabs.selected.even.fg = 'black'
c.colors.tabs.selected.odd.bg = 'darkgray'
c.colors.tabs.selected.odd.fg = 'black'

c.statusbar.padding = {'top': 0, 'bottom': 0, 'left': 4, 'right': 4}
c.colors.statusbar.insert.bg = solarized_color('yellow')
c.colors.statusbar.insert.fg = solarized_color('base03')
c.colors.statusbar.normal.bg = 'lightgray'
c.colors.statusbar.normal.fg = 'black'
c.colors.statusbar.progress.bg = 'darkslategray'
c.colors.statusbar.url.fg = 'darkslategray'
c.colors.statusbar.url.hover.fg = solarized_color('blue')
c.colors.statusbar.url.success.http.fg = 'red'
c.colors.statusbar.url.success.https.fg = 'black'
