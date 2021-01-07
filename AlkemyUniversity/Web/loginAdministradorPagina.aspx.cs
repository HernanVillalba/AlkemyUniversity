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
    public partial class loginAdministradorPagina2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ID"] != null)
            {
                if (Session["AdminBool"] == null || (bool)Session["AdminBool"] == true)
                {
                    //si quiere volver a ingresar ya habiendose logueado antes como
                    //admin, lo redirijo a su menú.
                    Response.Redirect("menuAdministrador.aspx");
                }
                else
                {
                    //si quiere volver a ingresar ya habiendose logueado antes como
                    //alumno, lo redirijo a su menú.
                    Response.Redirect("menuAlumno.aspx");
                }
            }

        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            AdminNegocio negocio = new AdminNegocio();
            Administrator admin = new Administrator();

            //guardo los valores ingresados en el Front en la variable admin
            admin.ID = Convert.ToInt32(txtIDAdmin.Text);
            admin.password = txtContraseñaAdmin.Text;


            //me devuelve id=0 si no son correctos los datos ingresados
            LogIn(negocio.Login(admin));
        }
        private void LogIn(Administrator admin)
        {
            if (admin.ID != 0 || admin.user.admin)
            {
                Session["ID"] = admin.ID;
                Session["AdminBool"] = admin.user.admin;
                Session["MessageError"] = null;
                Response.Redirect("menuAdministrador");
            }
            else
            {
                Session["MessageError"] = true;
                Response.Redirect("loginAdministradorPagina.aspx");
            }
        }
    }
}