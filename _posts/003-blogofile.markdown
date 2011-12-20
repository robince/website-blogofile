---
categories: code
date: 2011/12/20 12:31:39
title: "Blogofile setup : date modified and category headings"
---

I recently moved [this site](https://github.com/robince/robinince.net) to [Blogofile](http://www.blogofile.com/), a Python + Mako static site and blog generator. It works really nicely, but there were a couple of additions I made that might be interesting for others.

## Date modified on static (non-blog) pages

One feature my old [Template Toolkit](http://template-toolkit.org/) based website had was the automatic updating of "Date Modified" tags in the footer of static pages, so visitors (including me) can easily see when the content was last updated.

This is not so easy with Blogofile, since it deletes and recreates the whole site on each build rather than tracking dependencies and updating only changed files. But since I am keeping static pages seperately in pure markdown and including them into corresponding Mako templates I was able to implement a quick check there  - cache-ing a hash of the generated html as a crude way to check for changes. Here is my [base.mako](https://github.com/robince/robinince.net/blob/master/_templates/base.mako):

$$code(lang=mako)
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
$$/code

I use [markdown2](https://github.com/trentm/python-markdown2) so I can use `div`'s in the markdown source. I pass the `modified_text` variable to `footer.mako` when it is `%include`d in `site.mako`.

## Category headings

One thing I find a bit annoying with the standard blogofile setup is that when viewing a list of posts in a category, there is no indication that you are viewing a category rather than the main listing of the blog outside of the address bar. Since I use [Pentadactyl](http://dactyl.sourceforge.net/pentadactyl/) my address bar is at the bottom and it is not so obvious. 

$$code(lang=mako)
<%
    import mako.runtime
    if category is mako.runtime.UNDEFINED:
        cat = False
    else:
        cat = category
%>\
% if cat:
<div class="content">
<div class="textcenter">
<div class="category_title">
Showing posts in category <b>${cat}</b>. <a href="${bf.config.blog.path}">Show all posts</a>
</div>
</div>
</div>
% endif
$$/code

