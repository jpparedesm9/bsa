
use cob_cartera 
go 


IF OBJECT_ID ('dbo.ca_qry_transacciones') IS NOT NULL
	DROP TABLE dbo.ca_qry_transacciones
GO

create table ca_qry_transacciones  (
qt_id                    int     identity, 
qt_transaccion           varchar(10) null,
qt_secuencial            int         null, 
qt_fecha_Trn             varchar(20) null,
qt_fecha_Ref             varchar(20) null,  
qt_oficina               int         null,
qt_monto                 money       null,
qt_moneda                int         null,
qt_corresponsal_id       int         null,  
qt_forma_pago            varchar(30) null,
qt_estado                varchar(3)  null,   
qt_usuario_trn           varchar(30) null,
qt_tramite               int         null,
qt_usuario              varchar(30) null,
)


CREATE CLUSTERED INDEX ca_qry_transacciones_1
	ON dbo.ca_qry_transacciones (qt_id, qt_usuario)
GO

IF OBJECT_ID ('dbo.ca_qry_det_trn') IS NOT NULL
	DROP TABLE dbo.ca_qry_det_trn
GO
  
create table ca_qry_det_trn (
qd_id int          identity,
qd_secuencial_trn  int null,
qd_concepto        varchar(10) null,
qd_estado          varchar(11) null, 
qd_cuota           int null,
qd_secuencia       int null,
qd_codigo_valor    int null,
qd_monto           money null,
qd_usuario         login null 
)
   
CREATE CLUSTERED INDEX ca_qry_det_trn_1
ON dbo.ca_qry_det_trn (qd_id,qd_usuario)
GO


IF OBJECT_ID ('dbo.ca_qry_consulta_abono') IS NOT NULL
	DROP TABLE dbo.ca_qry_consulta_abono
GO
  

create table ca_qry_consulta_abono (
id_abono           int identity      ,
[Operacion]         int             null, 
[Id_Pago]           int             null,
[secuencial_pag]    int             null,
[Forma de Pago]     varchar(20)     null, 
[Fecha de Ingreso]  datetime        null,
[Fecha Valor]       datetime        null,  
[Oficina]           int             null,
[Monto]             money  			null,
[Moneda]            int    			null, 
[Id_Corresponsal]   int     		null, 
[Estado]            varchar(10) 	null, 
[Usuario]          varchar(15) 		null ,
[Mensaje]          varchar(255)  	null,
s_user              varchar(15)     null    
)

CREATE CLUSTERED INDEX ca_qry_consulta_abono_1
ON dbo.ca_qry_consulta_abono (id_abono,Usuario)
GO




