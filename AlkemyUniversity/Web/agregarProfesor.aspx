<%@ Page Title="Agregar profesor" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="agregarProfesor.aspx.cs" Inherits="Web.agregarProfesor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="centrado">
        <div class="centrado" style="width: 500px; border-radius: 10px; background-color: rgb(242,242,242); padding: 40px; opacity: 0.9;">
            <div>
                <%if (Session["MessageErrorNewTeacher"] != null)
                    {
                        if ((bool)Session["MessageErrorNewTeacher"])
                        {%>
                <div class="alert alert-warning" role="alert">
                    El profesor que intenta agregar ya existe.
                </div>

                <% }
                    else
                    {%>
                <div class="alert alert-success" role="alert">
                    Profesor agregado correctamente.
                </div>
                <% }
                        Session["MessageErrorNewTeacher"] = null;
                    } %>

                <div class="card">
                    <div class="card-header centrado">
                        <h3>Datos del profesor</h3>
                    </div>
                    <div class="form-group">
                        <label>Apellido: </label>
                        <asp:TextBox ID="tbApellido" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>Nombres: </label>
                        <asp:TextBox ID="tbNombres" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>DNI</label>
                        <asp:TextBox ID="tbDNI" runat="server" />
                    </div>
                    <div class="form-group">
                        <label>Activo</label>
                        <asp:CheckBox ID="cbActivo" runat="server" />
                    </div>
                </div>
                <div class="form-group centrado">
                    <a href="administrarProfesores.aspx" class="btn btn-primary btn-block cancelar-color">Cancelar</a>
                    <asp:Button ID="btnAgregar" Text="Agregar" runat="server" CssClass="btn btn-primary btn-block primary-color" OnClick="btnAgregar_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
