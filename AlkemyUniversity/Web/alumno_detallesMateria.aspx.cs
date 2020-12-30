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
    public partial class alumno_detallesMateria : System.Web.UI.Page
    {
        AlumnoNegocio negocio = new AlumnoNegocio();
        public int subject_id;
        public Subject_info subject_info = new Subject_info();
        public List<Schedules> lista_schedules = new List<Schedules>();
        string schedules_by_subject;
        protected void Page_Load(object sender, EventArgs e)
        {
            Redireccionar();
            subject_id = Convert.ToInt32(Request.QueryString["subjectID"]);
            if (subject_id > 0)
            {
                ListarMateriasYHorarios();
            }
            else
            {
                Response.Redirect("menuAlumno.aspx");
            }
        }
        protected void Redireccionar()
        {
            if (Session["ObjetoUsuario"] != null || Session["AdminBool"] == null)
            {
                Response.Redirect("loginAlumno.aspx");
            }
            if ((bool)Session["AdminBool"])
            {
                Response.Redirect("loginAdministradorPagina.aspx");
            }
        }

        protected void ListarMateriasYHorarios()
        {
            subject_info = negocio.BuscarMateriaPorID(subject_id);
            lista_schedules = negocio.listarHorariosPorMateria(subject_id);
            if (lista_schedules != null)
            {
                foreach (var item in lista_schedules)
                {
                    lblHorarios.Text += item.day + " " + item.start_time + " : " + item.end_time + "<br/>";
                }
            }
        }
    }
}