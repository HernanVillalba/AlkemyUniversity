<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loginAdministradorPagina.aspx.cs" Inherits="Web.loginAdministradorPagina" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!-- CSS only -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />

    <title>Acceso Administrador</title>

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
    </style>

</head>
<body>
    <form runat="server">
        <hr />
        <div class="centrado">
            <div class="centrado" style="background-color: rgb(242,242,242); border-radius: 10px; width: 600px;">
                <h1>Iniciar sesión - Administrador</h1>
            </div>
        </div>
        <hr />
        <div class="centrado">
            <div style="width: 500px; border-radius: 10px; background-color: rgb(242,242,242); padding: 40px; opacity: 0.9;">
                <%if (Session["MessageError"] != null && (bool)Session["MessageError"] != false) //mensaje de error
                    {
                        Session["MessageError"] = null;
                %>
                <div class="alert alert-danger" role="alert">
                    Datos incorrectos.
                </div>
                <%}
                    else { Session["MessageError"] = null; }%>

                <div class="form-group">
                    <label>ID: </label>
                    <asp:TextBox runat="server" ID="tbIDAdmin" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Contraseña: </label>
                    <asp:TextBox runat="server" ID="tbContraseñaAdmin" TextMode="Password" CssClass="form-control" />
                </div>
                <div>
                    <asp:Button ID="btnIngresar" Text="Acceder" runat="server" OnClick="btnIngresar_Click" CssClass="btn btn-primary btn-block primary-color" />
                </div>
            </div>
        </div>

    </form>


</body>
</html>
