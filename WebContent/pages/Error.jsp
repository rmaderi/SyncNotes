<%@ page language="java" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Sync Note</title>
<meta name="keywords" content="" />
<meta name="Adhesive" content="" />
<link href="/SyncNotes/default.css" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript">

function putNotes() {  
	alert("Inside putNotes");
	window.location.href = "upload.html";
}

function getNotes() {  
	window.location.href = "AllNotes.jsp";
}

function getFBNotes() {  
	window.location.href = "FacebookNotes.jsp";
}

function getPCNotes() {  
	window.location.href = "PCNotes.jsp";
}

function getPhoneNotes() {  
	window.location.href = "PhoneNotes.jsp";
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
			
				<li><a href="#" onclick="javascript:putNotes()">New Note</a></li>
				<li class="current_page_item"><a href="/SyncNotes/Home.jsp">Homepage</a></li>
				<li><a href="#">About Us</a></li>
				
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
							<h2><a href="#" onclick="javascript:getNotes()">All Notes</a></h2>
						</li>
						<li>
							<h2><a href="#" onclick="javascript:getFBNotes()">Facebook Notes</a></h2>
						</li>
						<li>
							<h2><a href="#" onclick="javascript:getPCNotes()">PC Notes</a></h2>
						</li>
						<li>
							<h2><a href="#" onclick="javascript:getPhoneNotes()">Phone Notes</a></h2>
						</li>
					</ul>
					
				</div>
				<!-- start content -->
				<div id="content">
					<div class="post">
						<h1 class="title"><a href="#">Welcome to Sync Note!</a></h1>
						<p class="byline"><em></em></p>
					
						<div class="entry">
							<p>		
						
							<strong>Error while uploading the file. Try again! </strong>
							
							</p>
							<br/>
							
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
		<p class="copyright">&copy;&nbsp;&nbsp;2010 All Rights Reserved &nbsp;&bull;&nbsp; Design by <a href="http://www.freecsstemplates.org/">syncnotes.com</a>.</p>
	</div>
</div>
</form>
</body>
</html>

