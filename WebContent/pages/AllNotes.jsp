<%@ page language="java" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Sync Note</title>
<link href="/SyncNotes/default.css" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript">

function putNotes() {  
	window.location.href = "/SyncNotes/pages/upload.html";
}

function AJAXInteraction(url, callback) {
    var req = init();
    req.onreadystatechange = processRequest;
        
    function init() {
      // For firefox, Safari
      if (window.XMLHttpRequest) {
        return new XMLHttpRequest();
       	//For IE 6
      } else if (window.ActiveXObject) {
        return new ActiveXObject("Microsoft.XMLHTTP");
      }
    }
    
    function processRequest () {
      // readyState of 4 signifies request is complete
      if (req.readyState == 4) {
	  // status of 200 signifies sucessful HTTP call
        if (req.status == 200) {
          if (callback) callback(req.responseXML);
        }
      }
    }

    this.doGet = function() {
      // make a HTTP GET request to the URL asynchronously
      req.open("GET", url, true);
      req.send(null);
    };
}

function getAllNotes() {  
    var url = "/SyncNotes/getAllNotes"; 
    var ajax = new AJAXInteraction(url, getAllNotescallback); 
    ajax.doGet(); 
}

function getAllNotescallback(responseXML) {
	
     var root = responseXML.getElementsByTagName('Notes').item(0);
     
     for (var iNode = 0; iNode < root.childNodes.length; iNode++) {
         var node = root.childNodes.item(iNode);
        
         if ( node.childNodes.length > 0) {
        	 for (i = 0; i < node.childNodes.length; i++) {
              	var sibl = node.childNodes.item(i);
              	var len = parseInt(sibl.childNodes.length / 2);
              	var arr1 = new Array(len);
              	var arr2 = new Array(len);
              	var cnt1 = 0;
              	var cnt2 = 0;
              
              	var sibl1 = sibl.childNodes.item(0);
              	var sibl2;
              	if (sibl1.childNodes.length > 0) {
             	 	sibl2 = sibl1.childNodes.item(0);
             	 	arr1[cnt1] = sibl2.data;
             		cnt1++;
              	}

              	var sibl3 = sibl.childNodes.item(1);
              	var sibl4;
              	if (sibl3.childNodes.length > 0) {
             	 	sibl4 = sibl3.childNodes.item(0);
             	 	arr2[cnt2] = sibl4.data;
             	 	cnt2++;
              	}
             
              makeNameTable("fileNameTable", arr1);
              makeTable("contentTable", arr2);
          	}
          }
         
       }
     
} 

/* Creates a table to display file Names */
function makeNameTable(tablename, arr) {

	row=new Array();
	cell=new Array();

	row_num=arr.length; //edit this value to suit
	cell_num=1; //edit this value to suit

	tab=document.createElement('table');
	tab.setAttribute('id','fileNametable');

	tbo=document.createElement('tbody');

	for(c=0;c<row_num;c++){
	row[c]=document.createElement('tr');

	cell[cell_num]=document.createElement('td');
	cont=document.createTextNode(arr[c]);
	cell[cell_num].appendChild(cont);
	row[c].appendChild(cell[cell_num]);
	
	tbo.appendChild(row[c]);

	r = document.createElement('tr');
	c = document.createElement('td');
	r.appendChild(c);
	tbo.appendChild(r);
	
	r = document.createElement('tr');
	c = document.createElement('td');
	r.appendChild(c);
	tbo.appendChild(r);
	
	}
	tab.appendChild(tbo);
	document.getElementById(tablename).appendChild(tab);
}

/* Creates a table to display contents */
function makeTable(tablename, arr) {

	row=new Array();
	cell=new Array();

	row_num=arr.length; //edit this value to suit
	cell_num=1; //edit this value to suit

	tab=document.createElement('table');
	tab.setAttribute('id','newtable');

	tbo=document.createElement('tbody');

	for(c=0;c<row_num;c++)
	{
		row[c]=document.createElement('tr');

		cell[cell_num]=document.createElement('td');
		cont=document.createTextNode(arr[c]);
		cell[cell_num].appendChild(cont);
		row[c].appendChild(cell[cell_num]);
	
		tbo.appendChild(row[c]);
	
		r = document.createElement('tr');
		col = document.createElement('td');

		
		if (arr[c].length <= 140) {
			link = document.createElement('a');
			url1 = "http://twitter.com/home?status=" + arr[c];
			link.setAttribute('href', url1);
			image = document.createElement('img');
			image.setAttribute('src', '/SyncNotes/images/tweet_this.png');
			link.appendChild(image);
			link.setAttribute('target', '_blank');
			col.appendChild(link);
			r.appendChild(col);
			tbo.appendChild(r);
		}
		
		r = document.createElement('tr');
		col = document.createElement('td');
		image = document.createElement('hr');
		col.appendChild(image);
		r.appendChild(col);
		tbo.appendChild(r);

		r = document.createElement('tr');
		col = document.createElement('td');
		r.appendChild(col);
		tbo.appendChild(r);

		r = document.createElement('tr');
		col = document.createElement('td');
		r.appendChild(col);
		tbo.appendChild(r);
	
	}
	tab.appendChild(tbo);
	document.getElementById(tablename).appendChild(tab);
}

/* Call getAllNotes function on page load */
function addEvent(obj, evType, fn)
{ 
	 if (obj.addEventListener){ 
	   obj.addEventListener(evType, fn, false); 
	   return true; 
	 } else if (obj.attachEvent){ 
	   var r = obj.attachEvent("on"+evType, fn); 
	   return r; 
	 } else { 
	   return false; 
	 } 
	}

addEvent(window, 'load', getAllNotes);
	
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
						<li><h2><a href="#" onclick="javascript:getAllNotes()">All Notes</a></h2>
							
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
					<div class="post">
						<h1 class="title"><a href="#">Welcome to Sync Note!</a></h1>
						<p class="byline"><em></em></p>
						<div id="txtCDInfo"></div>
						<div class="entry">
							<p>	
							<table border="0" id="contentTable">
							</table>
							</p>		
												
							
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

