using System;
using System.Collections.Generic;

namespace GradeBook
{

 
    class Program
    {
        static void Main(string[] args)
        {

            var book = new Book("Kamil's Grade Book");
            book.AddGrade(89.1);
            book.AddGrade(90.1);
            book.AddGrade(77.5);
            book.AddGrade(105);
            
            var stats = book.GetStatistics();
            
            System.Console.WriteLine($"The average grade is: {stats.Average:N1}");
            System.Console.WriteLine($"The maximum grade is: {stats.High}");
            System.Console.WriteLine($"The smallest grade is: {stats.Low}");

        }
    }

   
}
