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

        public Administrator Login(Administrator admin)
        {
            //configuro la conexion y el comando.
            connection = new SqlConnection(DS_User);
            command = new SqlCommand("SP_LoginAdmin", connection);
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
    }
}
