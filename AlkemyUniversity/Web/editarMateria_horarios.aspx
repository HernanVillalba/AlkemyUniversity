<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="editarMateria_horarios.aspx.cs" Inherits="Web.editarMateria_horarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function validarEditarMateria() {
            var hsCom = document.getElementById("<%= txtComienzo.ClientID %>").value;
            var hsFin = document.getElementById("<% = txtFinalizacion.ClientID %>").value;
            if (hsCom === "") {

                alert("Debe indicar el horario de comienzo.");
                return false;
            }
            if (hsFin === "") {
                alert("Debe indicar el horario de finalización.");
                return false;
            }
        }
    </script>
    <div>
        <div>
            <table class="table table-bordered">
                <tr>
                    <td>Dia</td>
                    <td>Hora comienzo</td>
                    <td>Hora finalización</td>
                    <td>Acción</td>
                </tr>
                <%foreach (var item in lista)
                    {%>
                <tr>
                    <td><%=item.day %></td>
                    <td><%=item.start_time %></td>
                    <td><%=item.end_time %></td>
                    <td><a href="editarMateria_horarios.aspx?ID=<%= SubjectID %>&ScheduleID=<%=item.ID %>&delete=1" class="btn btn-primary">Eliminar</a></td>
                </tr>
                <%    } %>
            </table>
        </div>
        <hr />
        <div>
            <%if (Session["ErrorMessageHorarios"] != null)
                {
                    if ((bool)Session["ErrorMessageHorarios"])
                    {  %>
            <div class="alert alert-danger">
                <h4 class=" alert alert-heading">No se pudo guardar el horario.</h4>
            </div>
            <% }
                else
                {%>
            <div class="alert alert-success">
                <h4>Horario guardado correctamente.</h4>
            </div>

            <%}
                    Session["ErrorMessageHorarios"] = null;
                } %>
        </div>
        <div class="centrado">
            <h3>Agregar nuevo horario</h3>
        </div>
        <div>
            <div class="form-group">
                <label>Día: </label>
                <asp:DropDownList runat="server" ID="ddlDias" CssClass="form-control">
                    <asp:ListItem Value="0" Text="Seleccione"></asp:ListItem>
                    <asp:ListItem Value="1" Text="Lunes"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Martes"></asp:ListItem>
                    <asp:ListItem Value="3" Text="Miércoles"></asp:ListItem>
                    <asp:ListItem Value="4" Text="Jueves"></asp:ListItem>
                    <asp:ListItem Value="5" Text="Viernes"></asp:ListItem>
                    <asp:ListItem Value="6" Text="Sábado"></asp:ListItem>
                    <asp:ListItem Value="7" Text="Domingo"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Comienzo</label>
                <asp:TextBox ID="txtComienzo" runat="server" CssClass="form-control" type="time" />

            </div>
            <div class="form-group">
                <label>Finalización</label>
                <asp:TextBox ID="txtFinalizacion" runat="server" CssClass="form-control" type="time" />
            </div>
        </div>
    </div>
    <div>
        <a href="editarMateria.aspx?ID=<%=SubjectID.ToString() %>" class="btn btn-primary">Volver</a>
        <asp:Button ID="btnGuardar" Text="Guardar" runat="server" CssClass="btn btn-primary" OnClientClick="return validarEditarMateria();" OnClick="btnGuardar_Click" />
    </div>

</asp:Content>
