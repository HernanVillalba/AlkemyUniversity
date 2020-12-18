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
        public string Day { get; set; }
        public SqlDateTime StartTime { get; set; }
        public SqlDateTime EndTime { get; set; }

        public Schedules()
        {

        }

    }
}
