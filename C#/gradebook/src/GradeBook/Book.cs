using System;
using System.Collections.Generic;

namespace GradeBook
{
    public class Book
        {

            public Book(string name)
            {
                grades = new List<double>();
                this.name = name;
            }

            public void AddGrade(double grade)
            {
                grades.Add(grade);
            }

        public void ShowStatics()
        {

             var result = 0.0;
            var highGrade = double.MinValue;
            var lowGrade = double.MaxValue;
            
            foreach (var number in grades)
            {
               highGrade = Math.Max(number, highGrade);
               lowGrade = Math.Min(number, lowGrade);
                result += number;
            }
             result /=  grades.Count;

            System.Console.WriteLine($"The average grade is: {result}");
            System.Console.WriteLine($"The maximum grade is: {highGrade}");
            System.Console.WriteLine($"The smallest grade is: {lowGrade}");

        }

        private List<double> grades;
            private string name;
        }

}