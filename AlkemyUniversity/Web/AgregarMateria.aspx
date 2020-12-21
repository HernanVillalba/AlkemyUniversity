<%@ Page Title="Agregar materia" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarMateria.aspx.cs" Inherits="Web.AgregarMateria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div>
            <div class="form-group">
                <label>Nombre: </label>
                <asp:TextBox ID="tbNombre" runat="server" />
            </div>
            <div class="form-group">
                <label>Capacidad máxima: </label>
                <asp:TextBox ID="tbCapacidadMax" runat="server" />
            </div>
            <div class="form-group">
                <label>Profesor: </label>
                <asp:DropDownList runat="server">
                    <asp:ListItem>Profesor 1</asp:ListItem>
                    <asp:ListItem>Profesor 2</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
            </div>
            <div class="form-group">
            </div>
        </div>

    </div>
</asp:Content>
