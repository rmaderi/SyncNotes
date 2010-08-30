	<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">



<% response.setContentType("application/vnd.wap.xhtml+xml"); %>



<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>

<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>

<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="java.io.File"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>File Upload Example</title>
  </head>

  <body>
    <h1>Data Received at the Server</h1>
    <hr/>
    <p>

<%
System.out.println("Reaching jsp");
if (ServletFileUpload.isMultipartContent(request)){
  ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
  List fileItemsList = servletFileUpload.parseRequest(request);

  String optionalFileName = "";
  FileItem fileItem = null;

  Iterator it = fileItemsList.iterator();
  while (it.hasNext()){
    FileItem fileItemTemp = (FileItem)it.next();
    if (fileItemTemp.isFormField()){
%>

		<b>Name-value Pair Info:</b><br/>
		Field name: <%= fileItemTemp.getFieldName() %><br/>
		Field value: <%= fileItemTemp.getString() %><br/><br/>

<%
      	if (fileItemTemp.getFieldName().equals("datafile"))
        optionalFileName = fileItemTemp.getString();
		fileItem = fileItemTemp;
	    }
    	else
      	fileItem = fileItemTemp;
  	}

  	if (fileItem!=null){
    String fileName = fileItem.getName();
%>

	<b>Uploaded File Info:</b><br/>
	Content type: <%= fileItem.getContentType() %><br/>
	Field name: <%= fileItem.getFieldName() %><br/>
	File name: <%= fileName %><br/>
	File size: <%= fileItem.getSize() %><br/><br/>

<%
    /* Save the uploaded file if its size is greater than 0. */
    if (fileItem.getSize() > 0){
      if (optionalFileName.trim().equals(""))
        fileName = FilenameUtils.getName(fileName);
      else
        fileName = optionalFileName;

      String dirName = "/tmp/sync/Notes/PCNotes/";

      File saveTo = new File(dirName + fileName);
       
      
      try {
      	System.out.println("Reaching jsp");
        fileItem.write(saveTo);
%>
<%= dirName %>
<%= fileName %>

<b>The uploaded file has been saved successfully.</b>
	
<jsp:forward page="Success.jsp"></jsp:forward>


<%
      }
      catch (Exception e){
%>

<b>An error occurred when we tried to save the uploaded file.</b>
<jsp:forward page="Error.jsp"></jsp:forward>
<%
e.printStackTrace();
      }
    }
  }
}
%>

    </p>
    
    This can be seen !!
  </body>
</html>