function Update-Pass{
    $sql = "UPDATE aspnet_Membership 
            SET IsLockedOut = 0
            , IsApproved = 1
            , Password = 'HRnRWpAftHn6V+MWljtLDDJdNXQ='
            , PasswordSalt = '5FyxBJd7FpU1Elu0xjyVnw==' 
            WHERE UserId <> '80CA7CC1-C0A1-44A8-9DF9-912F52C7FE51'"
    
    Invoke-Sqlcmd -Database Cyberscope123 -Query $sql -Password P@ssword1 -Username CSAdmin  

}
Update-Pass
 