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
    public partial class loginAlumno2 : System.Web.UI.Page
    {
        AlumnoNegocio negocio = new AlumnoNegocio();
        protected void Page_Load(object sender, EventArgs e)
        {
            Redireccionar();
            //btnIngresar.Attributes("OnClick", "javascript: return validar();");
        }

        protected void Redireccionar()
        {
            if (Session["ID"] != null)
            {
                if (Session["AdminBool"] != null && (bool)Session["AdminBool"])
                {
                    Response.Redirect("menuAdministrador.aspx");
                }
                if (Session["AdminBool"] != null && !(bool)Session["AdminBool"])
                {
                    Response.Redirect("menuAlumno.aspx");
                }
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            Student student = new Student(Convert.ToInt32(txtLegajo.Text), Convert.ToInt32(txtDNI.Text));
            student = negocio.LoginEstudiante(student);

            if (student != null)
            {
                Session["ID"] = student.docket;
                Session["ObjetoUsuario"] = student;
                Session["AdminBool"] = false;
                Response.Redirect("menuAlumno.aspx");
            }
            else
            {
                Session["ErrorMessageLoginAlumno"] = true;
            }

        }
    }
}