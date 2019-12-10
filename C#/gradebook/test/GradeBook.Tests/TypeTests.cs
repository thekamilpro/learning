using System;
using Xunit;

namespace GradeBook.Tests
{
    public class TypeTests
    {

        [Fact]
        public void ValueTypesAlsoPassByValue()
        {
        //Given
            var x = GetInt();
            SetInt(ref x);
        //When
        
        //Then
            Assert.Equal(42, x);
        }

        private void SetInt(ref int z)
        {
            z = 42;
            
           // return x;
        }

        private int GetInt()
        {
            return 3;
        }

        [Fact]
        public void CSharpCanPassByRef()
        {
            var book1 = GetBook("Book 1");
            GetBookSetName(out book1, "New name");

            //assert
            Assert.Equal("New name", book1.Name);     
        }

        private void GetBookSetName(out Book book, string name)
        {
            book = new Book(name);
        }

        [Fact]
        public void CSharpIsPassByValue()
        {
            var book1 = GetBook("Book 1");
            GetBookSetName(book1, "New name");

            //assert
            Assert.Equal("Book 1", book1.Name);     
        }

        private void GetBookSetName(Book book, string name)
        {
            book = new Book(name);
        }

         [Fact]
        public void CanSetNameFromReference()
        {
            var book1 = GetBook("Book 1");
            SetName(book1, "New name");

            //assert
            Assert.Equal("New name", book1.Name);     
        }

        private void SetName(Book book, string name)
        {
         //   book.Name = name;
        }

        [Fact]
        public void GetBookReturnsDifferentObjects()
        {
            var book1 = GetBook("Book 1");
            var book2 = GetBook("Book 2");

            //assert
            Assert.Equal("Book 1", book1.Name);
            Assert.Equal("Book 2", book2.Name);
            Assert.NotSame(book1, book2);
        }

        [Fact]
        public void TwoVarsCanReferenceSameObject()
        {
            var book1 = GetBook("Book 1");
            var book2 = book1;

            //assert
            Assert.Same(book1, book2);
            Assert.True(Object.ReferenceEquals(book1, book2));
            
        }

        Book GetBook(string name)
        {
            return new Book(name);
        }
    }
}
