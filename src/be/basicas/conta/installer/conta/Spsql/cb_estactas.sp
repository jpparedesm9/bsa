/************************************************************************/
/*  Archivo:            cb_estactas.sp                                  */ 
/*  Stored procedure:   sp_estado_planctas                              */
/*  Base de datos:      COB_CONTA                                       */
/*  Producto:           CONTABILIDAD                                    */
/*  Disenado por:       Sandra Lievano                                 	*/
/*  Fecha de escritura: Febrero 12 de 2007                              */
/************************************************************************/
/*                        IMPORTANTE                                    */
/* Este programa es parte de los paquetes bancarios propiedad de        */
/* "MACOSA", representantes exclusivos para el Ecuador de la            */
/* "NCR CORPORATION".                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier */
/* alteracion o agregado hecho por alguno de sus usuarios sin el debido */
/* consentimiento por escrito de la Presidencia Ejecutiva de "MACOSA"   */
/* o su representante.                                                  */
/* **********************************************************************/
/*                                                                      */
/*                         PROPOSITO                                    */
/* Proceso para cambio de estado de vigencia del plan de cuentas        */ 
/* **********************************************************************/
/*                       MODIFICACIONES                                 */
/* FECHA       AUTOR             RAZON                                  */
/* 12/02/2007  sandra lievano	 emisión inicial            		    */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_estado_planctas')
   drop proc sp_estado_planctas
go

create proc sp_estado_planctas(
		@s_ssn			int         = null,
		@s_user			login       = null,
		@s_term			varchar(30) = null,
		@s_date			datetime    = null,
		@s_srv			varchar(30) = null,
		@s_lsrv			varchar(30) = null,
		@s_ofi			smallint    = null,
		@s_rol			smallint    = NULL,
		@s_org_err		char(1)     = NULL,
		@s_error		int         = NULL,
		@s_sev			tinyint     = NULL,
		@s_msg			descripcion = NULL,
		@s_org			char(1)     = NULL,
		@t_debug		char(1)     = 'N',
		@t_from			varchar(30) = null,
		@t_file         varchar(30) = null,
		@t_trn			int         = null,
		@i_archivo      varchar(50) = null,
		@i_empresa      tinyint     = null,
		@i_cuenta       varchar(14) = null
)

as 
declare  /* Declaracion de Variables */
      @w_sp_name                     varchar(32),
      @w_return                      int,
      @w_empresa                     tinyint,
      @w_cuenta                      varchar(14),
      @w_usuario                     varchar(10),
      @w_fecha_corte                 datetime,
      @w_fecha_proceso               datetime,
      @w_periodo                     int,
      @w_corte                       int,
      @w_saldo                       money,
      @w_saldo_me                    money,
      @w_desc_recha                  varchar(64),
      @w_estado_ante                 char(1),
      @w_estado_actual               char(1),
      @w_movimiento                  varchar(1)
      
/* DATOS GENERALES */

select @w_sp_name = 'sp_estado_planctas'
select @w_fecha_proceso = getdate()

/*** Halla el periodo y corte para la fecha de proceso ***/ 
/*      select @w_corte   = co_corte, 
             @w_periodo = co_periodo 
      from cob_conta..cb_corte 
      where co_fecha_ini = @w_fecha_proceso
      and   co_empresa   = @i_empresa
*/
      
      select @w_corte   = co_corte, 
             @w_periodo = co_periodo 
      from cob_conta..cb_corte 
      where co_estado    = 'A'
        and co_empresa   = @i_empresa
      
--truncate table cb_cambestado_tmp
------------------
--- CURSOR -----
------------------
declare cuentas cursor for 
select ct_empresa, ct_cuenta, ct_usuario 
from cb_cambestado_tmp
where ct_empresa = @i_empresa
for read only

open cuentas

fetch cuentas into  
       @w_empresa, @w_cuenta, @w_usuario 

while @@fetch_status = 0
begin
/*   if (@@sqlstatus = 1)
   begin
      print "Fallo lectura de informacion de proceso"
   	  close cuentas
	  deallocate cursor cuentas
	  return 1
   end
*/ 

   --valida si la cuenta existe o no 
   if not exists (select 1 from cob_conta..cb_cuenta
                  where cu_cuenta = @w_cuenta)
   begin 
      select @w_desc_recha	= 'CUENTA NO EXISTE'
      insert cb_cuentas_log 
      values (@w_empresa,       @w_cuenta,        @w_desc_recha, 
              @w_estado_ante,   @w_estado_actual, @w_saldo, 
              @w_fecha_proceso, @w_usuario)
      GOTO SALIR  
   end
   else                              
   begin
      /*** Halla el saldo para la cuenta a procesar (validar saldo en cero) ***/
      select @w_saldo    = isnull(sum(sa_saldo),0), 
             @w_saldo_me = isnull(sum(sa_saldo_me),0) 
      from cob_conta..cb_saldo
      where sa_corte   = @w_corte
      and   sa_periodo = @w_periodo
      and   sa_oficina > 0
      and   sa_area    > 0
      and   sa_cuenta  = @w_cuenta
      and   sa_empresa = @w_empresa
       
      --Valida cuenta movimiento y estado vigente
      select @w_movimiento   = cu_movimiento,
             @w_estado_ante  = cu_estado
      from cob_conta..cb_cuenta
      where cu_empresa = @w_empresa
      and   cu_cuenta = @w_cuenta

      if  @w_movimiento <> 'S' and @w_estado_ante <> 'V'
      begin
      --print '3'
         select @w_desc_recha	= 'NO ES UNA CUENTA DE MOVIMIENTO O SU ESTADO NO ES VIGENTE'
         insert cb_cuentas_log 
         values (@w_empresa,       @w_cuenta,        @w_desc_recha, 
                 @w_estado_ante,   @w_estado_actual, @w_saldo, 
                 @w_fecha_proceso, @w_usuario)
                      
         GOTO SALIR 
      end
          
      if @w_saldo = 0 and @w_saldo_me = 0 
      begin
         update cb_cuenta 
         set cu_estado = 'C'
         where cu_cuenta = @w_cuenta      
                        
         if @@error <> 0 
         begin
            /* Error en actualizacion de registro */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 605081
            
            select @w_desc_recha	= 'ERROR EN ACTUALIZACION'
            insert cb_cuentas_log 
            values (@w_empresa,       @w_cuenta,        @w_desc_recha, 
                    @w_estado_ante,   @w_estado_actual, @w_saldo, 
                    @w_fecha_proceso, @w_usuario)
         end
      
         select @w_estado_actual = cu_estado
         from cb_cuenta
         where cu_cuenta = @w_cuenta      
                                                
         select @w_desc_recha	= 'CAMBIO DE ESTADO A CANCELADO'
         insert cb_cuentas_log 
         values (@w_empresa,       @w_cuenta,        @w_desc_recha, 
                 @w_estado_ante,   @w_estado_actual, @w_saldo, 
                 @w_fecha_proceso, @w_usuario)
         GOTO SALIR 
      end
      else
      begin
         --print 'CUENTA NO TIENE SALDO EN CERO'
         select @w_desc_recha	= 'CUENTA NO TIENE SALDO EN CERO'
         insert cb_cuentas_log 
         values (@w_empresa,       @w_cuenta,        @w_desc_recha, 
                 @w_estado_ante,   @w_estado_actual, @w_saldo, 
                 @w_fecha_proceso, @w_usuario)
                      
         GOTO SALIR 
      end
   end
   
SALIR: 
select @w_estado_ante = null,
       @w_estado_actual = null
                              
fetch cuentas into                                                
      @w_empresa, @w_cuenta, @w_usuario
end                                                           
                                                             
close cuentas                                                 
deallocate cuentas

insert into cb_cambcta_tmp
select * from cb_cuentas_log
where cl_fecha_proceso >= @w_fecha_proceso
                                                              
return 0                                                      
                                                              
go                                                            
