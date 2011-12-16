<%inherit file="_templates/site.mako" />

${self.rawmarkdown('_pages/research.markdown')}

<%def name="homepage()">
  <% return True %>
</%def>
<%def name="currentpage()">
  <% return "research" %>
</%def>
