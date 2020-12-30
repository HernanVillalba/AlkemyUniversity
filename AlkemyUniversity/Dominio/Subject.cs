using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Subject
    {
        public int ID { get; set; }
        public string name { get; set; }
        public int places_available { get; set; }
        public int maximum_capacity { get; set; }
        public Schedules schedules { get; set; }
        public DateTime enrollment_date { get; set; }

        public Subject()
        {
            schedules = new Schedules();
        }

    }
}
