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
    public partial class agregarProfesor : System.Web.UI.Page
    {
        AdminNegocio negocio;
        Teacher teacher;

        protected void Page_Load(object sender, EventArgs e)
        {
            Redireccionar();
        }
        private void Redireccionar()
        {
            if (Session["AdminBool"] == null || !(bool)Session["AdminBool"])
            {
                Response.Redirect("loginAdministradorPagina.aspx");
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            negocio = new AdminNegocio();
            //cargo los datos ingresados de la web en la variable teacher para guardalos en la DB
            teacher = new Teacher(Convert.ToInt32(tbDNI.Text),tbApellido.Text,tbNombres.Text,cbActivo.Checked);
            if (negocio.AgregarNuevoProfesor(teacher))
            {
                //si no hay error al cargar el profesor
                Session["MessageErrorNewTeacher"] = false;
                //reinicia los campos
                tbDNI.Text = "";
                tbApellido.Text = "";
                tbNombres.Text = "";
                cbActivo.Checked = false;
            }
            else
            {
                //si hay error al cargar el profesor
                Session["MessageErrorNewTeacher"] = true;
            }
        }
    }
}