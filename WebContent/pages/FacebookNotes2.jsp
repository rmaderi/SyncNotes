<jsp:useBean id="notes" class="facebook.GetFBNotes" scope="session"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.util.*" errorPage=""%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Sync Note</title>
<link href="/SyncNotes/default.css" rel="stylesheet" type="text/css" media="screen" />
<% %>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js"></script>
<script>

function myNotes() {  
	window.location.href = "/SyncNotes/pages/FacebookNotes1.jsp";
}

function friendNotes() {  
	window.location.href = "/SyncNotes/pages/FacebookNotes2.jsp";
}
	
</script>
 
</head>
<body>
<form>
<div id="wrapper">
	<!-- start header -->
	<div id="header">
		<div id="logo">
			<h1><a href="#"><span>SYNCNOTES</span></a></h1>
			<p><br/>note everything.. access anywhere</p>
		</div>
		<div id="menu">
			<ul id="main">
				<li class="current_page_item"><a href="/SyncNotes/Home.jsp">Homepage</a></li>
				<li><a href="#">Contact Us</a></li>
			</ul>
		</div>
	</div>
	<!-- end header -->
	<!-- start page -->
		
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
			
				<div id="sidebar1" class="sidebar">
					<ul>
						<li> 
						<h2><a href="#">Facebook Notes</a></h2>
						<h2><a href="#" onclick="javascript:myNotes()">My Notes</a></h2>
						<%			
									notes.setAccessToken("2227470867|2.saZtpITXk8_vKH_NvKU_hg__.3600.1282791600-1207308088|PQ0pS5DxFyYKrlcQ-RNjNGM17y0.");
									int key = 0;
									HashMap <String, String> note;
									HashMap<Integer, HashMap<String, String>> friendNotes 
																= notes.getFriendsNotes();
						
								 	Iterator iterator = friendNotes.keySet().iterator();
									while(iterator. hasNext() ){
										key= (Integer)iterator.next();
										note = friendNotes.get(key);%><h3>  
										<%out.println(note.get("Subject"));%> </h3>
										
									<% }%>
							
							<h2><a href="#" onclick="javascript:friendNotes()">Friends Notes</a></h2>
							<ul>
							
							<li>
							<table border="0" id="fileNameTable">
							
							</table>
							</li>
								
							</ul>
						</li>
						
					</ul>
					
				</div>
				<!-- start content -->
				<div id="content">
								
								
									<%  	iterator = friendNotes.keySet().iterator();
											while(iterator. hasNext() ){
												key= (Integer)iterator.next();
												note = friendNotes.get(key);%>
						<div class="post">
						
						<h1 class="title"><a href="#"><%out.println(note.get("Subject")); %></a></h1>
											<p class="byline"><em></em></p>								
											<div id="txtCDInfo"></div>
												<table border="0" id="contentTable">
												<%out.println(note.get("Message"));%>
												<a href="http://twitter.com/share" class="twitter-share-button" data-count="none" data-via=txtCDInfo>Tweet</a>
												<script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
												</p></a><% }%>
												</table>
											
						</div>
					</div>
				</div>
				<!-- end content -->
				<!-- start sidebars -->
				<div id="sidebar2" class="sidebar">
					<ul>
						<li>
							<h2>Announcements</h2>
							<ul>
								<li><a href="#">Welcome to new SyncNote!</a></li>
                                <li><a href="#">Now available for iPhone</a></li>
								<li><a href="#">Follow us on Twitter</a></li>
								<li><a href="#">Check out our new videos </a></li>
								<li><a href="#">SyncNote in the news</a></li>
                                <li><a href="#">Bigger upload capacity with premium</a></li>
                                <li><a href="#">1st August 2010 press release</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<!-- end sidebars -->
				<div style="clear: both;">&nbsp;</div>
			</div>
			<!-- end page -->
		</div>
	</div>
</div>
<div id="footer-wrapper">
	<div id="footer">
		<p class="copyright">&copy;&nbsp;&nbsp;2010 All Rights Reserved &nbsp;&bull;&nbsp; Design by syncnotes.com.</p>
	</div>
</div>
</form>
</body>
</html>

