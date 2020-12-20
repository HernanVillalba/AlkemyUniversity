using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class menuAdministrador : System.Web.UI.Page
    {
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

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session["AdminBool"] = null;
            Session["ID"] = null;
            Response.Redirect("loginAdministradorPagina.aspx");
        }
    }
}