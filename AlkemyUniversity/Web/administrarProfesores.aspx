﻿<%@ Page Title="Administrar profesores" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="administrarProfesores.aspx.cs" Inherits="Web.administrarProfesores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="centrado">
            <h1>Profesores</h1>
        </div>
        <div>
            <div class="jumbotron">
                <div class="form-inline centrado">
                    <asp:TextBox ID="tbBuscar" runat="server" CssClass="form-control" />
                    <asp:Button ID="btnBuscar" Text="Buscar" runat="server" CssClass="btn btn-primary" />
                </div>

            </div>
            <table class="table">
                <tr>
                    <td>Apellido y nombre</td>
                    <td>DNI</td>
                    <td>Activo</td>
                    <td>Cantidad de materias</td>
                    <td>Acciones</td>
                </tr>
                <%foreach (var item in listaTeachers)
                    {%>
                <tr>
                    <td><%=item.lastname +" "+item.names %></td>
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
                        <a href="#" class="btn btn-primary">Editar</a>
                        <a href="#" class="btn btn-primary">Eliminar</a>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>
        <div class="centrado">
            <a href="menuAdministrador.aspx" class="btn btn-primary">Volver al menú</a>
            <a href="agregarProfesor.aspx" class="btn btn-primary">Agregar profesor</a>
        </div>
    </div>
</asp:Content>
