<%@ Page Title="Mis incripciones" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="alumno_verMisInscripciones.aspx.cs" Inherits="Web.alumno_verMisInscripciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="centrado">
            <h1>Mis inscripciones</h1>
        </div>
        <table class="table table-bordered">
            <tr>
                <td>Nombre de la materia</td>
                <td>Fecha de inscripciòn</td>
            </tr>
            <%if (lista_subjects != null)
                {
                    foreach (var item in lista_subjects)
                    {%>
            <tr>
                <td><%=item.name %></td>
                <td><%=item.enrollment_date%></td>
                <%} %>
            </tr>
            <% } %>
        </table>
        <div class="centrado">
            <a href="menuAlumno.aspx" class="btn btn-primary btn-block">Volver al menú</a>
        </div>
    </div>
</asp:Content>
