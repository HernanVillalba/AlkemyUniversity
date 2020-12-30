<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="menuAlumno.aspx.cs" Inherits="Web.menuAlumno2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="centrado">
        <h1>Inscripción a materias</h1>
    </div>

    <div class="centrado">
        <div class="jumbotron" style="width: auto;">
            <div class="form-inline">
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" />
                <asp:Button ID="btnBuscar" Text="Buscar materia" runat="server" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>

    <div class="centrado">
        <table class="table table-bordered">
            <tr>
                <td>Nombre de la materia</td>
                <td></td>
                <td></td>
            </tr>
            <%if (listaMaterias != null)
                {
                    foreach (var item in listaMaterias)
                    {%>
            <tr>
                <td><%= item.name %></td>
                <td class="centrado">
                    <a href="menuAlumno.aspx?subjectID=<%=item.ID %>&enroll=1" class="btn btn-primary" style="width: 80PX;">Inscribirse</a>
                </td>
                <td>
                    <a href="alumno_detallesMateria.aspx?subjectID=<%=item.ID %>" class="btn btn-primary">Ver detalles</a>
                </td>
            </tr>
            <%}
                } %>
        </table>
    </div>
    <div class="centrado">
        <a href="alumno_verMisInscripciones.aspx" class="btn btn-primary">Ver mis inscripciones</a>
    </div>
    <hr />
    <div class="centrado">
        <asp:Button ID="btnSalir" Text="Salir" runat="server" CssClass="btn btn-primary btn-block" OnClick="btnSalir_Click" />
    </div>
</asp:Content>
