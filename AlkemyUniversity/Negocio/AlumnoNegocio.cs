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
        ///////////////////////////////////////ALUMNO///////////////////////////////////////////
        private static string User_DS = "data source=.\\SQLEXPRESS; initial catalog=AlkemyUniversity; integrated security=true;";
        SqlConnection connection = new SqlConnection(User_DS);
        SqlCommand command;
        SqlDataReader reader;

        public List<Subject> ListarMisInscripciones(int student_docket)
        {
            command = new SqlCommand("SP_List_my_Enrollments", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@student_docket", student_docket);
            List<Subject> lista = new List<Subject>();
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Subject aux = new Subject();
                    aux.name = reader.GetString(0);
                    aux.enrollment_date = reader.GetDateTime(1);
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

        public List<Schedules> listarHorariosPorMateria(int subjectID)
        {
            SqlCommand command = new SqlCommand("SP_List_Schedules_by_ID", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("subject_id", subjectID);
            List<Schedules> lista = new List<Schedules>();

            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Schedules aux = new Schedules();
                    aux.ID = reader.GetInt32(0);
                    //la columna 1 sería el Subject_ID
                    aux.day = reader.GetString(2);
                    aux.start_time = reader.GetTimeSpan(3);
                    aux.end_time = reader.GetTimeSpan(4);
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

        public Subject_info BuscarMateriaPorID(int subject_id)
        {

            command = new SqlCommand("SP_Search_Subject_by_ID", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@subject_id", subject_id);
            Subject_info aux = new Subject_info();
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    aux.subject.ID = reader.GetInt32(0);
                    aux.subject.name = reader.GetString(1);
                    aux.subject.places_available = reader.GetInt32(2);
                    aux.subject.maximum_capacity = reader.GetInt32(3);
                    aux.teacher.ID = reader.GetInt32(4);
                    aux.teacher.lastname = reader.GetString(5);
                    aux.teacher.names = reader.GetString(6);
                    aux.subject.schedules.day = reader.GetString(7);
                    aux.subject.schedules.start_time = reader.GetTimeSpan(8);
                    aux.subject.schedules.end_time = reader.GetTimeSpan(9);
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

        public bool InscribirAlumnoAMateria(int subject_id, int student_docket)
        {
            bool guardo;
            int filas_afectadas = 0;
            command = new SqlCommand("SP_Enroll_in_a_Subject", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@subject_id", subject_id);
            command.Parameters.AddWithValue("@student_docket", student_docket);
            try
            {
                connection.Open();
                filas_afectadas = command.ExecuteNonQuery();
                connection.Close();
            }
            catch (SqlException)
            {
                filas_afectadas = 0;
            }

            if (filas_afectadas > 0) { guardo = true; }
            else { guardo = false; }
            return guardo;
        }

        public List<Subject> listarMateriasAlumno()
        {
            command = new SqlCommand("SELECT*FROM VW_List_Subjects_Student ORDER BY Subject_Name ASC", connection);
            List<Subject> lista = new List<Subject>();
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Subject aux = new Subject();
                    aux.ID = reader.GetInt32(0);
                    aux.name = reader.GetString(1);
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
