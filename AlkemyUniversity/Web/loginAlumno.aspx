<%@ Page Title="Ingreso alumnos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="loginAlumno.aspx.cs" Inherits="Web.loginAlumno2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function validar() {
            var legajo = document.getElementById("<% = txtLegajo.ClientID %>").value;
            var dni = document.getElementById("<% = txtDNI.ClientID %>").value;
            if (legajo === "" || dni === "") {
                alert("Debes completar los campos");
                return false;
            }
            else {return true}

        }
    </script>

    <%if (Session["ErrorMessageLoginAlumno"] != null)
        {
            if ((bool)Session["ErrorMessageLoginAlumno"])
            {%>
    <div class="alert alert-danger">Los datos ingresados son incorrectos.</div>
    <% }
            Session["ErrorMessageLoginAlumno"] = null;
        } %>
    <div class="centrado">
        <div class="centrado" style="background-color: rgb(242,242,242); border-radius: 10px; width: 600px;">
            <h1>Iniciar sesión - Alumnos</h1>
        </div>
    </div>
    <hr />
    <div class="centrado">
        <div style="width: 500px; border-radius: 10px; background-color: rgb(242,242,242); padding: 40px; opacity: 0.9;">
            <div style="width: 20rem; margin: auto;">
                <div class="form-group">
                    <label>Legajo: </label>
                    <asp:TextBox runat="server" ID="txtLegajo" CssClass="form-control" type="number" />
                </div>
                <div class="form-group">
                    <label>DNI: </label>
                    <asp:TextBox runat="server" ID="txtDNI" CssClass="form-control" type="number" />
                </div>
                <div>
                    <asp:Button ID="btnIngresar" Text="Acceder" runat="server" OnClientClick="return validar();" OnClick="btnIngresar_Click" CssClass="btn btn-primary btn-block primary-color" />
                    <hr />
                    <a href="loginAdministradorPagina.aspx" class="btn btn-primary btn-block">Ingreso administradores</a>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
