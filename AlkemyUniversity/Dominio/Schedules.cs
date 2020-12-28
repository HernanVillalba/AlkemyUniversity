using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Sql;
using System.Data.SqlTypes;
using System.Data.SqlClient;

namespace Dominio
{
    public class Schedules
    {
        public string day { get; set; }
        public string start_time { get; set; }
        public string end_time { get; set; }

        public Schedules()
        {

        }

    }
}
