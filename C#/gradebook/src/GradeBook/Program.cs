using System;
using System.Collections.Generic;

namespace GradeBook
{
    class Program
    {
        static void Main(string[] args)
        {

            var book = new Book("Kamil's Grade Book");

            while(true)
            {
                Console.WriteLine("Please provide a grade, or enter q to quit.");
                var input = Console.ReadLine(); //prompt for grade (it will be a string)
                
                if (input == "q" )
                {
                    break;
                }
                
                try
                {
                    var grade = double.Parse(input);  //convert string to a number
                    book.AddGrade(grade);
                }
                catch(ArgumentException ex)
                {
                    Console.WriteLine(ex.Message);
                }
                catch(FormatException ex)
                {
                    Console.WriteLine(ex.Message);
                }
                finally
                {
                    System.Console.WriteLine("**");
                }
            }
            
            var stats = book.GetStatistics();

            System.Console.WriteLine($"The average grade is: {stats.Average:N1}");
            System.Console.WriteLine($"The maximum grade is: {stats.High}");
            System.Console.WriteLine($"The smallest grade is: {stats.Low}");
            System.Console.WriteLine($"The letter grade is: {stats.Letter}");

        }
    }


}
