<%@ Page Title="Agregar administrador" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="agregarAdministrador.aspx.cs" Inherits="Web.agregarAdministrador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function validarNuevoAdmin() {
            var apellido = document.getElementById("<% = txtApellido.ClientID %>").value;
            var nombres = document.getElementById("<% = txtNombres.ClientID %>").value;
            var dni = document.getElementById("<% = txtDNI.ClientID %>").value;
            var contra = document.getElementById("<% = txtContraseña.ClientID %>").value;
            var contra2 = document.getElementById("<% = txtContraseña2.ClientID %>").value;
            if (apellido === "" || nombres === "" || dni === "" || contra === "" || contra2 === "") {
                alert("Debe completar todos los campos.");
                return false;
            }
            if (contra != contra2) {
                alert("Las contraseñas no coinciden");
                return false;
            }
            return true;
        }
    </script>


    <%if (Session["ErrorMessageAgregarAdmin"] != null)
        {
            if ((bool)Session["ErrorMessageAgregarAdmin"] == true)
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
            Session["ErrorMessageAgregarAdmin"] = null;
        } %>
    <div>
        <div class="centrado">
            <h1>Nuevo administrador</h1>
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
                <div class="form-group">
                    <label>Contraseña: </label>
                    <asp:TextBox ID="txtContraseña" runat="server" type="password" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Confirme contraseña: </label>
                    <asp:TextBox ID="txtContraseña2" runat="server" type="password" CssClass="form-control" />
                </div>
            </div>
        </div>
    </div>
    <div class="form-group centrado">
        <a href="administrarUsuarios.aspx" class="btn btn-primary">Volver</a>
        <asp:Button ID="btnAgregar" Text="Agregar" runat="server" CssClass="btn btn-primary" OnClientClick="return validarNuevoAdmin();" OnClick="btnAgregar_Click" />
    </div>
</asp:Content>
