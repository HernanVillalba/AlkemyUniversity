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
        private static string DS_User = "data source=.\\SQLEXPRESS; initial catalog=AlkemyUniversity; integrated security=true;";
        SqlConnection connection = new SqlConnection(DS_User);
        SqlCommand command;
        SqlDataReader reader;

        public bool RegistrarAlumno(Student student)
        {
            bool guardo;
            command = new SqlCommand("SP_Register_Student", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@dni", student.person.DNI);
            command.Parameters.AddWithValue("@lastname", student.person.lastname);
            command.Parameters.AddWithValue("@names", student.person.names);
            try
            {
                connection.Open();
                command.ExecuteReader();
                connection.Close();
                guardo = true;
            }
            catch (Exception)
            {
                guardo = false;
            }
            return guardo;
        }

        public bool RegistrarAdministrador(Administrator admin)
        {
            bool guardo;
            command = new SqlCommand("SP_Register_Admin", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@password", admin.password);
            command.Parameters.AddWithValue("@lastname", admin.person.lastname);
            command.Parameters.AddWithValue("@names", admin.person.names);
            command.Parameters.AddWithValue("@dni", admin.person.DNI);
            try
            {
                connection.Open();
                command.ExecuteReader();
                connection.Close();
                guardo = true;
            }
            catch (Exception)
            {
                guardo = false;
            }
            return guardo;
        }

        public List<Student> ListarEstudiantes()
        {
            command = new SqlCommand("SP_List_Ordered_Student", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            List<Student> lista = new List<Student>();
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Student aux = new Student();
                    aux.user.ID = reader.GetInt32(0);
                    aux.Docket = reader.GetInt32(1);
                    aux.person.lastname = reader.GetString(2);
                    aux.person.names = reader.GetString(3);
                    aux.person.DNI = reader.GetInt32(4);
                    aux.user.admin = reader.GetBoolean(5);
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

        public List<Administrator> ListarAdministradores()
        {
            command = new SqlCommand("SP_List_Ordered_Admin", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            List<Administrator> lista = new List<Administrator>();
            try
            {
                connection.Open();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Administrator aux = new Administrator();
                    aux.user.ID = aux.ID = reader.GetInt32(0);
                    aux.person.lastname = reader.GetString(1);
                    aux.person.names = reader.GetString(2);
                    aux.person.DNI = reader.GetInt32(3);
                    aux.user.admin = reader.GetBoolean(4);
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

        public bool EliminarProfesorDeLaAsignatura(int subject_id, int teacher_id)
        {
            bool elimino;
            command = new SqlCommand("SP_Delete_Teacher_From_Subject", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@subject_id", subject_id);
            command.Parameters.AddWithValue("@teacher_id", teacher_id);
            try
            {
                connection.Open();
                command.ExecuteReader();
                connection.Close();
                elimino = true;
            }
            catch (Exception)
            {
                elimino = false;
            }
            return elimino;
        }

        public bool EliminarHorario(int schedule_id)
        {
            bool elimino;
            command = new SqlCommand("SP_Delete_Schedule", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@schedule_id", schedule_id);
            try
            {
                connection.Open();
                command.ExecuteReader();
                connection.Close();
                elimino = true;
            }
            catch (Exception)
            {
                elimino = false;
            }
            return elimino;
        }

        public bool ActualizarDatosMateria(Subject subject, int oldTeacherID, int newTeacherID)
        {
            bool guardo;
            command = new SqlCommand("SP_Update_Subject", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@subject_id", subject.ID);
            command.Parameters.AddWithValue("@subject_name", subject.name);
            command.Parameters.AddWithValue("@maximum_capacity", subject.maximum_capacity);
            command.Parameters.AddWithValue("@old_teacher_id", oldTeacherID);
            command.Parameters.AddWithValue("@new_teacher_id", newTeacherID);

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

        public bool GuardarHorarioMateria(Schedules schedules, int SubjectID)
        {
            bool guardo;
            command = new SqlCommand("SP_Save_Schedule", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@subject_id", SubjectID);
            command.Parameters.AddWithValue("@day", schedules.day);
            command.Parameters.AddWithValue("@start_time", schedules.start_time);
            command.Parameters.AddWithValue("@end_time", schedules.end_time);
            try
            {
                connection.Open();
                command.ExecuteReader();
                connection.Close();
                guardo = true;
            }
            catch (Exception)
            {
                guardo = false;
            }
            return guardo;
        }

        public Subject_info BuscarMateriaPorID(int MateriaID)
        {

            command = new SqlCommand("SP_Search_Subject_by_ID", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@subject_id", MateriaID);
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

        public bool ActualizarProfesor(Teacher teacher)
        {
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
                    aux.subject.schedules.start_time = reader.GetTimeSpan(8);
                    aux.subject.schedules.end_time = reader.GetTimeSpan(9);
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

        public List<Schedules> listarHorariosPorMateria(int subjectID)
        {
            //creo nuevos objetos para que no haya errores
            //al recorrer las listas de horarios por materia
            SqlConnection connection1 = new SqlConnection(DS_User);
            SqlCommand command1 = new SqlCommand("SP_List_Schedules_by_ID", connection1);
            command1.CommandType = System.Data.CommandType.StoredProcedure;
            command1.Parameters.AddWithValue("subject_id", subjectID);
            SqlDataReader reader1;
            List<Schedules> lista = new List<Schedules>();

            try
            {
                connection1.Open();
                reader1 = command1.ExecuteReader();
                while (reader1.Read())
                {
                    Schedules aux = new Schedules();
                    aux.ID = reader1.GetInt32(0);
                    //la columna 1 sería el Subject_ID
                    aux.day = reader1.GetString(2);
                    aux.start_time = reader1.GetTimeSpan(3);
                    aux.end_time = reader1.GetTimeSpan(4);
                    lista.Add(aux);
                }
                connection1.Close();

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
            //para recorrer la tabla de materias
            string query = "SELECT*FROM VW_Subject_Info ORDER BY Subject_Name ASC, Day ASC, Start_Time ASC, End_Time ASC";
            command = new SqlCommand(query, connection);
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
                    aux.subject.schedules.start_time = reader.GetTimeSpan(8);
                    aux.subject.schedules.end_time = reader.GetTimeSpan(9);
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
            command = new SqlCommand("SP_New_Subject", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@subject_name", subject.name);
            command.Parameters.AddWithValue("@maximum_capacity", subject.maximum_capacity);
            command.Parameters.AddWithValue("@day", subject.schedules.day);
            command.Parameters.AddWithValue("@start_time", subject.schedules.start_time);
            command.Parameters.AddWithValue("@end_time", subject.schedules.end_time);
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
