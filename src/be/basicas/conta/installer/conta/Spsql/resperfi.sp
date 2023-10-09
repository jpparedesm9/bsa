/************************************************************************/
/*	Archivo: 		conspygt.sp                             */
/*	Stored procedure: 	sp_manual_tran                          */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               Contabilidad                            */
/*	Disenado por:           José Molano                             */
/*	Fecha de escritura:     Abr-18-2007                             */
/************************************************************************/
/*				IMPORTANTE                              */
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de la "NCR  */
/*	CORPORATION".                                                   */
/*	Su uso no autorizado queda expresamente prohibido asi como      */
/*	cualquier alteracion o agregado hecho por alguno de sus         */
/*	usuarios sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*				PROPOSITO                               */
/*  	  store procedure para la resolución de perfiles cobis          */
/************************************************************************/
/*				MODIFICACIONES                          */
/*	FECHA		AUTOR			RAZON                   */
/*	                                                                */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_manual_tran')
	drop proc sp_manual_tran
go

create proc sp_manual_tran
(
        @i_empresa          tinyint,
        @i_producto         smallint,
        @i_cuenta           varchar(30),
        @i_perfil           varchar(20),
        @i_parametro        varchar(30),
        @i_descripcion      descripcion,
        @i_asiento          smallint,
        @i_area             varchar(10),
        @i_debcred          char(1)
)
as
declare 
        @w_nombre           char(80),
        @w_secuencial       int,
        @w_producto         smallint,
        @w_contador         int

select @w_producto = 0
select  @w_secuencial = 0

select 1 
from cob_conta..cb_sec_perf
where sp_producto = @w_producto

if @@rowcount = 0
begin
     insert into cob_conta..cb_sec_perf
     values (@w_producto, 0)
end

select  @w_secuencial = sp_secuencial + 1
from cob_conta..cb_sec_perf
where sp_producto = @w_producto

select @w_nombre = cu_nombre
from cob_conta..cb_cuenta
where cu_cuenta = @i_cuenta
and   cu_empresa = @i_empresa
and   cu_movimiento = 'S'

select  @w_contador = count(1) 
from cob_conta..cb_cuenperfi
where cp_perfil   = @i_perfil
and   cp_cuenta   = @i_cuenta
and   cp_producto = @i_producto
and   cp_debcred  = @i_debcred

if  @w_contador = 0
begin
     BEGIN TRAN
     Insert into cb_cuenperfi(cp_secuencial,        cp_producto,      cp_cuenta,      cp_nomcta,     cp_perfil,
                              cp_string,            cp_descripcion,   cp_asiento,     cp_area,       cp_debcred )
     
                     values (@w_secuencial,         @i_producto,      @i_cuenta,      @w_nombre,     @i_perfil, 
                             @i_parametro,          @i_descripcion,   @i_asiento,     @i_area,       @i_debcred)
     if @@error <> 0
     begin
          print 'ERROR AL INSERTAR EN TABLA DE PERFILES'
          ROLLBACK TRAN
          return 601161
     end     
     
     update cob_conta..cb_sec_perf
     set sp_secuencial = @w_secuencial
     
     if @@error <> 0
     begin
         print 'ERROR AL ACTUALIZAR SECUENCIAL'
         ROLLBACK TRAN
         return 601162
     end
     COMMIT TRAN    
end
go                    