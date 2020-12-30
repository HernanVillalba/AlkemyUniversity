using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace Web
{
    public partial class agregarAdministrador : System.Web.UI.Page
    {
        AdminNegocio negocio = new AdminNegocio();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Administrator admin = new Administrator(txtContraseña.Text, txtApellido.Text, txtNombres.Text, Convert.ToInt32(txtDNI.Text));
            if (negocio.RegistrarAdministrador(admin)) //devuelve true si guardó
            {
                Session["ErrorMessageAgregarAdmin"] = false;
                txtApellido.Text = txtNombres.Text = txtDNI.Text = txtContraseña.Text = txtContraseña2.Text = "";
            }
            else
            {
                Session["ErrorMessageAgregarAdmin"] = true;
            }
        }
    }
}