<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="administrarUsuarios.aspx.cs" Inherits="Web.administrarUsuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <div class="centrado">
            <h3>Administradores</h3>
        </div>
        <table class="table table-bordered">
            <tr>
                <td>ID</td>
                <td>Apellidos</td>
                <td>Nombres</td>
                <td>DNI</td>
                <td></td>
            </tr>
            <%if (lista_admin != null)
                {
                    foreach (var item in lista_admin)
                    {%>
            <tr>
                <td><%= item.ID %></td>
                <td><%= item.person.lastname %></td>
                <td><%= item.person.names %></td>
                <td><%= item.person.DNI %></td>
                <td>
                    <!--<a href="#" class="btn btn-primary">Dar de baja</a>ANULADO POR AHORA -->
                </td>
            </tr>
            <%}

                } %>
        </table>
    </div>
    <div class="centrado">
        <a href="agregarAdministrador.aspx" class="btn btn-primary">Agrgar administrador</a>
    </div>

    <hr />

    <div>
        <div class="centrado">
            <h3>Usuarios</h3>
        </div>
        <table class="table table-bordered">
            <tr>
                <td>Legajo</td>
                <td>Apellidos</td>
                <td>Nombres</td>
                <td>DNI</td>
                <td></td>
            </tr>
            <%if (lista_students != null)
                {
                    foreach (var item in lista_students)
                    {%>
            <tr>
                <td><%= item.Docket %></td>
                <td><%= item.person.lastname %></td>
                <td><%= item.person.names %></td>
                <td><%= item.person.DNI %></td>
                <td>
                    <!--<a href="#" class="btn btn-primary">Eliminar</a> ANULADO POR AHORA-->
                </td>
            </tr>
            <% }
                } %>
        </table>
        <div class="centrado">
            <a href="agregarAlumno.aspx" class="btn btn-primary">Agregar estudiante</a>
        </div>
    </div>
    <hr />
    <div class="centrado">
        <a href="menuAdministrador.aspx" class="btn btn-primary btn-block">Volver al menú</a>
    </div>
</asp:Content>
