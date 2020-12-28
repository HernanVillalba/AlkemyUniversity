<%@ Page Title="Agregar materia" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarMateria.aspx.cs" Inherits="Web.AgregarMateria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="centrado">
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
                        <asp:DropDownList runat="server" ID="ddlDias" CssClass="custom-checkbox">
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
                    <asp:TextBox runat="server" ID="txtHsComienzo" CssClass="form-control" />
                    <asp:TextBox runat="server" ID="txtMinComienzo" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Finalización: </label>
                    <asp:TextBox runat="server" ID="txtHsFinal" CssClass="form-control" />
                    <asp:TextBox runat="server" ID="txtMinFinal" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label>Profesor: </label>
                <asp:DropDownList ID="ddlProfesores" runat="server">
                    <asp:ListItem  Value="0">Seleccione</asp:ListItem>
                </asp:DropDownList>
                <a href="agregarProfesor.aspx" class="btn btn-primary primary-color">Agregar profesor</a>
            </div>
            <div class="centrado">
                <a href="menuAdministrador.aspx" class="btn btn-primary primary-color">Cancelar</a>
                <asp:Button ID="btnAgregar" Text="Agregar materia" runat="server" CssClass="btn btn-primary primary-color" OnClick="btnAgregar_Click" />
            </div>
        </div>
    </div>
</asp:Content>
