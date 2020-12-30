﻿using System;
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
        int subjectID;
        int enroll;
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarVariables();
            if(subjectID>0 && enroll == 1)
            {
                IncrirseAMateria();
            }
        }
        protected void IncrirseAMateria()
        {

        }

        protected void CargarVariables()
        {
            listaMaterias = negocio.listarMateriasAlumno();
            subjectID = Convert.ToInt32(Request.QueryString["subjectID"]);
            enroll = Convert.ToInt32(Request.QueryString["enroll"]);
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session["ObjetoUsuario"] = null;
            Session["AdminBool"] = null;
            Response.Redirect("loginAlumno.aspx");
        }
    }
}