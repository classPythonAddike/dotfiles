config.load_autoconfig()

config.source('nord-qutebrowser.py')

c.content.autoplay = False
c.content.blocking.method = 'hosts'
c.content.default_encoding = 'utf-8'
c.content.geolocation = False
c.content.pdfjs = True
c.content.fullscreen.window = True

c.zoom.default = '125%'

config.bind('<Ctrl-=>', 'zoom-in')
config.bind('<Ctrl-->', 'zoom-out')

c.editor.command = ['nvim', '{file}']

c.url.start_pages = ["https://duckduckgo.com/"]
c.url.default_page = c.url.start_pages[0]

c.downloads.location.directory = "/home/pythonaddike/AllFolders/Downloads_Copy/"

c.tabs.padding = {
    "bottom": 10,
    "left": 10,
    "top": 10,
    "right": 10
}
