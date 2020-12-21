using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Sql;
using System.Data.SqlClient;

namespace Negocio
{
    public class MateriaNegocio
    {
        string DS_User = "data source=.\\SQLEXPRESS; initial catalog=AlkemyUniversity; integrated security=true;";
        //               "data source=.\\SQLEXPRESS; initial catalog=AlkemyUniversity; integrated security=true;";
        SqlConnection connection;
        SqlCommand command;
        SqlDataReader reader;



    }
}
