
use cob_cartera
go

IF OBJECT_ID ('dbo.ca_referencia_tmp') IS NOT NULL
	DROP TABLE dbo.ca_referencia_tmp
GO

CREATE TABLE ca_referencia_tmp
    ( 
     num_fila           INT, 
     fecha_valor_pago   varchar(10),
     num_referencia     varchar(64),
     monto_pago         varchar(14),
     forma_pago         varchar(64),
     trn_corresponsal   varchar(8),
     nom_archivo_pago   varchar(255),
     observaciones      varchar(800),
     procesado          char(1)	 
    )
go

--SELECT * FROM cob_cartera..ca_referencia_tmp

USE cob_cartera
GO
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'co_linea'
                  AND Object_ID = Object_ID(N'cob_cartera..ca_corresponsal_trn'))
begin
   ALTER TABLE cob_cartera..ca_corresponsal_trn
   add co_linea int NULL
end
go

---
USE cobis
GO

IF NOT EXISTS(SELECT 1 FROM cobis..cl_errores WHERE numero=70212)
BEGIN
insert into cobis..cl_errores  (numero, severidad, mensaje)
values (70212, 0, 'ERROR: YA EXISTE UN ARCHIVO DE PAGO CON EL MISMO NOMBRE')
END

IF NOT EXISTS(SELECT 1 FROM cobis..cl_errores WHERE numero=70213)
BEGIN

insert into cobis..cl_errores  (numero, severidad, mensaje)
values (70213, 0, 'ERROR: NO SE PUDO INSERTAR EL REGISTRO DE LA REFERENCIA ')

end
--Se actualiza las tildes al mensaje 70204
USE cobis
GO
UPDATE cobis..cl_errores SET mensaje='ERROR: TIPO DE TRANSACCIÓN NO VÁLIDA' WHERE numero= 70204
go
