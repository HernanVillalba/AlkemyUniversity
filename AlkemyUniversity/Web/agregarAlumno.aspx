<%@ Page Title="Agregar alumno" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="agregarAlumno.aspx.cs" Inherits="Web.agregarAlumno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function validarNuevoAlumno() {
            var apellidos = document.getElementById("<% = txtApellido.ClientID  %>").value;
            var nombres = document.getElementById("<% = txtNombres.ClientID %>").value;
            var dni = document.getElementById("<% = txtDNI.ClientID %>").value;
            if (apellidos === "" || nombres === "" || dni === "") {
                alert("Debe completar todos lo campos.");
                return false;
            }
            return true;
        }
    </script>

    <%if (Session["ErrorMessageAgregarAlumno"] != null)
        {
            if ((bool)Session["ErrorMessageAgregarAlumno"] == true)
            {%>
    <div class="alert alert-danger" role="alert">
        No se pudieron guardar los datos.
    </div>
    <% }
        else
        {  %>
    <div class="alert alert-success" role="alert">
        Datos guardados correctamente.
    </div>
    <% }
            Session["ErrorMessageAgregarAlumno"] = null;
        } %>
    <div>
        <div class="centrado">
            <h1>Nuevo alumno</h1>
        </div>
        <div class="centrado">
            <div>
                <div class="form-group">
                    <label>Apellidos: </label>
                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Nombres: </label>
                    <asp:TextBox ID="txtNombres" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>DNI:</label>
                    <asp:TextBox ID="txtDNI" runat="server" type="number" CssClass="form-control" />
                </div>
            </div>
        </div>
    </div>
    <div class="form-group centrado">
        <a href="administrarUsuarios.aspx" class="btn btn-primary">Volver</a>
        <asp:Button ID="btnAgregar" Text="Agregar" runat="server" CssClass="btn btn-primary" OnClientClick="return validarNuevoAlumno();" OnClick="btnAgregar_Click" />
    </div>
</asp:Content>
