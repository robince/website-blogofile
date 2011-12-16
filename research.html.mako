<%inherit file="_templates/site.mako" />
${self.rawmarkdown('_pages/research.markdown')}
<%!
    ishome = True
    currentpage = 'site'
%>
