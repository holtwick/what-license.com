import glob

for name in glob.glob("*.txt"):
    txt = open(name).read()
    print '<pre class="license" id="%s">' % name[:-4]
    print txt
    print '</pre>'
