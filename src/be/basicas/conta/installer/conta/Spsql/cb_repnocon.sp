/************************************************************************/
/*  Archivo:                         cb_repnocon.sp                     */
/*  Stored procedure:                sp_rep_no_contab                   */
/*  Base de datos:                   cob_conta                          */
/*  Producto:                        Contabilidad                       */
/*  Disenado por:                    Doris Lozano                       */
/*  Fecha de escritura:              11-Feb-2015                        */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de NCR          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Generar reporte de transacciones no contabilizadas                  */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/*  02/11/2015  Doris Lozano           Emision Inicial                  */
/************************************************************************/

use cob_conta
go


if exists (SELECT * from sysobjects WHERE name = 'sp_rep_no_contab')
   drop proc sp_rep_no_contab
go

create proc sp_rep_no_contab(
   @i_param1     Datetime = Null,  --FECHA DE INICIO
   @i_param2     Datetime = Null  --FECHA DE FIN
)

as
declare
@w_fecha_ini         datetime,
@w_fecha_fin         datetime,
@w_sp_name           varchar(30),
@w_s_app             varchar(255),
@w_path              varchar(255),
@w_nombre            varchar(255),
@w_nombre_cab        varchar(255),
@w_destino           varchar(2500),
@w_errores           varchar(1500),
@w_error             int,
@w_comando           varchar(3500),
@w_nombre_plano      varchar(2500),
@w_msg               varchar(255),
@w_col_id            int,
@w_columna           varchar(100),
@w_return            int,
@w_dia               int,
@w_fecha             datetime,
@w_ruta              varchar(100),
@w_path_lis          varchar(64),
@w_anio              smallint,
@w_mes               tinyint,
@w_fecha_dia         datetime



select 
	@w_sp_name       = 'sp_rep_no_contab',
	@w_fecha_ini     = convert(varchar(10), @i_param1, 101),
    @w_fecha_fin     = convert(varchar(10), @i_param2, 101),
    @w_fecha         = convert(varchar(10), getdate(), 101)



select @w_ruta = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

if @@rowcount = 0
begin
   select @w_error = 2902799, @w_msg = 'NO EXISTE PARAMETRO S_APP'
   goto ERRORFIN
end

select @w_path_lis = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6

if @@rowcount = 0
begin
   select @w_error = 2902800, @w_msg = 'NO EXISTE PATH DESTINO'
   goto ERRORFIN
end


   truncate table cb_rep_no_cont

   --Datos de Cartera
   insert into cb_rep_no_cont
   (fecha_mov,       producto,   	operacion,   	
	tipo_tran,       valor,     	oficina,    	
	usuario,         terminal,   	estado,    	
	fecha_cont, 	 fecha_real,    codigo_valor
   )
   select  tr_fecha_mov,  '(7-CARTERA)',    tr_banco, 		  
           tr_tran,       dtr_monto, 	    tr_ofi_oper, 	
           tr_usuario,    tr_terminal,      tr_estado,		
           tr_fecha_cont, tr_fecha_real,    dtr_codvalor
	from cob_cartera..ca_transaccion with (nolock), cob_cartera..ca_det_trn with (nolock)
	where  tr_fecha_mov  >= @w_fecha_ini
	and tr_fecha_mov  <= @w_fecha_fin
    and dtr_secuencial = tr_secuencial
	and dtr_operacion = tr_operacion
	and tr_estado not in ('CON','RV', 'NCO')
	and tr_tran <> 'PRV'

   if @@error <> 0
   begin
      select @w_msg = 'Error. Insertando datos cartera en cb_rep_no_cont'
      goto ERRORFIN
   end

   select @w_fecha_dia = @w_fecha_ini
   
   while @w_fecha_dia <= @w_fecha_fin
   begin
       insert into cb_rep_no_cont
      (fecha_mov,       producto,   	operacion,   	
	   tipo_tran,       valor,     	oficina,    	
	   usuario,         terminal,   	estado,    	
	   fecha_cont, 	 fecha_real,    codigo_valor
      )
      select  tp_fecha_mov,  '(7-CARTERA)',    convert(varchar(24),tp_operacion), 		  
            0,             tp_monto, 	    4069, 	
           'op_batch',    ' ',              tp_estado,		
            tp_fecha_cont, tp_fecha_ref,    tp_codvalor 
       from cob_cartera..ca_transaccion_prv with (nolock)
       where  tp_fecha_mov = @w_fecha_dia
       and    tp_estado    = 'ING'
       
       if @@error <> 0
       begin
          select @w_msg = 'Error. Insertando datos cartera prv en cb_rep_no_cont'
          goto ERRORFIN
       end


       select @w_fecha_dia = dateadd(dd,1, @w_fecha_dia)
   end
   
   
   --Datos Plazo Fijo
    insert into cb_rep_no_cont
   (fecha_mov,       producto,   	 operacion,   	
	tipo_tran,       valor,     	 oficina,    	
	usuario,         terminal,   	 estado,    	
	fecha_cont, 	 fecha_real,     codigo_valor
   )
   select tr_fecha_mov,   '(14-PLAZO FIJO)',    tr_banco,        
          tr_tipo_trn,    td_monto,       		tr_ofi_oper, 
          tr_usuario,     tr_terminal,    		tr_estado,       
          tr_fecha_cont,  tr_fecha_real,  		td_codvalor 
	from cob_pfijo..pf_transaccion with (nolock), cob_pfijo..pf_transaccion_det with (nolock)
	where tr_fecha_mov  >= @w_fecha_ini
	and tr_fecha_mov  <= @w_fecha_fin
	and tr_estado <> 'CON'
	and td_operacion = tr_operacion
	and td_secuencial = tr_secuencial

    if @@error <> 0
    begin
      select @w_msg = 'Error. Insertando datos plazo fijo en cb_rep_no_cont'
      goto ERRORFIN
    end
    
   --Datos de Ahorros
   insert into cb_rep_no_cont
   (fecha_mov,       producto,   	 
    operacion,   	
	tipo_tran,       valor,     	 oficina,    	
	usuario,         terminal,   	 estado,    	
	fecha_cont, 	 fecha_real,     codigo_valor
   )
	select tc_fecha, 	'(4-AHORROS)',  
	       (select ah_cta_banco from cob_ahorros..ah_cuenta where ah_cliente = a.tc_cliente and ah_estado = a.tc_estcta),
	       tc_concepto,    tc_valor,       tc_ofic_orig, 
	       'op_batch',    'consola',       tc_estado,      
	       tc_fecha,       tc_hora,        tc_perfil 
	 from cob_remesas..re_trn_contable a with (nolock)
	where tc_fecha  >= @w_fecha_ini
	and   tc_fecha  <= @w_fecha_fin
	and   tc_estado   <> 'CON'
	and   tc_producto = 4
 
	if @@error <> 0
    begin
      select @w_msg = 'Error. Insertando datos ahorros en cb_rep_no_cont'
      goto ERRORFIN
    end
    
    
   if exists(select 1 from cob_conta..sysobjects where name = 'archivo_tmp')
         drop table archivo_tmp
   
    create table archivo_tmp(
      registro   varchar(2000)
   )
   
   --INSERTA EL ENCABEZADO DEL ARCHIVO
   insert into archivo_tmp
   select 'FECHA MOV|PRODUCTO|OPERACION/CUENTA|TIPO TRAN|MONTO|OFICINA|USUARIO|TERMINAL|ESTADO|FECHA CONT|FECHA REAL|CODIGO VALOR'
   
 
   --INSERTA EL DETALLE DEL ARCHIVO
   insert into archivo_tmp
   select convert(varchar(10),fecha_mov,101)   		+ '|' +  
          convert(varchar,producto)      	 		+ '|' +
          convert(varchar,isnull(operacion,' ')) 	+ '|' +
          convert(varchar,isnull(tipo_tran, ' '))   + '|' +
          convert(varchar,isnull(valor,'0'))  		+ '|' +
          convert(varchar,isnull(oficina,'0'))   	+ '|' +
          convert(varchar,isnull(usuario,' ')) 		+ '|' +
          convert(varchar,isnull(terminal,' '))		+ '|' +
          convert(varchar,estado)     				+ '|' +
          convert(varchar(10),fecha_cont,101)  		+ '|' +
          convert(varchar,fecha_real)  		        + '|' +
          convert(varchar,codigo_valor)
   from    cb_rep_no_cont
   
    select @w_anio = datepart(yy, convert(datetime,@w_fecha))
	select @w_mes  = datepart(mm, convert(datetime,@w_fecha))
	select @w_dia  = datepart(dd, convert(datetime,@w_fecha))
	
	select @w_s_app =  's_app bcp -auto -login cob_conta..archivo_tmp out '
	select @w_destino  = 'rep_nocont_'+ convert(varchar, @w_anio)+ convert(varchar, @w_mes) + convert(varchar, @w_dia) + '.txt',
	       @w_errores  = @w_path_lis + 'rep_nocont' + '.err'
	select @w_comando = @w_ruta + @w_s_app + @w_path_lis + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+  + @w_ruta + 's_app.ini'
	
	exec @w_error = xp_cmdshell @w_comando
	if @w_error <> 0 begin
	   print 'Error Generando archivo plano'
	   print @w_comando
	   return 1
	end

return 0

ERRORFIN: 

   select @w_msg = @w_sp_name + ' --> ' + @w_msg
   print @w_msg
   
   return 1

go
