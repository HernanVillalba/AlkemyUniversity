<%@ Page Title="Agregar materia" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="agregarMateria.aspx.cs" Inherits="Web.AgregarMateria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="centrado">
        <script>
            function validarNuevaMateria() {
                var nombre = document.getElementById("<% = txtNombre.ClientID %>").value;
                var capMax = document.getElementById("<% = txtCapacidadMax.ClientID %>").value;
                var hsCom = document.getElementById("<% = txtComienzo.ClientID %>").value;
                var hsFin = document.getElementById("<% = txtFinal.ClientID %>").value;
                var ddlDias = document.getElementById("<%= ddlDias.ClientID %>").value;
                var ddlProfesores = document.getElementById("<% = ddlProfesores.ClientID %>").value;
                
                if (nombre === "" || hsCom === "" || hsFin === "") {
                    alert("Debe completar todos los campos.");
                    return false;
                }
                if (isNaN(capMax)) {
                    alert("El valor de 'Capacidad máxima' debe ser un número.");
                    ddlProfesores.add
                    return false;
                }
                if (ddlDias === "0") {
                    alert("Seleccioner el día.");
                    return false;
                }
                if (ddlProfesores === "0") {
                    alert("Seleccioner un profesor.");
                    return false;
                }
                return true;
                
            }
            function alerta(elemento) {
                alert(elemento.value)
            }
        </script>
        <div>
            <div>
                <%if (Session["ErrorMessage"] != null)
                    {
                        if ((bool)Session["ErrorMessage"] == true)
                        {%>
                <div class="alert alert-danger" role="alert">
                    No se pudo guardar la materia.
                </div>
                <%}
                    else
                    {%>
                <div class="alert alert-success" role="alert">
                    Materia guardada correctamente.
                </div>
                <%}
                        Session["ErrorMessage"] = null;
                    }%>
            </div>
            <h1>Nueva materia</h1>
            <div class="form-group">
                <label>Nombre: </label>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label>Capacidad máxima: </label>
                <asp:TextBox ID="txtCapacidadMax" runat="server" CssClass="form-control" />
            </div>
            <div>
                <h3>Horario</h3>
                <div class="form-group">
                    <label class="col-form-label">
                        Día: 
                        <asp:DropDownList runat="server" ID="ddlDias" CssClass="form-control">
                            <asp:ListItem Value="0" Text="Seleccione"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Lunes"></asp:ListItem>
                            <asp:ListItem Value="2" Text="Martes"></asp:ListItem>
                            <asp:ListItem Value="3" Text="Miércoles"></asp:ListItem>
                            <asp:ListItem Value="4" Text="Jueves"></asp:ListItem>
                            <asp:ListItem Value="5" Text="Viernes"></asp:ListItem>
                            <asp:ListItem Value="6" Text="Sábado">Sábado</asp:ListItem>
                            <asp:ListItem Value="7" Text="Domingo"></asp:ListItem>
                        </asp:DropDownList>
                    </label>
                </div>
                <div class="form-group">
                    <label>Comienzo: </label>
                    <asp:TextBox runat="server" ID="txtComienzo" CssClass="form-control" type="time" />
                </div>
                <div class="form-group">
                    <label>Finalización: </label>
                    <asp:TextBox runat="server" ID="txtFinal" CssClass="form-control" type="time" />
                </div>
            </div>
            <div class="form-group">
                <label>Profesor: </label>
                <asp:DropDownList ID="ddlProfesores" runat="server">
                    <asp:ListItem Value="0">Seleccione</asp:ListItem>
                </asp:DropDownList>
                <a href="agregarProfesor.aspx" class="btn btn-primary primary-color">Agregar profesor</a>
            </div>
            <div class="centrado">
                <a href="administrarMaterias.aspx" class="btn btn-primary primary-color">Volver</a>
                <asp:Button ID="btnAgregar" Text="Agregar materia" runat="server" CssClass="btn btn-primary primary-color" OnClientClick="return validarNuevaMateria();" OnClick="btnAgregar_Click" />
            </div>
        </div>
    </div>
</asp:Content>
