<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="editarMateria.aspx.cs" Inherits="Web.editarMateria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <div class="centrado">
            <h1>Editar materia</h1>
        </div>
        <div class="centrado">
            <div>

                <div class="form-group">
                    <label>Nombre: </label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Capacidad máxima:</label>
                    <asp:TextBox ID="txtCapacidadMax" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Profesor: </label>
                    <div class="form-inline">
                        <asp:TextBox ID="txtProfesor" runat="server" Enabled="false" CssClass="form-control" />
                        <asp:Button ID="btnEditarTeacher" Text="Editar" runat="server" CssClass="btn btn-primary" OnClick="btnEditarTeacher_Click" />
                        <asp:DropDownList ID="ddlProfesoresActivos" runat="server" Visible="false" CssClass="form-control">
                        </asp:DropDownList>
                        <a id="btnEliminar" href="editarMateria.aspx?ID=<%=SubjectID %>&deleteTeacher=1" class="btn btn-primary">Eliminar</a>
                    </div>
                </div>
                <label>Horarios: </label>
                <div class="table table-bordered">
                    <div class="centrado" style="max-width: 200px;">
                        <strong>
                            <asp:Label runat="server" ID="lblHorarios" />
                        </strong>
                    </div>
                </div>
                <div class="centrado">
                    <a href="editarMateria_horarios.aspx?ID=<%= SubjectID %>" class="btn btn-primary">Editar horarios</a>
                </div>

            </div>
        </div>
    </div>

    <hr />
    <div class="centrado">
        <a href="administrarMaterias.aspx" class="btn btn-primary">Volver</a>
        <asp:Button runat="server" ID="btnGuardar" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
    </div>


</asp:Content>
