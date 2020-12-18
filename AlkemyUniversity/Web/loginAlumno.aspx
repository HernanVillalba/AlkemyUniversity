<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loginAlumno.aspx.cs" Inherits="Web.loginAlumno" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!-- CSS only -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
    <title>Acceso Alumnos</title>

    <style>
        .centrado {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .primary-color {
            background-color: #65d6ce;
            border-color:#65d6ce;
        }
    </style>
</head>
<body>

    <form runat="server">
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
                        <asp:Button ID="btnIngresar" Text="Acceder" runat="server" OnClick="btnIngresar_Click" CssClass="btn btn-primary btn-block primary-color"  />
                    </div>
                </div>
            </div>
        </div>
    </form>


</body>
</html>
