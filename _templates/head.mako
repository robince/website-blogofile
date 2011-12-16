<%page args="ishome"/>\
<meta name="author" content="Robin Ince" />
    <link rel="stylesheet" type="text/css" href="${bf.util.site_path_helper('/andreas08.css')}" title="default" media="screen,projection" />
    <link href='http://fonts.googleapis.com/css?family=Droid+Sans+Mono' rel='stylesheet' type='text/css'/>
% if ishome:
    <title>Home Page of Robin Ince</title>
    <meta name="description" content="Robin Ince - Home Page" />
    <meta name="keywords" content="robin,ince,home,page" /> \
% else:
    <title>Blog of Robin Ince</title>
    <link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="${bf.util.site_path_helper(bf.config.blog.path,'/feed')}" />
    <link rel="alternate" type="application/atom+xml" title="Atom 1.0"
    href="${bf.util.site_path_helper(bf.config.blog.path,'/feed/atom')}" />
    <link rel='stylesheet' href='${bf.config.filters.syntax_highlight.css_dir}/pygments_${bf.config.filters.syntax_highlight.style}.css' type='text/css' />
    <meta name="description" content="Robin Ince - Blog" />
    <meta name="keywords" content="robin,ince,blog" /> \
 <script type="text/javascript">
   var disqus_developer = 1; // this would set it to developer mode
 </script> 
%endif 
