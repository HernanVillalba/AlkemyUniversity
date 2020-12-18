using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Dominio
{
    public class Administrator
    {
        public int ID { get; set; }
        public string password { get; set; }
        public User user { get; set; }
        public Person person { get; set; }

        public Administrator()
        {
            user = new User();
            person = new Person();
        }
    }
}
