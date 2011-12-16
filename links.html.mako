<%inherit file="_templates/site.mako" />

${self.rawmarkdown('_pages/links.markdown')}

<%def name="homepage()">
  <% return True %>
</%def>
<%def name="currentpage()">
  <% return "links" %>
</%def>
