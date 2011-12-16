<%!
    ishome = True
    currentpage = "index"
%>
<%inherit file="_templates/site.mako" />

 <div id="content">
${self.rawmarkdown('_pages/index.markdown')}
 </div>
	<div id="subcontent">
		<div class="small box">
			<img src="robin.jpg" width="150" height="290" alt="Robin Juggling" />
		</div>
	</div>
    <div id="contentfull">
    <h2>Blog</h2>
Here's the main <a href="${bf.util.site_path_helper(bf.config.blog.path)}">chronological blog page</a><br/><br/>

Here's the last 5 posts:
<ul>
% for post in bf.config.blog.posts[:5]:
    <li><a href="${post.path}">${post.title}</a></li>
% endfor
</ul>
	  <p>
	  <a href="http://validator.w3.org/check?uri=referer"><img src="http://www.w3.org/Icons/valid-xhtml10-blue" alt="Valid XHTML 1.0 Strict" height="31" width="88" class="center"/></a>
	  </p>
    </div>


<%def name="homepage()">
  <% return True %>
</%def>
<%def name="currentpage()">
  <% return "index" %>
</%def>

