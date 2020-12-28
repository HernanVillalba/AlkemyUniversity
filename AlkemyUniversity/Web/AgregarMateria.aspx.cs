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
    public partial class AgregarMateria : System.Web.UI.Page
    {
        protected AdminNegocio negocio;
        protected List<Teacher> lista = new List<Teacher>();
        public TimeSpan hora = new TimeSpan();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarFront();
            }

        }
        protected void cargarFront()
        {
            negocio = new AdminNegocio();
            lista = negocio.ListarProfesoresActivos();
            if (lista != null)
            {
                ddlProfesores.AppendDataBoundItems = true;
                ddlProfesores.DataSource = lista;
                ddlProfesores.DataValueField = "ID";
                ddlProfesores.DataTextField = "FullName";
                ddlProfesores.DataBind();
            }

        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            negocio = new AdminNegocio();

            Subject sub = new Subject();
            sub.name = txtNombre.Text;
            sub.maximum_capacity = Convert.ToInt32(txtCapacidadMax.Text);
            sub.schedules.day = ddlDias.SelectedItem.ToString();
            sub.schedules.start_time = txtHsComienzo.Text + ":" + txtMinComienzo.Text;
            sub.schedules.end_time = txtHsFinal.Text + ":" + txtMinFinal.Text;
            int TeacherID = Convert.ToInt32(ddlProfesores.SelectedValue);
            int diaID = Convert.ToInt32(ddlDias.SelectedValue);

            if (sub != null && TeacherID > 0 && diaID > 0)
            {
                if (!negocio.AgregarNuevaMateria(sub, TeacherID)) //si no guardó en la DB...
                {
                    Session["ErrorMessage"] = true;
                }
                else
                {
                    Session["ErrorMessage"] = false;
                    //si no hay error, vacio los txt
                    txtNombre.Text = "";
                    txtCapacidadMax.Text = "";
                    txtHsComienzo.Text = "";
                    txtMinComienzo.Text = "";
                    txtHsFinal.Text = "";
                    txtMinFinal.Text = "";
                    txtMinFinal.Text = "";
                }
            }
        }




    }
}