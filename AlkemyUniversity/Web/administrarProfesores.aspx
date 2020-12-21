<%@ Page Title="Administrar profesores" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="administrarProfesores.aspx.cs" Inherits="Web.administrarProfesores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="centrado">
            <div class="form-group">
                <asp:TextBox ID="tbBuscar" runat="server" />
                <asp:Button ID="btnBuscar" Text="Buscar" runat="server" />
            </div>
        </div>
        <div class="centrado">
            <a href="agregarProfesor.aspx">Agregar profesor</a>
        </div>
    </div>
</asp:Content>
