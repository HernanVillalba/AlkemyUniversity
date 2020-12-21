<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="administrarMaterias.aspx.cs" Inherits="Web.administrarMateria2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="centrado">
            <div>
                <div>
                    <h1>Materias</h1>
                </div>
                <div class="jumbutron">
                    <div class="form-group">
                        <asp:TextBox runat="server" ID="tbBuscar" />
                        <asp:Button Text="Buscar" runat="server" CssClass="btn btn-primary primary-color" />
                    </div>
                    <div class="centrado">
                        <a href="AgregarMateria.aspx" class="">Agregar materia</a>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
