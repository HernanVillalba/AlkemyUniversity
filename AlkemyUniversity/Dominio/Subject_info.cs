using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Subject_info
    {
        //no le agrego los horarios porque ya los tiene dentro de subject
        public Subject subject { get; set; } 
        public Teacher teacher { get; set; }

        public Subject_info()
        {
            subject = new Subject();
            teacher = new Teacher();
        }
    }
}
