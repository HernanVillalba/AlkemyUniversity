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
        public int DNI { get; set; }
        public string lastname { get; set; }
        public string names { get; set; }
        public bool active { get; set; }
        public string fullname { get; set; } //para llenar el drop de agregar materia.

        public Teacher()
        {

        }
        public Teacher(int DNI, string lastName, string names, bool active)
        {
            this.DNI = DNI;
            this.lastname = lastName;
            this.names = names;
            this.active = active;
        }
    }
}
