<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="editarProfesor.aspx.cs" Inherits="Web.editarProfesor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="centrado">
        <%if (Session["ErrorMessage"] != null)
            {
                if ((bool)Session["ErrorMessage"])
                {%>
        <div class="alert alert-danger">
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
        <div>
            <div class="form-inline">
                <label>Apellido: </label>
                <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-inline">
                <label>Nombre: </label>
                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-inline">
                <label>DNI: </label>
                <asp:TextBox runat="server" ID="txtDNI" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-inline">
                <label>Activo: </label>
                <asp:CheckBox runat="server" CssClass="custom-checkbox" ID="cbActivo" />
            </div>
            <a href="administrarProfesores.aspx" class="btn btn-primary">Cancelar</a>
            <asp:Button ID="btnGuardar" Text="Guardar" runat="server" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
        </div>
    </div>
</asp:Content>
