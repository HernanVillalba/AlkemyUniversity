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
        public bool active { get; set; }

        public Teacher()
        {

        }
        public Teacher(int DNI, string lastName, string names, bool active)
        {
            person = new Person();
            this.person.DNI = DNI;
            this.person.Lastname = lastName;
            this.person.Names = names;
            this.active = active;
        }
    }
}
