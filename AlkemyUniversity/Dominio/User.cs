﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class User
    {
        public int ID { get; set; }
        public bool admin { get; set; }

        public User()
        {
            ID = 0;
            admin = false;
        }

    }
}
