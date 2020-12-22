<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Veneen tietojen muutos</title>
</head>
<body>
<h1>Veneen tietojen muutos</h1>
<form id="tiedot">
	<table class="table">
		<thead>
			<tr>
				<th colspan="4" id="ilmo"></th>
				<th colspan="2" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>
			<tr>
				<th>Nimi</th>
				<th>Merkki/Malli</th>
				<th>Pituus</th>
				<th>Leveys</th>
				<th>Hinta</th>			
				<th>Hallinta</th>
			</tr>
		</thead>
			<tr>
				<td><input type="text" name="nimi" id="nimi"></td>
				<td><input type="text" name="merkkimalli" id="merkkimalli"></td>
				<td><input type="text" name="pituus" id="pituus"></td>
				<td><input type="text" name="leveys" id="leveys"></td>
				<td><input type="text" name="hinta" id="hinta"></td>			
				<td><input type="submit" value="Tallenna" id="tallenna"></td>
			</tr>
		<tbody>
		</tbody>
	</table>
	<input type="hidden" name="tunnus" id="tunnus">
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	
	$("#takaisin").click(function(){
		document.location="listaaveneet.jsp";
	});
	
	$("#nimi").focus();
	
	var tunnus = requestURLParam("tunnus");	
	$.ajax({url:"veneet/haeyksi/"+tunnus, type:"GET", dataType:"json", success:function(result){	
		$("#nimi").val(result.nimi);	
		$("#merkkimalli").val(result.merkkimalli);
		$("#pituus").val(result.pituus);
		$("#leveys").val(result.leveys);
		$("#hinta").val(result.hinta);		
		$("#tunnus").val(result.tunnus);		
    }});
	
	$("#tiedot").validate({						
		rules: {
			nimi:  {
				required: true,				
				minlength: 2				
			},	
			merkkimalli:  {
				required: true,				
				minlength: 2				
			},
			pituus:  {
				required: true,
				number: true,
			},	
			leveys:  {
				required: true,			
				number: true,
			},
			hinta:  {
				required: true,
				number: true,
			}
		},	
		messages: {
			nimi: {     
				required: "Nimi puuttuu",				
				minlength: "Liian lyhyt"			
			},
			merkkimalli: {
				required: "Merkki/ Malli puuttuu",				
				minlength: "Liian lyhyt"
			},
			pituus: {
				required: "Puuttuu",
				number: "Ei kelpaa",
			},
			lyhyys: {
				required: "Puuttuu",
				number: "Ei kelpaa",
			},
			hinta: {
				required: "Puuttuu",
				number: "Ei kelpaa",
			},
		},			
		submitHandler: function(form) {	
			vieTiedot();
		}		  
	});

function vieTiedot(){ 
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"veneet", data:formJsonStr, type:"PUT", success:function(result) { //result on joko {"response:1"} tai {"response:0"}		
      if(result.response==0){
      	$("#ilmo").html("Veneen tietojen p�ivitt�minen ep�onnistui.");
      }else if(result.response==1){
      	$("#ilmo").html("Veneen tietojen p�ivitt�minen onnistui.");
		}
  }});
}});
</script>
</html>