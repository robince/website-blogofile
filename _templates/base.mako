<%!
    import markdown2 as md

    def includemarkdown(file):
        return md.markdown(open(file,'r').read().decode('utf8'),extras=['markdown-in-html'])
%>\
<%def name="filter(chain)">\
${bf.filter.run_chain(chain, capture(caller.body))}\
</%def>\
<%def name="rawmarkdown(file)">\
${includemarkdown(file)}\
</%def>\
${next.body()}
