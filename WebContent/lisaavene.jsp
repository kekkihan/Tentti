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
<title>Uuden veneen lis��minen</title>
</head>
<body>
<h1>Uuden veneen lis��minen</h1>
<form id="tiedot">
	<table>
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
			<th></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><input type="text" name="nimi" id="nimi"></td>
			<td><input type="text" name="merkkimalli" id="merkkimalli"></td>
			<td><input type="text" name="pituus" id="pituus"></td>
			<td><input type="text" name="leveys" id="leveys"></td>
			<td><input type="text" name="hinta" id="hinta"></td>
			<td><input type="submit" id="tallenna" value="Lis��"></td>
		</tr>
	</tbody>
</table>
</form>
<span id="ilmo"></span>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaveneet.jsp";
	});

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
				},	
				leveys:  {
					required: true,				
				},
				hinta:  {
					required: true,
					minlength: 3
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
				},
				leveys: {
					required: "Puuttuu",
				},
				hinta: {
					required: "Puuttuu",
					minlength: "Liian pieni hinta"
				}
			},			
		submitHandler: function(form) {	
			vieTiedot();
		}
	});  

	$("#nimi").focus(); 
});
function vieTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	console.log(formJsonStr);
	$.ajax({url:"veneet", data:formJsonStr, type:"POST", dataType:"json", success:function(result) {       
		if(result.response==0){
        	$("#ilmo").html("Veneen lis��minen ep�onnistui.");
        }else if(result.response==1){			
        	$("#ilmo").html("Veneen lis��minen onnistui.");
        	$("#nimi, #merkkimalli, #pituus, #leveys, #hinta").val("");
		}
    }});	
}
</script>
</body>
</html>