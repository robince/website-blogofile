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
        ${next.body()}\
      <div id="footer">
        ${self.footer()}
      </div> <!-- End Footer -->
    </div> <!-- End container -->
  </body>
</html>

<%!
    # default to being a blog page
    ishome = False
    currentpage = 'blog'
%>

<%def name="head()">\
  <%include file="head.mako" args="ishome=self.attr.ishome" />\
</%def>

<%def name="header()">\
  <%include file="header.mako" args="ishome=self.attr.ishome"/>\
</%def>

<%def name="footer()">\
  <%include file="footer.mako" args="ishome=self.attr.ishome,modified_text=self.attr.modified_text" />\
</%def>

<%def name="navbar()">\
  <%include file="nav.mako" args="currentpage=self.attr.currentpage" />\
</%def>
