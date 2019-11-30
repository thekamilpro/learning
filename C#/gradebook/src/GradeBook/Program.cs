using System;
using System.Collections.Generic;

namespace GradeBook
{
    class Program
    {
        static void Main(string[] args)
        {

            var grades = new List<double>() {34.1, 35, 1.2};
            grades.Add(56);
        
            var result = 0.0;
            foreach (var number in grades)
            {
                result += number;
            }
             result /=  grades.Count;

            System.Console.WriteLine($"The average grade is: {result}");

            if(args.Length > 0)
            {
            Console.WriteLine($"Hello, {args[0]} !");
            }
            else
            {
                Console.WriteLine("Hello!");
            }
        }
    }
}
