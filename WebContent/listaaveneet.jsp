<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Venelistaus</title>
</head>
<body onkeydown="tutkiKey(event)">
<h1>Venelistaus</h1>
<table id="listaus">
	<thead>
		<tr>
			<th colspan="5" id="ilmo"></th>
			<th><a id= "uusiVene" href="lisaavene.jsp">Lisää uusi vene</a></th>
		</tr>
		<tr>
			<th class="oikealle">Hakusana:</th>
			<th colspan="4"><input type="text" id="hakusana"></th>
			<th><input type="button" value="Hae" id="hakunappi" onclick="haeTiedot()"></th>
		</tr>			
		<tr>
			<th>Nimi</th>
			<th>Merkki/Malli</th>
			<th>Pituus</th>
			<th>Leveys</th>
			<th>Hinta</th>
			<th>&nbsp;</th>						
		</tr>
	</thead>
	<tbody  id="tbody">
	</tbody>
</table>
<script>
$(document).ready(function(){
	
	$("#uusiVene").click(function(){
		document.location="lisaavene.jsp";
	});
	
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ //Enteriä painettu, ajetaan haku
			  haeTiedot();
		  }
	});	
	$("#hae").click(function(){	
		haeTiedot();
	});
	$("#hakusana").focus();//viedään kursori hakusana-kenttään sivun latauksen yhteydessä
	haeTiedot();
});
function haeTiedot(){	
	$("#listaus tbody").empty();
	$.getJSON({url:"veneet/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){	
		$.each(result.veneet, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr id='rivi_"+field.tunnus+"'>";
        	htmlStr+="<td>"+field.nimi+"</td>";
        	htmlStr+="<td>"+field.merkkimalli+"</td>";
        	htmlStr+="<td>"+field.pituus+"</td>";
        	htmlStr+="<td>"+field.leveys+"</td>";
        	htmlStr+="<td>"+field.hinta+"</td>";
        	htmlStr+="<td><a href='muutavene.jsp?tunnus="+field.tunnus+"'>Muuta</a>&nbsp;";
        	htmlStr+="<span class='poista' onclick=poista("+field.tunnus+",'"+field.nimi+"')>Poista</span></td>"; 
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });
    }});	
}
function poista(tunnus, nimi){
	if(confirm("Poista vene nimeltä " + nimi +"?")){	
		$.ajax({url:"veneet/"+tunnus, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmo").html("Veneen poisto epäonnistui.");
	        }else if(result.response==1){
	        	alert("Veneen " + nimi +" poisto onnistui.");
				haeTiedot();        	
			}
	    }});
	}
}
</script>
</body>
</html>