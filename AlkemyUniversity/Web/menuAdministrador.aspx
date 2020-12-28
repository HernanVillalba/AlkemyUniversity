<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="menuAdministrador.aspx.cs" Inherits="Web.menuAdministrador2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="centrado">
            <div class="jumbotron" style="background-color: black; width: auto; opacity: 0.9;">
                <div class="row">
                    <div class="col">
                        <a href="administrarMaterias.aspx">
                            <div class="card" style="width: 18rem;">
                                <div class="card-header centrado">
                                    <h3>Materias</h3>
                                </div>
                                    <img class="card-img-top" src="https://wpd.ugr.es/~emiro/wp-content/uploads/Icono-material-298x300.png" alt="Materias" />
                            </div>
                        </a>
                    </div>

                    <div class="col">
                        <a href="administrarProfesores.aspx">
                            <div class="card" style="width: 18rem;">
                                <div class="card-header centrado">
                                    <h3>Profesores</h3>
                                </div>
                                <img class="card-img-top" src="https://v.fastcdn.co/u/a0289c58/20402331-0-teacher-icon.png" alt="Materias" />
                            </div>
                        </a>
                    </div>

                </div>

                <hr />

                <div class="centrado">
                    <asp:Button ID="btnSalir" Text="Salir" runat="server" OnClick="btnSalir_Click" CssClass="btn btn-primary btn-block primary-color" />
                </div>
            </div>
        </div>
</asp:Content>
