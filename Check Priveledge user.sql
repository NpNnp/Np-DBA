


SELECT sp.name Server_Role, sp2.name Login_Name
FROM sys.server_role_members srm
JOIN sys.server_principals sp on sp.principal_id=srm.role_principal_id
JOIN sys.server_principals sp2 on sp2.principal_id=srm.member_principal_id
where sp2.name='biadmin'