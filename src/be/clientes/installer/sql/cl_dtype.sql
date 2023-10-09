/* Script de eliminacion de tipos de datos CLIENTE */

use cobis
go

/* url */
print '=====> url'
go
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'url' AND ss.name = N'dbo')
    CREATE TYPE url FROM varchar(255) NULL
go

/* sexo */
print ' =====> sexo'
go
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'sexo' AND ss.name = N'dbo')
    CREATE TYPE sexo FROM char(1) NULL
go

/* numero */
print ' =====> numero'
go
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'numero' AND ss.name = N'dbo')
    CREATE TYPE numero FROM varchar(30) NULL
go

/* mensaje */
print ' =====> mensaje'
go
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'mensaje' AND ss.name = N'dbo')
    CREATE TYPE mensaje FROM varchar(255) NULL
go

/* login */
print ' =====> login'
go
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'login' AND ss.name = N'dbo')
    CREATE TYPE login FROM varchar(14) NULL
go

/* estado */
print ' =====> estado'
go
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'estado' AND ss.name = N'dbo')
    CREATE TYPE estado FROM char(1) NULL
go

/* direccion */
print ' =====> direccion'
go
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'direccion' AND ss.name = N'dbo')
    CREATE TYPE direccion FROM varchar(255) NULL
go

/* descripcion */
print ' =====> descripcion'
go
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'descripcion' AND ss.name = N'dbo')
    CREATE TYPE descripcion FROM varchar(64) NULL
go

/* cuenta */
print ' =====> cuenta'
go
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'cuenta' AND ss.name = N'dbo')
    CREATE TYPE cuenta FROM varchar(24) NULL
go

/* catalogo */
print ' =====> catalogo'
go
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'catalogo' AND ss.name = N'dbo')
    CREATE TYPE catalogo FROM varchar(10) NULL
go

/* VALOR_VARIABLE */
print ' =====> VALOR_VARIABLE'
go
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'VALOR_VARIABLE' AND ss.name = N'dbo')
    CREATE TYPE VALOR_VARIABLE FROM varchar(255) NULL
go
