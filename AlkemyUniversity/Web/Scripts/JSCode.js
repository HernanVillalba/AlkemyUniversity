function validar() {
    var legajo = document.getElementById("txtLegajo").value;
    var dni = cocument.getElementById("<%= txtDNI.ClientID %>").value;
    if (legajo === "" || dni === "") {
        alert("Debes completar los campos");
        return false;
    }
    return true;
}