using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;

namespace Web
{
    public partial class alumno_verMisInscripciones : System.Web.UI.Page
    {
        AlumnoNegocio negocio = new AlumnoNegocio();
        public Student student = new Student();
        public List<Subject> lista_subjects = new List<Subject>();
        protected void Page_Load(object sender, EventArgs e)
        {
            Redireccionar();
            CargarVariables();
        }

        protected void Redireccionar()
        {
            if (Session["ObjetoUsuario"] == null || Session["AdminBool"] == null)
            {
                Response.Redirect("loginAlumno.aspx");
            }
            if ((bool)Session["AdminBool"])
            {
                Response.Redirect("loginAdministradorPagina.aspx");
            }
        }


        protected void CargarVariables()
        {
            if (Session["ObjetoUsuario"] != null)
            {
                student = (Student)Session["ObjetoUsuario"];
                lista_subjects = negocio.ListarMisInscripciones(student.docket);
            }
        }
    }
}