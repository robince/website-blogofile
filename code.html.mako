<%inherit file="_templates/site.mako" />
<div id="contentfull">
${self.rawmarkdown('_pages/code.markdown')}
</div>
<%!
    ishome = True
    currentpage = 'code'
%>
