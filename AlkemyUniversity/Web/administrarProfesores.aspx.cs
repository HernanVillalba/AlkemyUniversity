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
            negocio = new AdminNegocio();
            listaTeachers = negocio.ListarProfesores();
        }
    }
}