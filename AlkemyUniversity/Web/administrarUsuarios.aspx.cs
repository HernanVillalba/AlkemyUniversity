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
    public partial class administrarUsuarios : System.Web.UI.Page
    {
        AdminNegocio negocio = new AdminNegocio();
        public List<Administrator> lista_admin = new List<Administrator>();
        public List<Student> lista_students = new List<Student>();
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarListas();
        }
        protected void CargarListas()
        {
            lista_admin = negocio.ListarAdministradores();
            lista_students = negocio.ListarEstudiantes();
        }
    }
}