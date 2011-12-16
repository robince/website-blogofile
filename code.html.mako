<%inherit file="_templates/site.mako" />
<div id="contentfull">
${self.rawmarkdown('_pages/code.markdown')}

<div>
<div style="display:inline-block; width:50%; text-align:center"> 
<a href="http://github.com/robince" target="_blank" ><img src="/img/githublogov3.png" alt="GitHub" title="Fork me on GitHub" /> 
</div>\
<div style="display:inline-block; width:40%; text-align:center"> 
<a href="http://stackoverflow.com/users/136194/robince" target="_blank" ><img src="/img/so-logo.png" alt="Stack Overflow" title="Answer me on Stack Overflow" /></a>
</div>
</div>
<br>
<br>
</div>
<%!
    ishome = True
    currentpage = 'code'
%>
