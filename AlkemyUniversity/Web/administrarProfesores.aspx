<%@ Page Title="Administrar profesores" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="administrarProfesores.aspx.cs" Inherits="Web.administrarProfesores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="centrado">
            <h1>Profesores</h1>
        </div>
        <div>
            <div class="jumbotron">
                <div class="form-inline centrado">
                    <asp:TextBox ID="tbBuscar" runat="server" CssClass="form-control" />
                    <asp:Button ID="btnBuscar" Text="Buscar" runat="server" CssClass="btn btn-primary" OnClick="btnBuscar_Click" />
                </div>

            </div>
            <%if (listaTeachers != null && listaTeachers.Count() > 0)
                {%>
            <table class="table table-bordered" style="border-radius:10px; opacity:0.9;">
                <tr>
                    <td>Apellido y nombre</td>
                    <td>DNI</td>
                    <td>Activo</td>
                    <td>Cantidad de materias</td>
                    <td></td>
                </tr>
                <%foreach (var item in listaTeachers)
                    {%>
                <tr>
                    <td><%=item.lastname + " " + item.names %></td>
                    <td><%=item.DNI %></td>
                    <%if (item.active)
                        { %>
                    <td>Si</td>
                    <%}
                        else
                        {%>
                    <td>No</td>
                    <%} %>
                    <td><%=item.number_subjects %></td>
                    <td>
                        <a href="editarProfesor.aspx?ID=<%=item.ID %>" class="btn btn-primary">Editar</a>
                        <!--<a href="#" class="btn btn-primary">Eliminar</a> ANULADO POR AHORA-->
                    </td>
                </tr>
                <% } %>
            </table>
            <%}
                else
                {%>
            <div class="alert alert-secondary" role="alert">
                <h4 class="alert-heading">No hay profesores para mostrar.</h4>
            </div>
            <%} %>
        </div>
        <div class="centrado">
            <a href="menuAdministrador.aspx" class="btn btn-primary">Volver al menú</a>
            <a href="agregarProfesor.aspx" class="btn btn-primary">Agregar profesor</a>
        </div>
    </div>
</asp:Content>
