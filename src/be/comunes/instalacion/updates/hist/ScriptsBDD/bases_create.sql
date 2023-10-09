USE master
go
CREATE DATABASE cob_ahorros 
ON PRIMARY
(
    NAME='cob_ahorros_dat',
    FILENAME='f:\BASESSQL\cob_ahorros_dat.mdf',
    SIZE=425408KB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='cob_ahorros_log',
    FILENAME='f:\BASESSQL\cob_ahorros_log.ldf',
    SIZE=722880KB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
ALTER DATABASE cob_ahorros ADD FILEGROUP indexgroup
go
ALTER DATABASE cob_ahorros ADD FILE 
(
    NAME='indexgroup_cob_ahorros',
    FILENAME='f:\BASESSQL\indexgroup_cob_ahorros.ndf',
    SIZE=100MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup
go
EXEC sp_dbcmptlevel 'cob_ahorros',100
go
EXEC sp_dboption 'cob_ahorros','auto create statistics',true
go
EXEC sp_dboption 'cob_ahorros','auto update statistics',true
go
USE cob_ahorros
go
CHECKPOINT
go
IF DB_ID('cob_ahorros') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_ahorros >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_ahorros >>>'
go

USE master
go
CREATE DATABASE cob_ahorros_his 
ON PRIMARY
(
    NAME='cob_ahorros_his_dat',
    FILENAME='f:\BASESSQL\cob_ahorros_his_dat.mdf',
    SIZE=550MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='cob_ahorros_his_log',
    FILENAME='f:\BASESSQL\cob_ahorros_his_log.ldf',
    SIZE=262080KB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
ALTER DATABASE cob_ahorros_his ADD FILEGROUP indexgroup
go
ALTER DATABASE cob_ahorros_his ADD FILE 
(
    NAME='indexgroup_cob_ahorros_his',
    FILENAME='f:\BASESSQL\indexgroup_cob_ahorros_his.ndf',
    SIZE=252MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup
go
EXEC sp_dbcmptlevel 'cob_ahorros_his',100
go
EXEC sp_dboption 'cob_ahorros_his','auto create statistics',true
go
EXEC sp_dboption 'cob_ahorros_his','auto update statistics',true
go
USE cob_ahorros_his
go
CHECKPOINT
go
IF DB_ID('cob_ahorros_his') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_ahorros_his >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_ahorros_his >>>'
go

USE master
go
CREATE DATABASE cob_ccontable 
ON PRIMARY
(
    NAME='cob_ccontable_dat',
    FILENAME='f:\BASESSQL\cob_ccontable_dat.mdf',
    SIZE=50MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='cob_ccontable_log',
    FILENAME='f:\BASESSQL\cob_ccontable_log.ldf',
    SIZE=1310656KB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
ALTER DATABASE cob_ccontable ADD FILEGROUP indexgroup
go
ALTER DATABASE cob_ccontable ADD FILE 
(
    NAME='indexgroup_cob_ccontable',
    FILENAME='f:\BASESSQL\indexgroup_cob_ccontable.ndf',
    SIZE=2MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup
go
EXEC sp_dbcmptlevel 'cob_ccontable',100
go
EXEC sp_dboption 'cob_ccontable','auto create statistics',true
go
EXEC sp_dboption 'cob_ccontable','auto update statistics',true
go
USE cob_ccontable
go
CHECKPOINT
go
IF DB_ID('cob_ccontable') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_ccontable >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_ccontable >>>'
go

USE master
go
CREATE DATABASE cob_conta_super 
ON PRIMARY
(
    NAME='cob_conta_super_dat',
    FILENAME='f:\BASESSQL\cob_conta_super_dat.mdf',
    SIZE=5779MB,
    MAXSIZE=254000MB,
    FILEGROWTH=450MB
)
LOG ON
(
    NAME='cob_conta_super_log',
    FILENAME='f:\BASESSQL\cob_conta_super_log.ldf',
    SIZE=29504KB,
    MAXSIZE=2097152MB,
    FILEGROWTH=10%
)
go
ALTER DATABASE cob_conta_super ADD FILEGROUP indexgroup
go
ALTER DATABASE cob_conta_super ADD FILE 
(
    NAME='indexgroup_cob_conta_super',
    FILENAME='f:\BASESSQL\indexgroup_cob_conta_super.ndf',
    SIZE=2824576KB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup
go
ALTER DATABASE cob_conta_super ADD FILEGROUP SECUNDARY
go
ALTER DATABASE cob_conta_super ADD FILE 
(
    NAME='cob_conta_super_dat2',
    FILENAME='f:\BASESSQL\cob_conta_super_dat2.ndf',
    SIZE=2930176KB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=10%
) TO FILEGROUP SECUNDARY
go
ALTER DATABASE cob_conta_super ADD FILEGROUP tmp
go
EXEC sp_dbcmptlevel 'cob_conta_super',100
go
EXEC sp_dboption 'cob_conta_super','auto create statistics',true
go
EXEC sp_dboption 'cob_conta_super','auto update statistics',true
go
USE cob_conta_super
go
CHECKPOINT
go
IF DB_ID('cob_conta_super') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_conta_super >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_conta_super >>>'
go

USE master
go
CREATE DATABASE cob_conta_tercero 
ON PRIMARY
(
    NAME='cob_conta_tercero',
    FILENAME='f:\BASESSQL\cob_conta_tercero.mdf',
    SIZE=150MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=1MB
)
LOG ON
(
    NAME='cob_conta_tercero_log',
    FILENAME='f:\BASESSQL\cob_conta_tercero_log.ldf',
    SIZE=30MB,
    MAXSIZE=2097152MB,
    FILEGROWTH=10%
)
go
EXEC sp_dbcmptlevel 'cob_conta_tercero',110
go
EXEC sp_dboption 'cob_conta_tercero','auto create statistics',true
go
EXEC sp_dboption 'cob_conta_tercero','auto update statistics',true
go
USE cob_conta_tercero
go
CHECKPOINT
go
IF DB_ID('cob_conta_tercero') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_conta_tercero >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_conta_tercero >>>'
go

USE master
go
CREATE DATABASE cob_cuentas 
ON PRIMARY
(
    NAME='cob_cuentas_dat',
    FILENAME='f:\BASESSQL\cob_cuentas_dat.mdf',
    SIZE=50MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='cob_cuentas_log',
    FILENAME='f:\BASESSQL\cob_cuentas_log.ldf',
    SIZE=524224KB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
ALTER DATABASE cob_cuentas ADD FILEGROUP indexgroup
go
ALTER DATABASE cob_cuentas ADD FILE 
(
    NAME='indexgroup_cob_cuentas',
    FILENAME='f:\BASESSQL\indexgroup_cob_cuentas.ndf',
    SIZE=251MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup
go
EXEC sp_dbcmptlevel 'cob_cuentas',100
go
EXEC sp_dboption 'cob_cuentas','auto create statistics',true
go
EXEC sp_dboption 'cob_cuentas','auto update statistics',true
go
USE cob_cuentas
go
CHECKPOINT
go
IF DB_ID('cob_cuentas') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_cuentas >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_cuentas >>>'
go

USE master
go
CREATE DATABASE cob_cuentas_his 
ON PRIMARY
(
    NAME='cob_cuentas_his_dat',
    FILENAME='f:\BASESSQL\cob_cuentas_his_dat.mdf',
    SIZE=50MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='cob_cuentas_his_log',
    FILENAME='f:\BASESSQL\cob_cuentas_his_log.ldf',
    SIZE=589696KB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
ALTER DATABASE cob_cuentas_his ADD FILEGROUP indexgroup
go
ALTER DATABASE cob_cuentas_his ADD FILE 
(
    NAME='indexgroup_cob_cuentas_his',
    FILENAME='f:\BASESSQL\indexgroup_cob_cuentas_his.ndf',
    SIZE=2MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup
go
EXEC sp_dbcmptlevel 'cob_cuentas_his',100
go
EXEC sp_dboption 'cob_cuentas_his','auto create statistics',true
go
EXEC sp_dboption 'cob_cuentas_his','auto update statistics',true
go
USE cob_cuentas_his
go
CHECKPOINT
go
IF DB_ID('cob_cuentas_his') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_cuentas_his >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_cuentas_his >>>'
go

USE master
go
CREATE DATABASE cob_distrib 
ON PRIMARY
(
    NAME='cob_distrib_Data',
    FILENAME='f:\BASESSQL\cob_distrib_Data.MDF',
    SIZE=800MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='cob_distrib_Log',
    FILENAME='f:\BASESSQL\cob_distrib_Log.LDF',
    SIZE=803776KB,
    MAXSIZE=2097152MB,
    FILEGROWTH=10%
)
go
EXEC sp_dbcmptlevel 'cob_distrib',90
go
EXEC sp_dboption 'cob_distrib','auto create statistics',true
go
EXEC sp_dboption 'cob_distrib','auto update statistics',true
go
USE cob_distrib
go
CHECKPOINT
go
IF DB_ID('cob_distrib') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_distrib >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_distrib >>>'
go

USE master
go
CREATE DATABASE cob_externos 
ON PRIMARY
(
    NAME='cob_externos_dat',
    FILENAME='f:\BASESSQL\cob_externos_dat.mdf',
    SIZE=350MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=150MB
)
LOG ON
(
    NAME='cob_externos_log',
    FILENAME='f:\BASESSQL\cob_externos_log.ldf',
    SIZE=594880KB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
EXEC sp_dbcmptlevel 'cob_externos',100
go
EXEC sp_dboption 'cob_externos','auto create statistics',true
go
EXEC sp_dboption 'cob_externos','auto update statistics',true
go
USE cob_externos
go
CHECKPOINT
go
IF DB_ID('cob_externos') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_externos >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_externos >>>'
go

USE master
go
CREATE DATABASE cob_interfase 
ON PRIMARY
(
    NAME='cob_interfase',
    FILENAME='f:\BASESSQL\cob_interfase_dat.mdf',
    SIZE=50MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='cob_interfase_log',
    FILENAME='f:\BASESSQL\cob_interfase_log.ldf',
    SIZE=40MB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
EXEC sp_dbcmptlevel 'cob_interfase',100
go
EXEC sp_dboption 'cob_interfase','auto create statistics',true
go
EXEC sp_dboption 'cob_interfase','auto update statistics',true
go
USE cob_interfase
go
CHECKPOINT
go
IF DB_ID('cob_interfase') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_interfase >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_interfase >>>'
go

USE master
go
CREATE DATABASE cob_remesas 
ON PRIMARY
(
    NAME='cob_remesas_dat',
    FILENAME='f:\BASESSQL\cob_remesas_dat.mdf',
    SIZE=50MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='cob_remesas_log',
    FILENAME='f:\BASESSQL\cob_remesas_log.ldf',
    SIZE=524096KB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
ALTER DATABASE cob_remesas ADD FILEGROUP indexgroup
go
ALTER DATABASE cob_remesas ADD FILE 
(
    NAME='indexgroup_cob_remesas',
    FILENAME='f:\BASESSQL\indexgroup_cob_remesas_dat.ndf',
    SIZE=2MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup
go
EXEC sp_dbcmptlevel 'cob_remesas',100
go
EXEC sp_dboption 'cob_remesas','auto create statistics',true
go
EXEC sp_dboption 'cob_remesas','auto update statistics',true
go
USE cob_remesas
go
CHECKPOINT
go
IF DB_ID('cob_remesas') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_remesas >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_remesas >>>'
go

USE master
go
CREATE DATABASE cob_remesas_his 
ON PRIMARY
(
    NAME='cob_remesas_his_dat',
    FILENAME='f:\BASESSQL\cob_remesas_his_dat.mdf',
    SIZE=1500MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='cob_remesas_his_log',
    FILENAME='f:\BASESSQL\cob_remesas_his_log.ldf',
    SIZE=524096KB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
ALTER DATABASE cob_remesas_his ADD FILEGROUP indexgroup
go
ALTER DATABASE cob_remesas_his ADD FILE 
(
    NAME='indexgroup_cob_remesas_his',
    FILENAME='f:\BASESSQL\indexgroup_cob_remesas_his.ndf',
    SIZE=1500MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup
go
EXEC sp_dbcmptlevel 'cob_remesas_his',100
go
EXEC sp_dboption 'cob_remesas_his','auto create statistics',true
go
EXEC sp_dboption 'cob_remesas_his','auto update statistics',true
go
USE cob_remesas_his
go
CHECKPOINT
go
IF DB_ID('cob_remesas_his') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_remesas_his >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_remesas_his >>>'
go

USE master
go
CREATE DATABASE cobis 
ON PRIMARY
(
    NAME='cobis',
    FILENAME='f:\BASESSQL\cobis_Dat.mdf',
    SIZE=300MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='cobis_log',
    FILENAME='f:\BASESSQL\cobis_log.ldf',
    SIZE=786312KB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
ALTER DATABASE cobis ADD FILEGROUP indexgroup
go
ALTER DATABASE cobis ADD FILE 
(
    NAME='indexgroup_cobis',
    FILENAME='f:\BASESSQL\indexgroup_cobis.ndf',
    SIZE=3252MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup
go
EXEC sp_dbcmptlevel 'cobis',100
go
EXEC sp_dboption 'cobis','auto create statistics',true
go
EXEC sp_dboption 'cobis','auto update statistics',true
go
EXEC sp_dboption 'cobis','default to local cursor',true
go
EXEC sp_dboption 'cobis','trunc. log on chkpt.',true
go
USE cobis
go
CHECKPOINT
go
IF DB_ID('cobis') IS NOT NULL
    PRINT '<<< CREATED DATABASE cobis >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cobis >>>'
go

USE master
go
CREATE DATABASE firmas 
ON PRIMARY
(
    NAME='firmas',
    FILENAME='f:\BASESSQL\firmas_dat.mdf',
    SIZE=50MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='firmas_log',
    FILENAME='f:\BASESSQL\firmas_log.ldf',
    SIZE=500MB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
ALTER DATABASE firmas ADD FILEGROUP indexgroup
go
ALTER DATABASE firmas ADD FILE 
(
    NAME='indexgroup_firmas',
    FILENAME='f:\BASESSQL\indexgroup_firmas.ndf',
    SIZE=500MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup
go
EXEC sp_dbcmptlevel 'firmas',100
go
EXEC sp_dboption 'firmas','auto create statistics',true
go
EXEC sp_dboption 'firmas','auto update statistics',true
go
USE firmas
go
CHECKPOINT
go
IF DB_ID('firmas') IS NOT NULL
    PRINT '<<< CREATED DATABASE firmas >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE firmas >>>'
go
USE master
go
CREATE DATABASE cob_conta 
ON PRIMARY
(
    NAME='cob_conta_dat',
    FILENAME='f:\BASESSQL\cob_conta_dat.mdf',
    SIZE=800MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=350MB
)
LOG ON
(
    NAME='cob_conta_log',
    FILENAME='f:\BASESSQL\cob_conta_log.ldf',
    SIZE=200MB,
    MAXSIZE=2048000MB,
    FILEGROWTH=250MB
)
go
ALTER DATABASE cob_conta ADD FILEGROUP indexgroup
go
ALTER DATABASE cob_conta ADD FILE 
(
    NAME='indexgroup_cob_conta',
    FILENAME='f:\BASESSQL\indexgroup_cob_conta.ndf',
    SIZE=200MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=350MB
) TO FILEGROUP indexgroup
go
ALTER DATABASE cob_conta ADD FILE 
(
    NAME='indexgroup2_cob_conta',
    FILENAME='f:\BASESSQL\indexgroup2_cob_conta.ndf',
    SIZE=200MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup2
go
EXEC sp_dbcmptlevel 'cob_conta',100
go
EXEC sp_dboption 'cob_conta','auto create statistics',true
go
EXEC sp_dboption 'cob_conta','auto update statistics',true
go
USE cob_conta
go
CHECKPOINT
go
IF DB_ID('cob_conta') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_conta >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_conta >>>'
go

USE master
go
CREATE DATABASE cob_conta_his 
ON PRIMARY
(
    NAME='cob_conta_his_dat',
    FILENAME='f:\BASESSQL\cob_conta_his_dat.mdf',
    SIZE=500MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
)
LOG ON
(
    NAME='cob_conta_his_log',
    FILENAME='f:\BASESSQL\cob_conta_his_log.ldf',
    SIZE=200MB,
    MAXSIZE=2097152MB,
    FILEGROWTH=150MB
)
go
ALTER DATABASE cob_conta_his ADD FILEGROUP indexgroup
go
ALTER DATABASE cob_conta_his ADD FILE 
(
    NAME='indexgroup_cob_conta_his',
    FILENAME='f:\BASESSQL\indexgroup_cob_conta_his.ndf',
    SIZE=2MB,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=250MB
) TO FILEGROUP indexgroup
go
go
EXEC sp_dbcmptlevel 'cob_conta_his',100
go
EXEC sp_dboption 'cob_conta_his','auto create statistics',true
go
EXEC sp_dboption 'cob_conta_his','auto update statistics',true
go
USE cob_conta_his
go
CHECKPOINT
go
IF DB_ID('cob_conta_his') IS NOT NULL
    PRINT '<<< CREATED DATABASE cob_conta_his >>>'
ELSE
    PRINT '<<< FAILED CREATING DATABASE cob_conta_his >>>'
go
