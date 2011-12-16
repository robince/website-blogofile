<%inherit file="_templates/site.mako" />
${self.rawmarkdown('_pages/links.markdown')}
<%!
    ishome = True
    currentpage = 'links'
%>
