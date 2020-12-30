using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Dominio;


namespace Negocio
{
    public class AlumnoNegocio
    {
        private static string User_DS = "data source=.\\SQLEXPRESS; initial catalog=AlkemyUniversity; integrated security=true;";
      //private static string DS_User = "data source=.\\SQLEXPRESS; initial catalog=AlkemyUniversity; integrated security=true;";
        SqlConnection connection = new SqlConnection(User_DS);
        SqlCommand command;
        SqlDataReader reader;
        ///////////////////////////////////////ALUMNO///////////////////////////////////////////
        public Student LoginEstudiante(Student student)
        {
            command = new SqlCommand("SP_Login_Student", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@docket", student.docket);
            command.Parameters.AddWithValue("@dni", student.person.DNI);

            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    student.user.ID = reader.GetInt32(0);
                    student.docket = reader.GetInt32(1);
                    student.person.lastname = reader.GetString(2);
                    student.person.names = reader.GetString(3);
                    student.person.DNI = reader.GetInt32(4);
                    student.user.admin = reader.GetBoolean(5);
                }
                connection.Close();
            }
            catch (Exception)
            {
                student = null;
            }
            return student;
        }
    }
}
