﻿using System;
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
        public int docket { set; get; }

        public Student()
        {
            user = new User();
            person = new Person();
        }
        public Student(string lastname, string names, int dni)
        {
            //para registrar un alumno
            user = new User();
            person = new Person();
            this.person.lastname = lastname;
            this.person.names = names;
            this.person.DNI = dni;
        }
        public Student(int docket, int DNI)
        {
            //para loguear
            user = new User();
            person = new Person();
            this.docket = docket;
            this.person.DNI = DNI;
        }

    }
}
