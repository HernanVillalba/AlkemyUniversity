<%@ Page Title="Editar profesor" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="editarProfesor.aspx.cs" Inherits="Web.editarProfesor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function validarEditarProfesor() {
            var apellido = document.getElementById("<% = txtApellido.ClientID %>").value;
            var nombre = document.getElementById("<% = txtNombre.ClientID %>").value;
            var dni = document.getElementById("<% = txtDNI.ClientID %>").value;
            if (apellido === "" || nombre === "" || dni === "") {
                alert("Debe completar todos los campos.");
                return false;
            }
            if (isNaN(dni)) {
                alert("El DNI debe ser solo de carácteres numéricos.");
                return false;
            }
            return true;
        }
    </script>

    <div class="centrado">
        <h1>Editar profesor</h1>
    </div>

    <%if (Session["ErrorMessage"] != null)
        {
            if ((bool)Session["ErrorMessage"])
            {%>
    <div class="alert alert-danger centrado">
        <h4 class="alert alert-heading">No se pudo actualizar los datos.</h4>
    </div>
    <% }
        else
        {%>
    <div class="alert alert-success">
        <h4 class="alert alert-heading">Datos guardados correctamente.</h4>
    </div>
    <% }
            Session["ErrorMessage"] = null;
        } %>
    <div class="centrado">
        <div>
            <div class="">
                <div class="form-group">
                    <label>Apellido: </label>
                    <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Nombre: </label>
                    <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>DNI: </label>
                    <asp:TextBox runat="server" ID="txtDNI" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-inline">
                    <asp:CheckBox runat="server" CssClass="form-check-input" ID="cbActivo" type="checkbox" />
                    <label class="form-check-label" for="cbActivo">Activo</label>
                </div>
                <hr />
                <div class="centrado">
                    <a href="administrarProfesores.aspx" class="btn btn-primary">Cancelar</a>
                    <asp:Button ID="btnGuardar" Text="Guardar" runat="server" CssClass="btn btn-primary" OnClientClick="return validarEditarProfesor();" OnClick="btnGuardar_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
