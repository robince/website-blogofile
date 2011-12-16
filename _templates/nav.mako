<%page args="currentpage"/>
      <div id="navigation">
        <ul>
          ${navitem('index','About me')}
          ${navitem('research', 'Research')}
          ${navitem('code', 'Code')}
          ${navitem('links', 'Links')}
          ${navitem('blog', 'Blog')}
        </ul>
      </div>

<%def name="navitem(pageid, text)">\
<% 
   if pageid == currentpage:
       select = 'class="selected"'
   else:
       select = ''
   if pageid == 'blog':
       link = bf.config.blog.path
   else:
       link = bf.util.site_path_helper(pageid+'.html')
%>\
<li ${select}><a href="${link}">${text}</a></li>\
</%def>
