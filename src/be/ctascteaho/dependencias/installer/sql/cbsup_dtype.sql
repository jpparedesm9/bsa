USE cob_conta_super
GO

if not exists (select * from systypes where name = 'sexo')
   CREATE TYPE sexo FROM char(1) NULL

if not exists (select * from systypes where name = 'numero')
   CREATE TYPE numero FROM varchar(13) NULL

if not exists (select * from systypes where name = 'mensaje')
   CREATE TYPE mensaje FROM varchar(240) NULL

if not exists (select * from systypes where name = 'login')
   CREATE TYPE login FROM varchar(14) NULL

if not exists (select * from systypes where name = 'estado')
    CREATE TYPE estado FROM char(1) NULL

if not exists (select * from systypes where name = 'direccion')
    CREATE TYPE direccion FROM varchar(120) NULL

if not exists (select * from systypes where name = 'descripcion')
    CREATE TYPE descripcion FROM varchar(64) NULL

if not exists (select * from systypes where name = 'cuenta')
   CREATE TYPE cuenta FROM varchar(24) NULL

if not exists (select * from systypes where name = 'catalogo')
   CREATE TYPE catalogo FROM varchar(10) NULL
GO
