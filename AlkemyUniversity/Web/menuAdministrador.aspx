<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="menuAdministrador.aspx.cs" Inherits="Web.menuAdministrador" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
    <title>Menú Administrador</title>

    <style>
        .centrado {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .primary-color {
            background-color: #65d6ce;
            border-color: #65d6ce;
        }

        .tam.image-card {
            width: 250px;
            height: auto;
        }
    </style>
</head>
<body>
    <form runat="server">
        <div class="centrado">
            <div class="jumbotron" style="background-color: black; width: auto; opacity: 0.9;">
                <div class="row">
                    <div class="col">
                        <a href="administrarMateria.aspx">
                            <div class="card" style="width: 18rem;">
                                <div class="card-header centrado">
                                    <h1>Materias</h1>
                                </div>
                                <a href="administrarMateria.aspx">
                                    <img class="card-img-top" src="https://wpd.ugr.es/~emiro/wp-content/uploads/Icono-material-298x300.png" alt="Materias" />
                                </a>
                            </div>
                        </a>
                    </div>

                    <div class="col">
                        <a href="#">
                            <div class="card" style="width: 18rem;">
                                <div class="card-header centrado">
                                    <h1>Profesores</h1>
                                </div>
                                <img class="card-img-top" src="https://v.fastcdn.co/u/a0289c58/20402331-0-teacher-icon.png" alt="Materias" />
                            </div>
                        </a>
                    </div>

                </div>

                <hr />

                <div>
                    <asp:Button ID="btnSalir" Text="Salir" runat="server" OnClick="btnSalir_Click" CssClass="btn btn-primary btn-block primary-color" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
