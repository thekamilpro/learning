$conn_string =
 "Server=localhost\SQLEXPRESS;Database=master;Trusted_Connection=True;"  

$conn = New-Object System.Data.SqlClient.SqlConnection                     
$conn.ConnectionString = $conn_string                                      
$conn.Open()

$sql = @"                                                                  
CREATE DATABASE Scripting;
"@

$cmd = New-Object System.Data.SqlClient.SqlCommand                         
$cmd.CommandText = $sql                                                    
$cmd.Connection = $conn                                                    
$cmd.ExecuteNonQuery()                                                    
$conn.close()                                                              