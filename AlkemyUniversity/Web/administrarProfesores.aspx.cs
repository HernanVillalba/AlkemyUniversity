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
    public partial class administrarProfesores : System.Web.UI.Page
    {
        AdminNegocio negocio;
        public List<Teacher> listaTeachers = new List<Teacher>();
        protected void Page_Load(object sender, EventArgs e)
        {
            Redireccionar();

            if (!IsPostBack)
            {
                negocio = new AdminNegocio();
                listaTeachers = negocio.ListarProfesores();
            }

        }

        protected void Redireccionar()
        {
            if (Session["AdminBool"] == null || !(bool)Session["AdminBool"])
            {
                Response.Redirect("loginAdministradorPagina.aspx");
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            negocio = new AdminNegocio();
            listaTeachers = negocio.ListarBusquedaProfesores(tbBuscar.Text);
            tbBuscar.Text = "";
        }

    }
}