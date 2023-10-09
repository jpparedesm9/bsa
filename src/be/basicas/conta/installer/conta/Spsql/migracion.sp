/************************************************************************/
/*	Archivo: 		migracion.sp	    		        */
/*	Stored procedure: 	sp_migracion   				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     04-marzo-1996 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	   Mantenimiento al catalogo de Saldos                          */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Mar/1996	O Hoyos F.      Emision Inicial			*/
/*      14/11/1997	Martha Gil V.   cu_descripcion varchar (255)    */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_migracion')
	drop proc sp_migracion    
go

create proc sp_migracion    (
	@i_cta_origen	cuenta ,
	@i_cta_destino	cuenta ,
	@i_empresa	tinyint= null,
	@i_oficina 	smallint= null,
	@i_area		smallint= null,
	@i_corte 	int= null,	
	@i_periodo      int  = null,
	@i_saldo	money = null,
	@i_saldo_me	money = null,
	@i_debito	money = null,
	@i_credito	money = null,
	@i_debito_me	money = null,
	@i_credito_me	money = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_cta_padre	cuenta, 
	@w_nombre	varchar(80), 
	@w_descripcion	varchar(255) ,  /* se cambio (80) POR (255) MGV*/
	@w_estado	char(1), 
	@w_movimiento	char(1), 
	@w_nivel_cta	tinyint, 
	@w_categoria	char(1),
	@w_fecha_estado datetime,
	@w_moneda 	tinyint,
	@w_sinonimo	varchar(20) ,
  	@w_area		smallint , 
	@w_proceso	smallint , 
	@w_secuencial	smallint , 
	@w_condicion	smallint , 
	@w_cta_asoc	cuenta, 
	@w_oficina_destino smallint , 
	@w_area_destino	   smallint , 
	@w_debcred	char(1) 

select @w_today = getdate()
select @w_sp_name = 'sp_migracion'

/**** CREACION DE UNA NUEVA CUENTA EXACTAMENTE IGUAL A LA CUENTA ORIGEN ****/
                -- INSERTA UNO NUEVO                  
select 	@w_cta_padre = cu_cuenta_padre ,
	@w_nombre = cu_nombre ,
	@w_descripcion = cu_descripcion,
	@w_estado = cu_estado ,	
	@w_movimiento = cu_movimiento ,
	@w_nivel_cta = cu_nivel_cuenta ,
	@w_categoria = cu_categoria ,
	@w_fecha_estado = cu_fecha_estado ,
	@w_moneda = cu_moneda ,
	@w_sinonimo = cu_sinonimo
from cb_cuenta
where cu_empresa = @i_empresa and
      cu_cuenta = @i_cta_origen

update cob_conta..cb_cuenta
set 	cu_estado      = 'C'
where cu_empresa    = @i_empresa and cu_cuenta     = @i_cta_origen 

insert into cob_conta..cb_cuenta
	( cu_empresa , cu_cuenta , cu_cuenta_padre , cu_nombre ,
	  cu_descripcion , cu_estado , cu_movimiento , cu_nivel_cuenta,
	  cu_categoria , cu_fecha_estado , cu_moneda , cu_sinonimo
	)  
values  ( @i_empresa , @i_cta_destino , @w_cta_padre , @w_nombre ,
	  @w_descripcion , @w_estado , @w_movimiento , @w_nivel_cta ,
	  @w_categoria , @w_fecha_estado , @w_moneda , @w_sinonimo 
	)
if @@error <> 0
begin
-- 'Error en la insercion de datos 
	exec cobis..sp_cerror
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
end

insert into cob_conta..cb_saldo  
	( sa_cuenta,sa_oficina,sa_area,sa_corte,
	  sa_periodo,sa_empresa,sa_saldo,
	  sa_saldo_me,sa_credito,sa_debito,sa_credito_me,
	  sa_debito_me
	)

values (@i_cta_destino,@i_oficina,@i_area,@i_corte,@i_periodo,
        @i_empresa,@i_saldo,@i_saldo_me,@i_credito,@i_debito,
        @i_credito_me,@i_debito_me)

if @@error <> 0
begin
-- 'Error en la insercion de datos 
	exec cobis..sp_cerror
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
end

-- ACTUALIZA EL REGISTRO ANTERIOR DE LA CUENTA   
update cob_conta..cb_saldo
set 	sa_saldo      =  $0,
	sa_saldo_me   =  $0,
	sa_credito    =  $0,
	sa_debito     =  $0,
	sa_credito_me =  $0,
	sa_debito_me  =  $0
where sa_empresa    = @i_empresa 
  and sa_cuenta     = @i_cta_origen 

if @@error <> 0
begin
	-- Error en la actualizacion de saldos al mayorizar
	exec cobis..sp_cerror
		@t_from	 = @w_sp_name,
		@i_num	 = 605036
		return 1
end
go
