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
    public partial class administrarMaterias : System.Web.UI.Page
    {
        AdminNegocio negocio;
        public List<Subject_info> lista = new List<Subject_info>();
        protected void Page_Load(object sender, EventArgs e)
        {
            Redireccionar();
            if (!IsPostBack)
            {
                negocio = new AdminNegocio();
                lista = negocio.ListarInfoMaterias();
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
            lista = negocio.ListarBusquedaMaterias(tbBuscar.Text);
            tbBuscar.Text = "";
        }
    }
}