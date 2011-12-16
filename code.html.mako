<%inherit file="_templates/site.mako" />

<div id="contentfull">
${self.rawmarkdown('_pages/code.markdown')}
</div>

<%def name="homepage()">
  <% return True %>
</%def>
<%def name="currentpage()">
  <% return "code" %>
</%def>
