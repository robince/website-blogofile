<%inherit file="site.mako" />
<%include file="blogsidebar.mako" />
<%
    import mako.runtime
    if category is mako.runtime.UNDEFINED:
        cat = False
    else:
        cat = category
%>\
% if cat:
<div id="content">
<div class="textcenter">
<div class="category_title">
Showing posts in category <b>${cat}</b>. <a href=${bf.config.blog.path}>Show all posts</a>
</div>
</div>
</div>
% endif
% for post in posts:
  <%include file="post.mako" args="post=post, sep=True" />
% if bf.config.blog.disqus.enabled:
  <div class="after_post"><a href="${post.permalink}#disqus_thread">Read and Post Comments</a></div>
% endif
% endfor
<div class="clear"></div>
<div id="content">
% if prev_link:
 <a href="${prev_link}">« Previous Page</a>
% endif
% if prev_link and next_link:
  --  
% endif
% if next_link:
 <a href="${next_link}">Next Page »</a>
% endif
% if prev_link or next_link:
    <br>
    <br>
% endif
</div>
