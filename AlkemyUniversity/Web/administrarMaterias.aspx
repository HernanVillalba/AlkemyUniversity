<%@ Page Title="Administrar materias" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="administrarMaterias.aspx.cs" Inherits="Web.administrarMaterias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="centrado">
        <div>
            <div class="centrado">
                <h1>Materias</h1>
            </div>
            <div class="jumbotron">
                <div class="centrado">
                    <div class="form-inline">
                        <asp:TextBox runat="server" ID="tbBuscar" CssClass="form-control" />
                        <asp:Button ID="btnBuscar" Text="Buscar" runat="server" CssClass="btn btn-primary primary-color" OnClick="btnBuscar_Click" />
                    </div>
                </div>
            </div>
            <%if (lista != null && lista.Count() > 0)
                {%>
            <table class="table table-bordered">
                <tr>
                    <td>Nombre</td>
                    <td>Luegares disponibles</td>
                    <td>Capacidad máxima</td>
                    <td>Profesor</td>
                    <td>Horarios</td>
                    <td>Acciones</td>
                </tr>
                <%foreach (var item in lista)
                    {
                        string horario = item.subject.schedules.day + " " + item.subject.schedules.start_time + "-" + item.subject.schedules.end_time;
                %>
                <tr>
                    <td><%= item.subject.name %></td>
                    <td><%= item.subject.places_available %></td>
                    <td><%= item.subject.maximum_capacity %></td>
                    <td><%= item.teacher.lastname + " " + item.teacher.names %></td>
                    <td><%= horario %></td>
                    <td>
                        <a href="editarMateria.aspx?ID=<%=item.subject.ID %>" class="btn btn-primary">Editar</a>
                        <a href="#" class="btn btn-primary">Eliminar</a>
                    </td>
                    <%} %>
                </tr>
            </table>
            <%}
                else
                {%>
            <div class="alert alert-secondary" role="alert">
                <h4 class="alert-heading">No hay materias para listar.</h4>
            </div>
            <%} %>
            <a href="menuAdministrador.aspx" class="btn btn-primary">Volver al menú principal</a>
            <a href="AgregarMateria.aspx" class="btn btn-primary">Agregar materia</a>
        </div>
    </div>
</asp:Content>
