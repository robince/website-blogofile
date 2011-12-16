<%inherit file="_templates/site.mako" />
<div id="content">
${self.rawmarkdown('_pages/about.markdown')}
</div>

	<div id="subcontent">
		<div class="small box">
			<img src="img/robin.jpg" width="150" height="290" alt="Robin Juggling" />
		</div>
	</div>
<%!
    ishome = True
    currentpage = 'about'
%>
