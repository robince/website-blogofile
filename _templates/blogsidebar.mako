  <div id="subcontent">
  <div class="blog_menu">
    <ul>
    <li><b>Categories</b></li>
  % for category, num_posts in bf.config.blog.all_categories:
      <li><a href="${category.path}" title="${category}">${category}</a> (<a href="${category.path}/feed">rss</a>) (${num_posts})</li>
  % endfor
    </ul>
    <ul>
    <br />
    <li><b>Archives</b></li>
  % for link, name, num_posts in bf.config.blog.archive_links:
      <li><a href="${bf.util.site_path_helper(bf.config.blog.path,link)}/1" title="${name}">${name}</a>&nbsp;(${num_posts})</li>
  % endfor
    </ul>
    
  </div>
  </div> 

