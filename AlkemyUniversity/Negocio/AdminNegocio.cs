using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Sql;
using System.Data.SqlClient;
using Dominio;

namespace Negocio
{
    public class AdminNegocio
    {
        private string DS_User = "data source=.\\SQLEXPRESS; initial catalog=AlkemyUniversity; integrated security=true;";
        SqlConnection connection;
        SqlCommand command;
        SqlDataReader reader;

        public bool ActualizarProfesor(Teacher teacher)
        {
            connection = new SqlConnection(DS_User);
            command = new SqlCommand("SP_Update_Teacher", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@teacher_id", teacher.ID);
            command.Parameters.AddWithValue("@lastname", teacher.lastname);
            command.Parameters.AddWithValue("@names", teacher.names);
            command.Parameters.AddWithValue("@dni", teacher.DNI);
            command.Parameters.AddWithValue("@active", teacher.active);
            try
            {
                connection.Open();
                command.ExecuteReader();
                connection.Close();
            }
            catch (SqlException)
            {
                return false;
            }

            return true;
        }

        public Teacher BuscarProfesorPorID(int ID)
        {
            connection = new SqlConnection(DS_User);
            command = new SqlCommand("SP_Search_Teacher_by_ID", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@id", ID);
            Teacher aux = new Teacher();
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    aux.ID = reader.GetInt32(0);
                    aux.lastname = reader.GetString(1);
                    aux.names = reader.GetString(2);
                    aux.DNI = reader.GetInt32(3);
                    aux.active = reader.GetBoolean(4);
                }
                connection.Close();
            }
            catch (Exception)
            {
                aux = null;
                throw;
            }
            return aux;
        }
        public List<Teacher> ListarBusquedaProfesores(string keyword)
        {
            connection = new SqlConnection(DS_User);
            command = new SqlCommand("SP_Teachers_Search", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@keyword", keyword);
            List<Teacher> lista = new List<Teacher>();
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Teacher aux = new Teacher();
                    aux.ID = reader.GetInt32(0);
                    aux.lastname = reader.GetString(1);
                    aux.names = reader.GetString(2);
                    aux.DNI = reader.GetInt32(3);
                    aux.active = reader.GetBoolean(4);
                    aux.number_subjects = reader.GetInt32(5);
                    lista.Add(aux);
                }

                connection.Close();
            }
            catch (Exception)
            {
                lista = null;
            }
            return lista;
        }

        public List<Teacher> ListarProfesores()
        {
            //vista
            connection = new SqlConnection(DS_User);
            command = new SqlCommand("select*from VW_List_Teachers order by Lastname asc, Names asc", connection); //vista
            List<Teacher> lista = new List<Teacher>();
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Teacher aux = new Teacher();
                    aux.ID = reader.GetInt32(0);
                    aux.lastname = reader.GetString(1);
                    aux.names = reader.GetString(2);
                    aux.DNI = reader.GetInt32(3);
                    aux.active = reader.GetBoolean(4);
                    aux.number_subjects = reader.GetInt32(5);
                    lista.Add(aux);
                }

                connection.Close();
            }
            catch (Exception)
            {
                lista = null;
                throw;
            }
            return lista;

        }

        public List<Subject_info> ListarBusquedaMaterias(string keyword)
        {
            connection = new SqlConnection(DS_User);
            command = new SqlCommand("SP_Subject_Search", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@keyword", keyword);
            List<Subject_info> lista = new List<Subject_info>();
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Subject_info aux = new Subject_info();
                    aux.subject.ID = reader.GetInt32(0);
                    aux.subject.name = reader.GetString(1);
                    aux.subject.places_available = reader.GetInt32(2);
                    aux.subject.maximum_capacity = reader.GetInt32(3);
                    aux.teacher.ID = reader.GetInt32(4);
                    aux.teacher.lastname = reader.GetString(5);
                    aux.teacher.names = reader.GetString(6);
                    aux.subject.schedules.day = reader.GetString(7);
                    aux.subject.schedules.start_time = reader.GetString(8);
                    aux.subject.schedules.end_time = reader.GetString(9);
                    lista.Add(aux);
                }
                connection.Close();
            }
            catch (Exception)
            {
                lista = null;
                throw;
            }
            return lista;
        }
        public List<Subject_info> ListarInfoMaterias()
        {
            connection = new SqlConnection(DS_User);
            command = new SqlCommand("select*from VW_Subject_Info AS VW order by VW.Subject_Name", connection);
            List<Subject_info> lista = new List<Subject_info>();
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Subject_info aux = new Subject_info();
                    aux.subject.ID = reader.GetInt32(0);
                    aux.subject.name = reader.GetString(1);
                    aux.subject.places_available = reader.GetInt32(2);
                    aux.subject.maximum_capacity = reader.GetInt32(3);
                    aux.teacher.ID = reader.GetInt32(4);
                    aux.teacher.lastname = reader.GetString(5);
                    aux.teacher.names = reader.GetString(6);
                    aux.subject.schedules.day = reader.GetString(7);
                    aux.subject.schedules.start_time = reader.GetString(8);
                    aux.subject.schedules.end_time = reader.GetString(9);
                    lista.Add(aux);
                }
                connection.Close();
            }
            catch (Exception)
            {
                lista = null;
                throw;
            }
            return lista;
        }

        public bool AgregarNuevaMateria(Subject subject, int Teacher_ID)
        {
            bool guardo;
            connection = new SqlConnection(DS_User);
            command = new SqlCommand("SP_New_Subject", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@subject_name", subject.name);
            command.Parameters.AddWithValue("@maximum_capacity", subject.maximum_capacity);
            command.Parameters.AddWithValue("@day", subject.schedules.day);
            command.Parameters.AddWithValue("@start_time", subject.schedules.start_time);
            command.Parameters.AddWithValue("@end_time",subject.schedules.end_time);
            command.Parameters.AddWithValue("@teacher_id", Teacher_ID);
            try
            {
                connection.Open();
                command.ExecuteReader();
                connection.Close();
                guardo = true;
            }
            catch (SqlException)
            {
                guardo = false;
            }
            return guardo;
        }
        
        public List<Teacher> ListarProfesoresActivos()
        {
            connection = new SqlConnection(DS_User);
            command = new SqlCommand("SELECT*FROM VW_Ative_Teachers", connection);
            List<Teacher> lista = new List<Teacher>();
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Teacher aux = new Teacher();
                    aux.ID = reader.GetInt32(0);
                    aux.lastname = reader.GetString(1);
                    aux.names = reader.GetString(2);
                    aux.DNI = reader.GetInt32(3);
                    aux.active = reader.GetBoolean(4);
                    aux.fullname = reader.GetString(5);
                    lista.Add(aux);
                }
                connection.Close();
            }
            catch (Exception)
            {

                lista = null;
            }

            return lista;
        }

        public Administrator Login(Administrator admin)
        {
            //configuro la conexion y el comando.
            connection = new SqlConnection(DS_User);
            command = new SqlCommand("SP_Login_Admin", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure; //procedimiento almacenado
            command.Parameters.AddWithValue("@id", admin.ID);
            command.Parameters.AddWithValue("@password", admin.password);
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    //si lee, quiere decir que los datos son correctos.
                    //los guardo para usarlos en variables Session para restringir el acceso a las páginas.
                    admin.ID = reader.GetInt32(0);
                    admin.user.admin = reader.GetBoolean(1);
                    admin.password = "";
                }
                else
                {
                    //si no leyó quiere decir que los datos ingresados en login del admin son incorrectos.
                    //entonces asigno estos valores para usarlos en variables Session para restringir el acceso a las páginas.
                    admin.ID = 0;
                    admin.user.admin = false;
                }
            }
            catch (Exception)
            {
                admin.ID = 0;
                admin.user.admin = false;
            }
            return admin;
        }

        public bool AgregarNuevoProfesor(Teacher teacher)
        {
            connection = new SqlConnection(DS_User);
            command = new SqlCommand("SP_New_Teacher", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@dni", teacher.DNI);
            command.Parameters.AddWithValue("@lastName", teacher.lastname);
            command.Parameters.AddWithValue("@names", teacher.names);
            command.Parameters.AddWithValue("@active", teacher.active);

            try
            {
                connection.Open();
                command.ExecuteReader();
                connection.Close();
            }
            catch (SqlException)
            {
                connection.Close();
                return false;
            }

            return true;
        }
    }
}
