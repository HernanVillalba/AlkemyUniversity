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
            command = new SqlCommand("SELECT*FROM VW_Teachers_Activos", connection);
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
