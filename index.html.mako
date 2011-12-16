<%!
    ishome = True
    currentpage = "index"
%>\
<%inherit file="_templates/site.mako" />
<div id="contentfull">
${self.rawmarkdown('_pages/index.markdown')}\

    <h2>Latest Blog Posts</h2>
<ul>
% for post in bf.config.blog.posts[:5]:
    <li><a href="${post.path}">${post.title}</a></li>
% endfor
</ul>
	  <p>
	  <a href="http://validator.w3.org/check?uri=referer"><img src="http://www.w3.org/Icons/valid-xhtml10-blue" alt="Valid XHTML 1.0 Strict" height="31" width="88" class="center"/></a>
	  </p>
    </div>
