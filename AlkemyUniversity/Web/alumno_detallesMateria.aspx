<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="alumno_detallesMateria.aspx.cs" Inherits="Web.alumno_detallesMateria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <table class="table table-bordered">
            <tr>
                <td>Nombre de la materia</td>
                <td>Cupos disponibles</td>
                <td>Profesor</td>
                <td>Horarios</td>
                <td></td>
            </tr>
            <%if (subject_info != null)
                {%>
            <tr>
                <td><%=subject_info.subject.name %></td>
                <td><%=subject_info.subject.places_available %></td>
                <td><%=subject_info.teacher.lastname + " " + subject_info.teacher.names %></td>
                <%if (lista_schedules == null)
                    { %>
                <td>No tiene</td>
                <% }
                    else
                    {%>
                <td>
                    <asp:Label ID="lblHorarios" runat="server"></asp:Label>
                </td>
                <%} %>
                <td>
                     <a href="menuAlumno.aspx?subjectID=<%= subject_id %>&enroll=1" class="btn btn-primary" style="width: 80PX;">Inscribirse</a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</asp:Content>
