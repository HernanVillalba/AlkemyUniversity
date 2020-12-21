<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="loginAlumno.aspx.cs" Inherits="Web.loginAlumno2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="centrado">
        <div class="centrado" style="background-color: rgb(242,242,242); border-radius: 10px; width: 600px;">
            <h1>Iniciar sesión - Alumnos</h1>
        </div>
    </div>
    <hr />
    <div class="centrado">
        <div style="width: 500px; border-radius: 10px; background-color: rgb(242,242,242); padding: 40px; opacity: 0.9;">
            <div style="width: 20rem; margin: 0 auto;">
                <div class="form-group">
                    <label>Legajo: </label>
                    <asp:TextBox runat="server" ID="tbLegajo" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>DNI: </label>
                    <asp:TextBox runat="server" ID="tbDNI" CssClass="form-control" />
                </div>
                <div>
                    <asp:Button ID="btnIngresar" Text="Acceder" runat="server" OnClick="btnIngresar_Click" CssClass="btn btn-primary btn-block primary-color" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
