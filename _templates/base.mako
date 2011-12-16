<%!
    import markdown2 as md
    import cPickle as pic
    import hashlib 
    import datetime

    modified_text = ''

    def includemarkdown(file):
        global modified_text
        fname = '_md_page_hash.pkl'
        try:
            cache = pic.load(open(fname,'rb'))
        except:
            cache = {}
        html = md.markdown(open(file,'r').read().decode('utf8'),extras=['markdown-in-html'])
        hash = hashlib.md5(html.encode('utf8')).digest()
        if cache.get(file,('',0))[0] != hash:
            cache[file] = (hash, datetime.datetime.now())
            pic.dump(cache,open(fname,'w'),protocol=2)
        modified_text = '; Last Modified: %s'%cache[file][1].strftime('%d-%b-%Y')

        return html
%>\
<%def name="filter(chain)">\
${bf.filter.run_chain(chain, capture(caller.body))}\
</%def>\
<%def name="rawmarkdown(file)">\
${includemarkdown(file)}\
</%def>\
${next.body()}
