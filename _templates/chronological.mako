<%inherit file="site.mako" />
<%include file="blogsidebar.mako" />
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
