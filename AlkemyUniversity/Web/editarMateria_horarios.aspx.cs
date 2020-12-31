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
    public partial class editarMateria_horarios : System.Web.UI.Page
    {
        public int SubjectID = 0;
        protected int delete;
        protected int ScheduleID;
        protected AdminNegocio negocio = new AdminNegocio();
        public List<Schedules> lista = new List<Schedules>();
        protected void Page_Load(object sender, EventArgs e)
        {
            Redireccionar();

            CargarVariables();

            if (!IsPostBack)
            {
                if (SubjectID > 0)
                {
                    lista = negocio.listarHorariosPorMateria(SubjectID);
                }
                if (delete == 1)
                {
                    EliminarHorario();
                }
            }
        }

        protected void Redireccionar()
        {
            if (Session["AdminBool"] == null || !(bool)Session["AdminBool"])
            {
                Response.Redirect("loginAdministradorPagina.aspx");
            }
        }

        protected void CargarVariables()
        {
            SubjectID = Convert.ToInt32(Request.QueryString["ID"]);
            ScheduleID = Convert.ToInt32(Request.QueryString["ScheduleID"]);
            delete = Convert.ToInt32(Request.QueryString["Delete"]);
        }

        protected void EliminarHorario()
        {
            negocio.EliminarHorario(ScheduleID);
            Response.Redirect("editarMateria_horarios.aspx?ID=" + SubjectID);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if(ddlDias.SelectedValue == "0")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Debe seleccionar el día.')", true);
                Response.Redirect("editarMateria_horarios.aspx?ID=" + SubjectID);
            }
            Schedules schedules = new Schedules();
            schedules.day = ddlDias.SelectedItem.ToString();
            schedules.start_time = TimeSpan.Parse(txtComienzo.Text);
            schedules.end_time = TimeSpan.Parse(txtFinalizacion.Text);
            if (Convert.ToInt32(ddlDias.SelectedValue) > 0)
            {
                if (negocio.GuardarHorarioMateria(schedules, SubjectID)) //devuelve true si guardo
                {
                    Session["ErrorMessageHorarios"] = false;
                }
                else
                {
                    Session["ErrorMessageHorarios"] = true;
                }

                Response.Redirect("editarMateria_horarios.aspx?ID=" + SubjectID);
            }
        }
    }
}