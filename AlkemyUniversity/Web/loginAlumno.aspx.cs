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
    public partial class loginAlumno2 : System.Web.UI.Page
    {
        AlumnoNegocio negocio = new AlumnoNegocio();
        protected void Page_Load(object sender, EventArgs e)
        {
            Redireccionar();
        }

        protected void Redireccionar()
        {
            if (Session["ObjetoUsuario"] != null)
            {
                Response.Redirect("menuAlumno.aspx");
            }
            if(Session["AdminBool"] != null &&  (bool)Session["AdminBool"] == true)
            {
                Response.Redirect("menuAdministrador.aspx");
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            Student student = new Student(Convert.ToInt32(txtLegajo.Text), Convert.ToInt32(txtDNI.Text));
            student = negocio.LoginEstudiante(student);

            if(student != null)
            {
                Session["ObjetoUsuario"] = student;
                Session["AdminBool"] = false;
                Response.Redirect("menuAlumno.aspx");
            }
            else
            {
                Session["ErrorMessageLoginAlumno"] = true;
            }

        }
    }
}