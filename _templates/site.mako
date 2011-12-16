<%inherit file="base.mako" />\
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>\
    ${self.head()}
  </head>

  <body>
    <div style="position:absolute; top:0; height:100%; padding:0 0 1px">&nbsp;</div>

    <div id="container" >
      <div id="header" >\
        ${self.header()}\
      </div>\
        ${self.navbar()}\
        ${next.body()}
      <div id="footer">
        ${self.footer()}
      </div> <!-- End Footer -->
    </div> <!-- End container -->
  </body>
</html>

<%def name="head()">\
  <% ishome = self.homepage() %>\
  <%include file="head.mako" args="ishome=ishome" />\
</%def>

<%def name="header()">\
  <% ishome = self.homepage() %>\
  <%include file="header.mako" args="ishome=ishome"/>\
</%def>

<%def name="footer()">\
  <% ishome = self.homepage() %>\
  <%include file="footer.mako" args="ishome=ishome" />\
</%def>

<%def name="navbar()">\
  <% current = self.currentpage() %>\
  <%include file="nav.mako" args="currentpage=current" />\
</%def>

<%def name="homepage()">\
  <% return False %>\
</%def>

<%def name="currentpage()">\
  <% return "blog" %>\
</%def>
