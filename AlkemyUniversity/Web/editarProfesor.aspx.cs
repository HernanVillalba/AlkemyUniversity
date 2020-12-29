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
    public partial class editarProfesor : System.Web.UI.Page
    {
        AdminNegocio negocio = new AdminNegocio();
        Teacher teacher = new Teacher();
        int profesorID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            profesorID = Convert.ToInt32(Request.QueryString["ID"]);
            if(profesorID == 0)
            {
                Response.Redirect("administrarProfesores.aspx");
            }
            if (!IsPostBack) //para que no me borre los datos de los txt al volver a cargar la página o precionar un evento de un boton.
            {
                if (profesorID > 0)
                {
                    cargarDatosProfesor();
                }
            }
        }
        protected void cargarDatosProfesor()
        {
            teacher = negocio.BuscarProfesorPorID(profesorID);
            if (teacher != null)
            {
                txtApellido.Text = teacher.lastname;
                txtNombre.Text = teacher.names;
                txtDNI.Text = teacher.DNI.ToString();
                if (teacher.active) { cbActivo.Checked = true; }
                else { cbActivo.Checked = false; }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if(profesorID > 0)
            {
                teacher.ID = profesorID;
                teacher.lastname = txtApellido.Text;
                teacher.names = txtNombre.Text;
                teacher.DNI = Convert.ToInt32(txtDNI.Text);
                teacher.active = cbActivo.Checked;
                if (negocio.ActualizarProfesor(teacher))
                {
                    Session["ErrorMessage"] = false;
                    txtApellido.Text = "";
                    txtNombre.Text = "";
                    txtDNI.Text = "";
                    cbActivo.Checked = false;
                }
                else
                {
                    Session["ErrorMessage"] = true;
                }
            }

        }
    }
}