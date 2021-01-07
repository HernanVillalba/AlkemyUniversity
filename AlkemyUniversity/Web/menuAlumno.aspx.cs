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
    public partial class menuAlumno2 : System.Web.UI.Page
    {
        AlumnoNegocio negocio = new AlumnoNegocio();
        public List<Subject> listaMaterias = new List<Subject>();
        Student student = new Student();
        int subjectID;
        int enroll;
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarVariables();
            Redireccionar();
            if (subjectID > 0 && enroll == 1)
            {
                IncrirseAMateria();
            }
        }

        protected void Redireccionar()
        {
            if (Session["ObjetoUsuario"] == null || Session["AdminBool"] == null)
            {
                Response.Redirect("loginAlumno.aspx");
                if (Session["AdminBool"] == null || (bool)Session["AdminBool"])
                {
                    Response.Redirect("loginAdministradorPagina.aspx");
                }
            }
        }

        protected void IncrirseAMateria()
        {
            //la session es para mostrar mensaje en el front
            Session["filasAfectadas"] = negocio.InscribirAlumnoAMateria(subjectID, student.docket);
            Response.Redirect("menuAlumno.aspx");
        }

        protected void CargarVariables()
        {
            if (Session["ObjetoUsuario"] != null)
            {
                student = (Student)Session["ObjetoUsuario"];
            }

            listaMaterias = negocio.listarMateriasAlumno(student.docket);
            subjectID = Convert.ToInt32(Request.QueryString["subjectID"]);
            enroll = Convert.ToInt32(Request.QueryString["enroll"]);
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session["ID"] = null;
            Session["ObjetoUsuario"] = null;
            Session["AdminBool"] = null;
            Response.Redirect("loginAlumno.aspx");
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            listaMaterias = negocio.ListarBusquedaMateria(txtBuscar.Text, student.docket);
            if (listaMaterias != null)
            {
                //si encuentra materias en la busqueda, borro la palabra del iput txtBuscar
                txtBuscar.Text = "";
            }
        }
    }
}