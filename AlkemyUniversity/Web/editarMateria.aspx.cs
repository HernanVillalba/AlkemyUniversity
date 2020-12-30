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
    public partial class editarMateria : System.Web.UI.Page
    {
        AdminNegocio negocio = new AdminNegocio();
        Subject_info sub_info = new Subject_info();
        List<Schedules> listaSchedules = new List<Schedules>();
        public int SubjectID = 0;
        public int TeacherID = 0;
        public int deleteTeacher = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Redireccionar();

            CargarVariables();
            
            if (!IsPostBack)
            {
                if (SubjectID > 0)
                {
                    CargarMateriaEnTxt();
                }
                else
                {
                    Response.Redirect("administrarMaterias.aspx");
                }
                if (deleteTeacher == 1)
                {
                    EliminarProfesor();
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

        protected void EliminarProfesor()
        {
            negocio.EliminarProfesorDeLaAsignatura(SubjectID, TeacherID);
            Response.Redirect("editarMateria.aspx?ID=" + SubjectID);
        }

        protected void CargarVariables()
        {
            SubjectID = Convert.ToInt32(Request.QueryString["ID"]);
            TeacherID = Convert.ToInt32(Session["OldTeacherID"]);
            deleteTeacher = Convert.ToInt32(Request.QueryString["deleteTeacher"]);
        }

        protected void CargarMateriaEnTxt()
        {
            
            sub_info = negocio.BuscarMateriaPorID(SubjectID);
            if (sub_info != null)
            {
                txtNombre.Text = sub_info.subject.name;
                txtCapacidadMax.Text = sub_info.subject.maximum_capacity.ToString();
                txtProfesor.Text = sub_info.teacher.lastname + " " + sub_info.teacher.names;
                Session["OldTeacherID"] = sub_info.teacher.ID; //guardo el viejo ID del profesor
                listaSchedules = negocio.listarHorariosPorMateria(SubjectID);
                if (listaSchedules != null)
                {
                    cargarTxtHorarios();
                }
            }
        }

        protected void cargarTxtHorarios()
        {
            int cantidadItems = listaSchedules.Count();
            int vueltas = 0;
            lblHorarios.Text = "";
            foreach (var item in listaSchedules)
            {
                lblHorarios.Text += item.day + " " + item.start_time + "-" + item.end_time;
                if (vueltas < cantidadItems - 1)
                {
                    lblHorarios.Text += "<br />";
                    lblHorarios.Text += "<hr />";
                }
                vueltas++;
            }
        }

        protected void btnEditarTeacher_Click(object sender, EventArgs e)
        {
            Session["PrecionoBotonEditarProfesor"] = true; //bamdera para cuando preciona el boton de editar profesor.
            ddlProfesoresActivos.Visible = true;
            ddlProfesoresActivos.DataSource = negocio.ListarProfesoresActivos();
            ddlProfesoresActivos.DataValueField = "ID";
            ddlProfesoresActivos.DataTextField = "Fullname";
            ddlProfesoresActivos.DataBind();
            txtProfesor.Visible = false;
            btnEditarTeacher.Visible = false;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Subject aux = new Subject();
            int oldTeacherID = Convert.ToInt32(Session["OldTeacherID"]);
            int newTeacherID;
            if (Session["PrecionoBotonEditarProfesor"] != null && (bool)Session["PrecionoBotonEditarProfesor"])
            {
                //si lo precionó, quiere decir que hay que guardar el nuevo id del profesor.
                newTeacherID = Convert.ToInt32(ddlProfesoresActivos.SelectedValue);
            }
            else
            {
                //si no lo precionó, guardo el viejo como nuevo ya que el SP me pide el parámetro.
                newTeacherID = Convert.ToInt32(Session["OldTeacherID"]);
            }
            aux.ID = SubjectID;
            aux.name = txtNombre.Text;
            aux.maximum_capacity = Convert.ToInt32(txtCapacidadMax.Text);

            if(negocio.ActualizarDatosMateria(aux, oldTeacherID, newTeacherID))
            {
                Session["ErrorMessageEditarMateria"] = false;
            }
            else
            {
                Session["ErrorMessageEditarMateria"] = true;
            }

        }



    }
}