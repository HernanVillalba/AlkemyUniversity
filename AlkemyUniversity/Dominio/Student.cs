using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Student
    {
        public User user { set; get; }
        public Person person { set; get; }
        public int Docket { set; get; }

        public Student()
        {
            user = new User();
            person = new Person();
        }

    }
}
