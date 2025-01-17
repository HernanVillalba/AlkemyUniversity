﻿<%@ Page Title="Iniciar sesión Administrador" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="loginAdministradorPagina.aspx.cs" Inherits="Web.loginAdministradorPagina2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function validarLoginAdmin() {
            var id = document.getElementById("<% = txtIDAdmin.ClientID %>").value;
            var contraseña = document.getElementById("<% = txtContraseñaAdmin.ClientID %>").value;
            if (id === "" || contraseña === "") {
                alert("Debe completar los campos.");
                return false;
            }
            return true;
        }
    </script>
    <hr />
    <div class="centrado">
        <div class="centrado" style="background-color: rgb(242,242,242); border-radius: 10px; width: 600px;">
            <h1>Iniciar sesión - Administrador</h1>
        </div>
    </div>
    <hr />
    <div class="centrado">
        <div class="centrado" style="width: 400px; border-radius: 10px; background-color: rgb(242,242,242); padding: 40px; opacity: 0.9;">
            <div>
                <div>
                    <%if (Session["MessageError"] != null && (bool)Session["MessageError"] != false) //mensaje de error
                        {
                            Session["MessageError"] = null;
                    %>
                    <div class="alert alert-danger centrado" role="alert">
                        Datos incorrectos.
                    </div>

                    <%Session["MessageError"] = null;
                        }%>
                </div>

                <div>
                    <div class="form-group">
                        <label>ID: </label>
                        <asp:TextBox runat="server" ID="txtIDAdmin" CssClass="form-control" type="number" />
                    </div>
                    <div class="form-group">
                        <label>Contraseña: </label>
                        <asp:TextBox runat="server" ID="txtContraseñaAdmin" TextMode="Password" CssClass="form-control" />
                    </div>
                    <div>
                        <asp:Button ID="btnIngresar" Text="Acceder" runat="server" OnClientClick="return validarLoginAdmin();" OnClick="btnIngresar_Click" CssClass="btn btn-primary btn-block primary-color" />
                        <hr />
                        <a href="loginAlumno.aspx" class="btn btn-primary btn-block">Ingreso alumnos</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
