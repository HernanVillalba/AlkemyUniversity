using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Teacher
    {
        public int ID { get; set; }
        public Person person { set; get; }
        public bool Active { get; set; }

        public Teacher()
        {

        }
    }
}
