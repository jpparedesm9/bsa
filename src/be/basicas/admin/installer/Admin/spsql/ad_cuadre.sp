/******************************************************************/
/*  ARCHIVO:         ad_cuadre.sp                                 */
/*  NOMBRE LOGICO:   sp_ad_cuadre                                 */
/*  PRODUCTO:        ADMIN                                        */
/******************************************************************/
/*                         IMPORTANTE                             */
/*  Esta Aplicacion es parte de los paquetes bancarios propiedad  */
/*  de COBISCORP S.A. Su uso  no  autorizado queda  expresamente  */
/*  prohibido asi como cualquier alteracion o agregado hecho por  */
/*  alguno  de sus  usuarios  sin el debido  consentimiento  por  */
/*  escrito  de  la   Presidencia  Ejecutiva   de  COBISCORP S.A. */
/*  o su representante                                            */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Este programa genera datos para que el dataware house         */
/*  cuadre la informacion generada por el modulo                  */
/******************************************************************/
/*                        MODIFICACIONES                          */
/*  FECHA         AUTOR            RAZON                          */
/*  10/Ago/2011   B.Ron            Emision Inicial                */
/*  18/Ago/2011   I.Rojas          Cuadre CE                      */
/*  04/ABR/12     Angelo Andy     Versionamiento del SP   	      */
/*  04/JUN/15     Jose Guamani    Se comenta tablas de plazo fijo */
/*                                cob_pfijo..pf_ex_ppago          */
/*                                cob_pfijo..pf_ex_fpago          */
/*                                cob_pfijo..pf_ex_tipo_deposito  */
/*  11-03-2016    BBO             Migracion Sybase-Sqlserver FAL  */
/******************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_ad_cuadre' )
   drop proc sp_ad_cuadre
go

CREATE PROC sp_ad_cuadre (
   @t_show_version            bit         = 0,    -- show the version of the stored procedure  
   @i_fecha           datetime,
   @i_tabla_fuente    varchar(64)  = '',
   @s_user            varchar(32)  = null,
   -- Parametros para registro de log de ejecucion
   @i_sarta           int               = null,
   @i_batch           int               = null,
   @i_secuencial      int               = null,
   @i_corrida         int               = null,
   @i_intento         int               = null
)
AS 
DECLARE 
   @w_sp_name         varchar(30),
   @w_return          int,
   @w_error_msg       varchar(64),  
   @w_modulo          tinyint,     -- Modulo Cobis
   @w_modulo_ce 	tinyint, --COMEXT
   @w_modulo_re 	tinyint, --REMESAS
   @w_modulo_con	tinyint,	 --CONTA
   @w_tabla_fuente    varchar(32), -- Tabla Fuente
   @w_campo_criterio  int,         -- Criterio:
                                   -- 1 Moneda          2 Estado         3 Oficina
                                   -- 4 Tipo Operacion  5 Ejecutivo      6 Tipo Transaccion
                                   -- 7 Tipo comision   8 Tipo Impuesto  9 Total General
   @w_valor_criterio  varchar(64), -- Valor del criterio por el cual se agrupa    
   @w_numero_reg      int,         -- Numero de registros segun criterio de agrup.
   @w_valor           money,       -- Monto total segun criterio de agrupacion    
   @w_empresa         int,          -- Numero de la Filial 
   @w_empresa_cb	  int		   -- Numero empresa para conta

select  @w_sp_name   	= 'sp_ad_cuadre',
        @w_modulo    	= 1, -- ADMIN
        @w_modulo_ce 	= 9, --COMEXT
        @w_modulo_re 	= 10, --REMESAS
        @w_modulo_con	= 6	 --CONTA
		
if @t_show_version = 1
        begin
            print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.4'
            return 0
    end

--print 'INICIA sp_ad_cuadre ...'

--Busca el parametro de empresa
select @w_empresa = pa_tinyint 
from cobis..cl_parametro
where pa_producto = 'ADM'
  and pa_nemonico = 'EMP'

if @@rowcount =  0 
begin
   select @w_error_msg = 'NO se encontro codigo de empresa en cl_parametro, empresa = 1'
   exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808072,
             @i_detalle       = @w_error_msg
   --print "ERROR: " +  @w_error_msg
   select @w_empresa = 1
end 

-- Depuracion de la data por fecha de proceso
----------------------------------------------------
/*if exists ( select 1 
            from cobis..etl_cuadre_extraccion_cobis
            where cec_fecha_proceso = @i_fecha
              and cec_modulo        = @w_modulo
              and (cec_tabla_fuente = @i_tabla_fuente 
               or @i_tabla_fuente   = ''))
begin*/
   delete cobis..etl_cuadre_extraccion_cobis
   where cec_fecha_proceso = @i_fecha
     and cec_modulo = @w_modulo
     /*and (cec_tabla_fuente = @i_tabla_fuente 
      or @i_tabla_fuente = '')
end
*/

  
/**********************************/
/*     TABLA: cl_ex_funcionario   */
/**********************************/

if @i_tabla_fuente = 'cl_ex_funcionario' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente = 'cl_funcionario'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select  @w_campo_criterio =  9,  
           @w_valor_criterio = '0',
           @w_valor          =  0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cl_ex_funcionario
   where fu_funcionario >= 0

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
     -- Concatenar la informacion a enviar al registro del log
     select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
     exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   
   -- FIN DE CUADRE DEL TOTAL

   -- CUADRE POR ESTADO --
   -- Inicializacion de campos
   select @w_campo_criterio = 2,  
          @w_valor_criterio = '0',
          @w_valor          = 0
   
   declare crsr_tabla cursor
   for
      select isnull(count(1),0),isnull(convert(varchar(64),fu_estado),'0'),0
      from cobis..cl_ex_funcionario
      where fu_funcionario >= 0
      group by fu_estado
   
   open crsr_tabla
   fetch crsr_tabla
   into @w_numero_reg, @w_valor_criterio, @w_valor             

   while (@@fetch_status = 0)  --sqlstatus: mig syb-sqls 11032016
   begin
      insert into etl_cuadre_extraccion_cobis
         (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
          cec_campo_criterio, cec_valor_criterio, cec_num_reg,
          cec_valor,   cec_empresa )
      values
         (@i_fecha, @w_modulo,  @w_tabla_fuente,
          @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
          @w_valor,   @w_empresa)
 
      if @@error != 0
      begin
         select @w_error_msg = @w_tabla_fuente +  ' ' + convert(char(2),@w_campo_criterio) + ' ' + @w_valor_criterio
         --close crsr_tabla
         --deallocate crsr_tabla
         exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
      end
   
      select @w_numero_reg     = null, 
             @w_valor_criterio = '0', 
             @w_valor          = 0
             
      fetch crsr_tabla
      into @w_numero_reg, @w_valor_criterio, @w_valor  
   end  

   close crsr_tabla
   deallocate crsr_tabla
   -- Fin de Cuadre por Estado
 
   -- CUADRE POR OFICINA --

   -- Inicializacion de campos
   select @w_campo_criterio = 3,  
          @w_valor_criterio = '0',
          @w_valor          = 0
   
   declare crsr_tabla cursor
   for
      select isnull(count(1),0),isnull(convert(varchar(64),fu_oficina),'0'),0
      from cobis..cl_ex_funcionario
      where fu_funcionario >= 0
      group by fu_oficina
   
   open crsr_tabla
   fetch crsr_tabla
   into @w_numero_reg, @w_valor_criterio, @w_valor             

   while (@@fetch_status = 0)   --sqlstatus: mig syb-sqls 11032016
   begin
      insert into etl_cuadre_extraccion_cobis
         (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
          cec_campo_criterio, cec_valor_criterio, cec_num_reg,
          cec_valor,   cec_empresa )
      values
         (@i_fecha, @w_modulo,  @w_tabla_fuente,
          @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
          @w_valor,   @w_empresa)
  
      if @@error != 0
      begin
         select @w_error_msg = @w_tabla_fuente +  ' ' + convert(char(2),@w_campo_criterio) + ' ' + @w_valor_criterio
         --close crsr_tabla
         --deallocate crsr_tabla
         exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
      end
   
      select @w_numero_reg     = null, 
             @w_valor_criterio = '0', 
             @w_valor          = 0
             
      fetch crsr_tabla
      into @w_numero_reg, @w_valor_criterio, @w_valor  
   end  

   close crsr_tabla
   deallocate crsr_tabla

   -- Fin de Cuadre por Oficina
end

/**********************************/
/*     TABLA: cc_ex_oficial       */
/**********************************/

if @i_tabla_fuente = 'cc_ex_oficial' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cc_oficial'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cobis..cc_ex_oficial
   where oc_oficial > 0

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL

   -- CUADRE POR OFICINA --
   -- Inicializacion de campos
   select @w_campo_criterio = 3,  
          @w_valor_criterio = '0',
          @w_valor          = 0
   
   declare crsr_tabla cursor
   for
      select isnull(count(1),0),isnull(convert(varchar(64),fu_oficina),'0'),0
      from cobis..cc_ex_oficial,cobis..cl_ex_funcionario
      where oc_funcionario = fu_funcionario
        and oc_oficial > 0
      group by fu_oficina
    
   open crsr_tabla
   fetch crsr_tabla
   into @w_numero_reg, @w_valor_criterio, @w_valor             

   while (@@fetch_status = 0)   --sqlstatus: mig syb-sqls 11032016
   begin
      insert into etl_cuadre_extraccion_cobis
         (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
          cec_campo_criterio, cec_valor_criterio, cec_num_reg,
          cec_valor,   cec_empresa )
      values
         (@i_fecha, @w_modulo,  @w_tabla_fuente,
          @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
          @w_valor,   @w_empresa)
  
      if @@error != 0
      begin
         select @w_error_msg = @w_tabla_fuente +  ' ' + convert(char(2),@w_campo_criterio) + ' ' + @w_valor_criterio
         --close crsr_tabla
         --deallocate crsr_tabla
         exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
      end
  
      select @w_numero_reg     = null, 
             @w_valor_criterio = '0', 
             @w_valor          = 0
             
      fetch crsr_tabla
      into @w_numero_reg, @w_valor_criterio, @w_valor  
   end  
   close crsr_tabla
   deallocate crsr_tabla

   -- Fin de Cuadre por Oficina
end

/**********************************/
/*     TABLA: cl_ex_catalogo      */
/**********************************/

if @i_tabla_fuente = 'cl_ex_catalogo' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cl_catalogo'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cobis..cl_ex_catalogo

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
     -- Concatenar la informacion a enviar al registro del log
     select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
     exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL

   -- CUADRE POR ESTADO --
   -- Inicializacion de campos
   select @w_campo_criterio = 2,  
          @w_valor_criterio = '0',
          @w_valor          = 0
   
   declare crsr_tabla cursor
   for
      select isnull(count(1),0),isnull(convert(varchar(64),estado),'0'),0
      from cobis..cl_ex_catalogo
      group by estado
   
   open crsr_tabla
   fetch crsr_tabla
   into @w_numero_reg, @w_valor_criterio, @w_valor             

   while (@@fetch_status = 0)   --sqlstatus: mig syb-sqls 11032016
   begin
      insert into etl_cuadre_extraccion_cobis
         (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
          cec_campo_criterio, cec_valor_criterio, cec_num_reg,
          cec_valor,   cec_empresa )
      values
         (@i_fecha, @w_modulo,  @w_tabla_fuente,
          @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
          @w_valor,   @w_empresa)

      -- Si hubo error, no se pudo insertar
      if @@error != 0
      begin
         -- Concatenar la informacion a enviar al registro del log
         select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
         --close crsr_tabla
         --deallocate crsr_tabla
         exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
      end
   
      select @w_numero_reg     = null, 
             @w_valor_criterio = '0', 
             @w_valor          = 0
             
      fetch crsr_tabla
      into @w_numero_reg, @w_valor_criterio, @w_valor  
   end  
   close crsr_tabla
   deallocate crsr_tabla

   -- Fin de Cuadre por Estado
end

/**********************************/
/*     TABLA: cl_ex_moneda        */
/**********************************/

if @i_tabla_fuente = 'cl_ex_moneda' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cl_moneda'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cobis..cl_ex_moneda

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL

   -- CUADRE POR ESTADO --
   -- Inicializacion de campos
   select @w_campo_criterio = 2,  
          @w_valor_criterio = '0',
          @w_valor          = 0
   
   declare crsr_tabla cursor
   for
      select isnull(count(1),0),isnull(convert(varchar(64),mo_estado),'0'),0
      from cobis..cl_ex_moneda
      group by mo_estado
   
   open crsr_tabla
   fetch crsr_tabla
   into @w_numero_reg, @w_valor_criterio, @w_valor             
   
   while (@@fetch_status = 0)  --sqlstatus: mig syb-sqls 11032016
   begin
      insert into etl_cuadre_extraccion_cobis
         (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
          cec_campo_criterio, cec_valor_criterio, cec_num_reg,
          cec_valor,   cec_empresa )
      values
         (@i_fecha, @w_modulo,  @w_tabla_fuente,
          @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
          @w_valor,   @w_empresa)

      -- Si hubo error, no se pudo insertar
      if @@error != 0
      begin
         -- Concatenar la informacion a enviar al registro del log
         select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
         close crsr_tabla
         deallocate crsr_tabla
         exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
      end
   
      select @w_numero_reg     = null, 
             @w_valor_criterio = '0', 
             @w_valor          = 0
             
      fetch crsr_tabla
      into @w_numero_reg, @w_valor_criterio, @w_valor  
   end  
   close crsr_tabla
   deallocate crsr_tabla
   -- Fin de Cuadre por Estado
end

/**********************************/
/*     TABLA: cl_ex_oficina       */
/**********************************/

if @i_tabla_fuente = 'cl_ex_oficina' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cl_oficina'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cobis..cl_ex_oficina
 
   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/**********************************/
/*     TABLA: cl_ex_tabla         */
/**********************************/

if @i_tabla_fuente = 'cl_ex_tabla' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cl_tabla'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cobis..cl_ex_tabla

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/**************************************/
/*     TABLA: cl_ex_ttransaccion      */
/**************************************/

if @i_tabla_fuente = 'cl_ex_ttransaccion' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cl_ttransaccion'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cobis..cl_ex_ttransaccion

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/**************************************/
/*     TABLA: cl_ex_parametro         */
/**************************************/

if @i_tabla_fuente = 'cl_ex_parametro' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cl_parametro'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cobis..cl_ex_parametro

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/***********************************/
/*     TABLA: cl_ex_pais           */
/***********************************/

if @i_tabla_fuente = 'cl_ex_pais' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cl_pais'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cl_ex_pais

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/*******************************************/
/*     TABLA: cl_ex_departamento           */
/*******************************************/
/*
if @i_tabla_fuente = 'cl_ex_departamento' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cl_depart_pais'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cl_ex_pais

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end
*/

/***********************************/
/*     TABLA: cl_ex_provincia      */
/***********************************/

if @i_tabla_fuente = 'cl_ex_provincia' or @i_tabla_fuente = ''
begin  
   select @w_tabla_fuente   = 'cl_provincia'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cl_ex_provincia

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log  
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/***********************************/
/*     TABLA: cl_ex_municipio      */
/***********************************/

if @i_tabla_fuente = 'cl_ex_municipio' or @i_tabla_fuente = ''
begin  
   select @w_tabla_fuente   = 'cl_municipio'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cl_ex_provincia

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log  
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/***********************************/
/*     TABLA: cl_ex_canton         */
/***********************************/

if @i_tabla_fuente = 'cl_ex_canton' or @i_tabla_fuente = ''
begin  
   select @w_tabla_fuente   = 'cl_canton'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cl_ex_provincia

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log  
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end


/***********************************/
/*     TABLA: cl_ex_ciudad         */
/***********************************/

if @i_tabla_fuente = 'cl_ex_ciudad' or @i_tabla_fuente = ''
begin   
   select @w_tabla_fuente   = 'cl_ciudad'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cl_ex_ciudad

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/**************************************/
/*     TABLA: cl_ex_dias_feriados     */
/**************************************/

if @i_tabla_fuente = 'cl_ex_dias_feriados' or @i_tabla_fuente = ''
begin   
   select @w_tabla_fuente   = 'cl_dias_feriados'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          =  0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cl_ex_dias_feriados

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/***********************************/
/*     TABLA: cb_ex_area           */
/***********************************/

if @i_tabla_fuente = 'cb_ex_area' or @i_tabla_fuente = ''
begin   
   select @w_tabla_fuente   = 'cb_area'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Insercion de los datos
	insert into cobis..etl_cuadre_extraccion_cobis
      select ar_empresa,@i_fecha, @w_modulo,
             @w_tabla_fuente, @w_campo_criterio, '0',
             isnull(count(1),0), 0
      from cob_conta..cb_ex_area 
      group by ar_empresa
      order by ar_empresa

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/***********************************/
/*     TABLA: cb_ex_cotizacion     */
/***********************************/

if @i_tabla_fuente = 'cb_ex_cotizacion' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cb_cotizacion'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          =  0

   -- Insercion de los datos
   insert into cobis..etl_cuadre_extraccion_cobis
   select ct_empresa,@i_fecha, @w_modulo,
          @w_tabla_fuente, @w_campo_criterio, '0',
          isnull(count(1),0), 0
   from cob_conta..cb_ex_cotizacion
   group by ct_empresa
   order by ct_empresa

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/***********************************/
/*     TABLA: cb_ex_oficina        */
/***********************************/

if @i_tabla_fuente = 'cb_ex_oficina' or @i_tabla_fuente = ''
begin   
   select @w_tabla_fuente   = 'cb_oficina'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0
 
   -- Insercion de los datos
   insert into cobis..etl_cuadre_extraccion_cobis
   select of_empresa,@i_fecha, @w_modulo,
          @w_tabla_fuente, @w_campo_criterio, '0',
          isnull(count(1),0), 0
   from cob_conta..cb_ex_oficina
   group by of_empresa
   order by of_empresa

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/***********************************/
/*     TABLA: cb_ex_cuenta         */
/***********************************/

if @i_tabla_fuente = 'cb_ex_cuenta' or @i_tabla_fuente = ''
begin  
   select @w_tabla_fuente   = 'cb_cuenta'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0
  

   -- Insercion de los datos
   insert into cobis..etl_cuadre_extraccion_cobis
   select cu_empresa,@i_fecha, @w_modulo,
          @w_tabla_fuente, @w_campo_criterio, '0',
          isnull(count(1),0), 0
   from cob_conta..cb_ex_cuenta
   group by cu_empresa
   order by cu_empresa

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/***********************************/
/*     TABLA: cb_ex_empresa        */
/***********************************/

if @i_tabla_fuente = 'cb_ex_empresa' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cb_empresa'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0,
		  @w_empresa_cb		= 0

   DECLARE crsr_cb_empresa cursor for
   -- Contador de registros por el total general
   select em_empresa, isnull(count(1),0)
   from cob_conta..cb_ex_empresa
   group by em_empresa

   open crsr_cb_empresa
   Fetch crsr_cb_empresa
	Into @w_empresa_cb, @w_numero_reg
	
   While (@@fetch_status = 0)   --sqlstatus: mig syb-sqls 11032016
   Begin /**** Inicio del While ****/ 
   
   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa_cb)
 
   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg 
   end
   
   Fetch crsr_cb_empresa
   Into @w_empresa_cb, @w_numero_reg
  End
  
  Close crsr_cb_empresa
  deallocate crsr_cb_empresa

end
 -- FIN DE CUADRE DEL TOTAL
 
/***********************************/
/*     TABLA: cb_ex_perfil         */
/***********************************/

if @i_tabla_fuente = 'cb_ex_perfil' or @i_tabla_fuente = ''
begin  
   select @w_tabla_fuente   = 'cb_perfil'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   insert into cobis..etl_cuadre_extraccion_cobis
      select pe_empresa,@i_fecha, @w_modulo, 
             @w_tabla_fuente, @w_campo_criterio, '0',
             isnull(count(1),0), 0
      from cob_conta..cb_ex_perfil
      group by pe_empresa
      order by pe_empresa

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/***********************************/
/*     TABLA: cb_ex_det_perfil     */
/***********************************/

if @i_tabla_fuente = 'cb_ex_det_perfil' or @i_tabla_fuente = ''
begin  
   select @w_tabla_fuente   = 'cb_det_perfil'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   insert into cobis..etl_cuadre_extraccion_cobis
      select dp_empresa,@i_fecha, @w_modulo, 
             @w_tabla_fuente, @w_campo_criterio, '0',
             isnull(count(1),0), 0
      from cob_conta..cb_ex_det_perfil
      group by dp_empresa
      order by dp_empresa

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/***********************************/
/*     TABLA: cb_ex_parametro      */
/***********************************/

if @i_tabla_fuente = 'cb_ex_parametro' or @i_tabla_fuente = ''
begin  
   select @w_tabla_fuente   = 'cb_parametro'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   insert into cobis..etl_cuadre_extraccion_cobis
      select pa_empresa,@i_fecha, @w_modulo, 
             @w_tabla_fuente, @w_campo_criterio, '0',
             isnull(count(1),0), 0
      from cob_conta..cb_ex_parametro
      group by pa_empresa
      order by pa_empresa

    -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end
  
/***********************************/
/*     TABLA: cb_ex_relparam       */
/***********************************/

if @i_tabla_fuente = 'cb_ex_relparam' or @i_tabla_fuente = ''
begin  
   select @w_tabla_fuente   = 'cb_relparam'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   insert into cobis..etl_cuadre_extraccion_cobis
      select re_empresa,@i_fecha, @w_modulo, 
             @w_tabla_fuente, @w_campo_criterio, '0',
             isnull(count(1),0), 0
      from cob_conta..cb_ex_relparam
      group by re_empresa
      order by re_empresa

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end


/***********************************/
/*     TABLA: cb_ex_relofi       */
/***********************************/

if @i_tabla_fuente = 'cb_ex_relofi' or @i_tabla_fuente = ''
begin  
   select @w_tabla_fuente   = 'cb_relofi'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   insert into cobis..etl_cuadre_extraccion_cobis
      select re_empresa,@i_fecha, @w_modulo, 
             @w_tabla_fuente, @w_campo_criterio, '0',
             isnull(count(1),0), 0
      from cob_conta..cb_ex_relofi
      group by re_empresa
      order by re_empresa

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end


/**************************************/
/*     TABLA: cu_ex_tipo_custodia     */
/**************************************/

if @i_tabla_fuente = 'cu_ex_tipo_custodia' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'cu_tipo_custodia'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cob_custodia..cu_ex_tipo_custodia

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/**************************************/
/*     TABLA: pf_ex_tipo_deposito     */
/**************************************/
/*
if @i_tabla_fuente = 'pf_ex_tipo_deposito' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'pf_tipo_deposito'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cob_pfijo..pf_ex_tipo_deposito

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

*/
/**************************************/
/*     TABLA: pf_ex_fpago     */
/**************************************/
/*
if @i_tabla_fuente = 'pf_ex_fpago' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'pf_fpago'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cob_pfijo..pf_ex_fpago

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end
*/
/**************************************/
/*     TABLA: sb_ex_rubros     */
/**************************************/

if @i_tabla_fuente = 'sb_ex_rubros' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'sb_rubros'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cob_sbancarios..sb_ex_rubros

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end


/**************************************/
/*     TABLA: sb_ex_instrumentos     */
/**************************************/

if @i_tabla_fuente = 'sb_ex_instrumentos' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'sb_instrumentos'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cob_sbancarios..sb_ex_instrumentos

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/**************************************/
/*     TABLA: sb_ex_subtipos_ins     */
/**************************************/

if @i_tabla_fuente = 'sb_ex_subtipos_ins' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'sb_subtipos_ins'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cob_sbancarios..sb_ex_subtipos_ins

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/**************************************/
/*     TABLA: sb_ex_productos     */
/**************************************/

if @i_tabla_fuente = 'sb_ex_productos' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'sb_productos'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cob_sbancarios..sb_ex_productos

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end


	/********************************************/
	/* TABLA PF_PPAGO -- CRITERIO TOTAL GENERAL */
	/********************************************/		
/*
	if @i_tabla_fuente = 'pf_ex_ppago' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'pf_ppago'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

	select @w_numero_reg = isnull(count(1),0)
	from cob_pfijo..pf_ex_ppago
        	
	
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)
   
	-- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end
*/
/********************************************/
	/* TABLA PF_PLAZO -- CRITERIO TOTAL GENERAL */
	/********************************************/		
--	if @i_tabla_fuente = 'pf_ex_plazo' or @i_tabla_fuente = ''
--begin
--   select @w_tabla_fuente   = 'pf_plazo'
--
   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
--   select @w_campo_criterio =  9,  
--          @w_valor_criterio = '0',
--          @w_valor          = 0
--
--	select @w_numero_reg = isnull(count(1),0)
--	from cob_pfijo..pf_ex_plazo
        	
--   insert into etl_cuadre_extraccion_cobis
--      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
--       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
--       cec_valor,   cec_empresa )
--   values
--      (@i_fecha, @w_modulo,  @w_tabla_fuente,
--       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
--       @w_valor,   @w_empresa)
--   
	-- Si hubo error, no se pudo insertar
--   if @@error != 0
--   begin
      -- Concatenar la informacion a enviar al registro del log
--      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
--      exec @w_return = cobis..sp_ba_error_log
--             @i_sarta         = @i_sarta,
--             @i_batch         = @i_batch,
--             @i_secuencial    = @i_secuencial,
--             @i_corrida       = @i_corrida,
--             @i_intento       = @i_intento,
--             @i_error         = 808070,
--             @i_detalle       = @w_error_msg
--   end
   -- FIN DE CUADRE DEL TOTAL
--end

/**************************************/
/*     TABLA: pe_ex_pro_bancario      */
/**************************************/

if @i_tabla_fuente = 'pe_ex_pro_bancario' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'pe_pro_bancario'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cob_remesas..pe_ex_pro_bancario

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)
 
   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg 
   end
   -- FIN DE CUADRE DEL TOTAL
end

/***********************************/
/*     TABLA: pe_ex_mercado        */
/***********************************/

if @i_tabla_fuente = 'pe_ex_mercado' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'pe_mercado'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cob_remesas..pe_ex_mercado

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/**************************************/
/*     TABLA: pe_ex_pro_final         */
/**************************************/

if @i_tabla_fuente = 'pe_ex_pro_final' or @i_tabla_fuente = ''
begin
   select @w_tabla_fuente   = 'pe_pro_final'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cob_remesas..pe_ex_pro_final

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL
end

/**************************************/
/*     TABLA: re_ex_tran_contable     */
/**************************************/
if @i_tabla_fuente = 're_ex_tran_contable' or @i_tabla_fuente = ''
begin   
   select @w_tabla_fuente   = 're_tran_contable'

   -- CUADRE POR TOTAL GENERAL --
   -- Inicializacion de variables
   select @w_campo_criterio =  9,  
          @w_valor_criterio = '0',
          @w_valor          = 0

   -- Contador de registros por el total general
   select @w_numero_reg = isnull(count(1),0)
   from cob_remesas..re_ex_tran_contable
   where tc_empresa = @w_empresa

   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   values
      (@i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, @w_valor_criterio, @w_numero_reg,
       @w_valor,   @w_empresa)

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE DEL TOTAL


  -- CUADRE POR TIPO TRANSACCION --
   -- Inicializacion de variables
   select @w_campo_criterio =  6,  
          @w_valor_criterio = '0',
          @w_valor          = 0


   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   select
       @i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, isnull(convert(varchar,tc_tipo_tran),'0'), isnull(count(1),0) ,
       @w_valor,   @w_empresa
   from cob_remesas..re_ex_tran_contable
   where tc_empresa = @w_empresa
    group by tc_empresa ,tc_tipo_tran
  

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE TIPO TRANSACCION


   -- CUADRE POR ESTADO --
   -- Inicializacion de variables
   select @w_campo_criterio =  2,  
          @w_valor_criterio = '0',
          @w_valor          = 0


   -- Insercion de los datos
   insert into etl_cuadre_extraccion_cobis
      (cec_fecha_proceso, cec_modulo ,  cec_tabla_fuente,
       cec_campo_criterio, cec_valor_criterio, cec_num_reg,
       cec_valor,   cec_empresa )
   select
       @i_fecha, @w_modulo,  @w_tabla_fuente,
       @w_campo_criterio, tc_estado, isnull(count(1),0),
       @w_valor,   @w_empresa
   from cob_remesas..re_ex_tran_contable
   where tc_empresa = @w_empresa
   group by tc_empresa ,tc_estado
  

   -- Si hubo error, no se pudo insertar
   if @@error != 0
   begin
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   end
   -- FIN DE CUADRE POR ESTADO



end

/*********************************************/
/*        CUADRE TABLAS cob_comext           */
/*********************************************/

/*********************************************/
/*   TABLA: ce_ex_concepto_transferencias    */
/*********************************************/

if @i_tabla_fuente = 'ce_ex_concepto_transferencias' or @i_tabla_fuente = ''
begin 
   -- CUADRE POR TOTAL GENERAL --  
   SELECT @w_tabla_fuente   = 'ce_concepto_transferencias',
          @w_campo_criterio = 9,
          @w_valor_criterio = '0',
          @w_valor          =  0  
  
   insert into cobis..etl_cuadre_extraccion_cobis
   select  ct_empresa, @i_fecha, @w_modulo, @w_tabla_fuente,
           @w_campo_criterio, @w_valor_criterio, isnull(count(1),0),
           @w_valor 
   FROM cob_comext..ce_ex_concepto_transferencias
   group by ct_empresa
   
   IF @@error != 0
   BEGIN
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   END
end

/*********************************************/
/*              TABLA: ce_ex_banco           */
/*********************************************/

if @i_tabla_fuente = 'ce_ex_banco' or @i_tabla_fuente = ''
begin 
   -- CUADRE POR TOTAL GENERAL --   
   SELECT @w_tabla_fuente   = 'ce_banco',
          @w_campo_criterio = 9,
          @w_valor_criterio = '0',
          @w_valor          =  0
  
   insert into cobis..etl_cuadre_extraccion_cobis
   select  bc_empresa, @i_fecha, @w_modulo, @w_tabla_fuente,
           @w_campo_criterio, @w_valor_criterio, isnull(count(1),0),
           @w_valor 
   FROM cob_comext..ce_ex_banco
   group by bc_empresa
     
  
   IF @@error != 0
   BEGIN
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   END
end  

/*********************************************/
/*             TABLA: ce_ex_oficina          */
/*********************************************/

if @i_tabla_fuente = 'ce_ex_oficina' or @i_tabla_fuente = ''
begin 
   --  CUADRE POR TOTAL GENERAL  --      
   SELECT @w_tabla_fuente   = 'ce_oficina',
          @w_campo_criterio = 9,
          @w_valor_criterio = '0',
          @w_valor          =  0
  
   insert into cobis..etl_cuadre_extraccion_cobis
   select  of_empresa, @i_fecha, @w_modulo, @w_tabla_fuente,
           @w_campo_criterio, @w_valor_criterio, isnull(count(1),0),
           @w_valor 
   FROM cob_comext..ce_ex_oficina
   group by of_empresa
     
   IF @@error != 0
   BEGIN
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   END
end
  
/*********************************************/
/*          TABLA: ce_ex_cuenta_bancaria     */
/*********************************************/
if @i_tabla_fuente = 'ce_ex_cuenta_bancaria' or @i_tabla_fuente = ''
begin 
   --  CUADRE POR TOTAL GENERAL  --   
   SELECT @w_tabla_fuente   = 'ce_cuenta_bancaria',
          @w_campo_criterio = 9,
          @w_valor_criterio = '0',
          @w_valor          =  0
  
   insert into cobis..etl_cuadre_extraccion_cobis
   select  bn_empresa, @i_fecha, @w_modulo, @w_tabla_fuente,
           @w_campo_criterio, @w_valor_criterio, isnull(count(1),0),
           @w_valor 
   FROM cob_comext..ce_ex_cuenta_bancaria
   group by bn_empresa
   
   IF @@error != 0
   BEGIN
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   END
       
   --  CUADRE POR TOTAL MONEDA  --   
   SELECT @w_tabla_fuente   = 'ce_cuenta_bancaria',
          @w_campo_criterio = 1,
          @w_valor_criterio = '0',
          @w_valor          =  0,
          @w_empresa        =  0
   
   DECLARE crsr_tabla cursor
   FOR
      SELECT bn_empresa, isnull(count(1),0), isnull(convert(varchar,bn_moneda),'0'), count(1)
        FROM cob_comext..ce_ex_cuenta_bancaria
       GROUP BY bn_empresa, bn_moneda

    OPEN crsr_tabla
   FETCH crsr_tabla
    INTO @w_empresa, @w_numero_reg, @w_valor_criterio, @w_valor             
    
   WHILE (@@fetch_status = 0)   --sqlstatus: mig syb-sqls 11032016
   BEGIN /**** Inicio del While ****/   

      insert into cobis..etl_cuadre_extraccion_cobis             
	(cec_fecha_proceso,   cec_modulo,         cec_tabla_fuente,
	 cec_campo_criterio,  cec_valor_criterio, cec_num_reg,     
	 cec_valor,           cec_empresa)                         
      VALUES                                                     
	(@i_fecha,            @w_modulo,          @w_tabla_fuente, 
	 @w_campo_criterio,   @w_valor_criterio,  @w_numero_reg,   
	 @w_valor,            @w_empresa)                          

      IF @@error != 0
      BEGIN
         -- Concatenar la informacion a enviar al registro del log
         select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
         exec @w_return = cobis..sp_ba_error_log
                @i_sarta         = @i_sarta,
                @i_batch         = @i_batch,
                @i_secuencial    = @i_secuencial,
                @i_corrida       = @i_corrida,
                @i_intento       = @i_intento,
                @i_error         = 808070,
                @i_detalle       = @w_error_msg
      END
      
      FETCH crsr_tabla
      INTO @w_empresa, @w_numero_reg, @w_valor_criterio, @w_valor  
   END /**** Fin del While ****/ 
   
   CLOSE crsr_tabla
   deallocate crsr_tabla
end


/*********************************************/
/*          TABLA: ce_ex_oficina_rol         */
/*********************************************/
if @i_tabla_fuente = 'ce_ex_oficina_rol' or @i_tabla_fuente = ''
begin 
   --  CUADRE POR TOTAL GENERAL  --   
   SELECT @w_tabla_fuente   = 'ce_oficina_rol',
          @w_campo_criterio = 9,
          @w_valor_criterio = '0',
          @w_valor          =  0
  
   insert into cobis..etl_cuadre_extraccion_cobis
   select  or_empresa, @i_fecha, @w_modulo, @w_tabla_fuente,
           @w_campo_criterio, @w_valor_criterio, isnull(count(1),0),
           @w_valor 
   FROM cob_comext..ce_ex_oficina_rol
   group by or_empresa

   IF @@error != 0
   BEGIN
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   END
       
   --  CUADRE POR ROL --iro, PUSE EL MISMO 2 DE ESTADO   
   SELECT @w_tabla_fuente   = 'ce_oficina_rol',
          @w_campo_criterio = 2,
          @w_valor_criterio = '0',
          @w_valor          =  0,
	  @w_empresa        =  0
   
   DECLARE crsr_tabla cursor
   FOR
      SELECT or_empresa, isnull(count(1),0), isnull(or_rol,'0')
        FROM cob_comext..ce_ex_oficina_rol
       GROUP BY or_empresa, or_rol
   
    OPEN crsr_tabla
   FETCH crsr_tabla
    INTO @w_empresa, @w_numero_reg, @w_valor_criterio

   WHILE (@@fetch_status = 0)   --sqlstatus: mig syb-sqls 11032016
   BEGIN /**** Inicio del While ****/   

      insert into cobis..etl_cuadre_extraccion_cobis                       
       (cec_fecha_proceso,   cec_modulo,         cec_tabla_fuente,          
        cec_campo_criterio,  cec_valor_criterio, cec_num_reg,               
        cec_valor,           cec_empresa)                                   
      VALUES                                                               
       (@i_fecha,          @w_modulo,          @w_tabla_fuente,           
        @w_campo_criterio,   @w_valor_criterio,  @w_numero_reg,             
        @w_valor,            @w_empresa)                                    
  
      IF @@error != 0
      BEGIN
         -- Concatenar la informacion a enviar al registro del log
         select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
         exec @w_return = cobis..sp_ba_error_log
                @i_sarta         = @i_sarta,
                @i_batch         = @i_batch,
                @i_secuencial    = @i_secuencial,
                @i_corrida       = @i_corrida,
                @i_intento       = @i_intento,
                @i_error         = 808070,
                @i_detalle       = @w_error_msg
      END
   
      FETCH crsr_tabla
      INTO @w_empresa, @w_numero_reg, @w_valor_criterio
   END /**** Fin del While ****/    

   CLOSE crsr_tabla
   deallocate crsr_tabla
end


/*********************************************/
/*          TABLA: ce_ex_uso_lc              */
/*********************************************/
if @i_tabla_fuente = 'ce_ex_uso_lc' or @i_tabla_fuente = ''
begin 
   --  CUADRE POR TOTAL GENERAL  -- 
   
   SELECT @w_tabla_fuente   = 'ce_uso_lc',
          @w_campo_criterio = 9,
          @w_valor_criterio = '0',
          @w_valor          =  0      
  
   insert into cobis..etl_cuadre_extraccion_cobis
   select  us_empresa, @i_fecha, @w_modulo, @w_tabla_fuente,
           @w_campo_criterio, @w_valor_criterio, isnull(count(1),0),
           @w_valor 
   FROM cob_comext..ce_ex_uso_lc
   group by us_empresa
   
   IF @@error != 0
   BEGIN
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   END
 
   --  CUADRE POR USO  --iro, PUSE EL MISMO 2 DE ESTADO   
   SELECT @w_tabla_fuente   = 'ce_uso_lc',
          @w_campo_criterio = 2,
          @w_valor_criterio = '0',
          @w_valor          =  0,
	  @w_empresa        =  0
	      
   DECLARE crsr_tabla cursor
   FOR
      SELECT us_empresa, isnull(count(1),0), isnull(us_tipo_uso,'0'), sum(us_valor_asignado)
        FROM cob_comext..ce_ex_uso_lc
       GROUP BY us_empresa, us_tipo_uso

    OPEN crsr_tabla
   FETCH crsr_tabla
    INTO @w_empresa, @w_numero_reg, @w_valor_criterio, @w_valor             
    
   WHILE (@@fetch_status = 0)  --sqlstatus: mig syb-sqls 11032016
   BEGIN /**** Inicio del While ****/   

      insert into cobis..etl_cuadre_extraccion_cobis             
	(cec_fecha_proceso,   cec_modulo,         cec_tabla_fuente,
	 cec_campo_criterio,  cec_valor_criterio, cec_num_reg,     
	 cec_valor,           cec_empresa)                         
      VALUES                                                     
	(@i_fecha,          @w_modulo,          @w_tabla_fuente, 
	 @w_campo_criterio,   @w_valor_criterio,  @w_numero_reg,   
	 @w_valor,            @w_empresa)                          

      IF @@error != 0
      BEGIN
         -- Concatenar la informacion a enviar al registro del log
         select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
         exec @w_return = cobis..sp_ba_error_log
                @i_sarta         = @i_sarta,
                @i_batch         = @i_batch,
                @i_secuencial    = @i_secuencial,
                @i_corrida       = @i_corrida,
                @i_intento       = @i_intento,
                @i_error         = 808070,
                @i_detalle       = @w_error_msg
      END
      
      FETCH crsr_tabla
      INTO @w_empresa, @w_numero_reg, @w_valor_criterio, @w_valor  
   
   END /**** Fin del While ****/ 
   
   CLOSE crsr_tabla
   deallocate crsr_tabla
end


/*********************************************/
/*          TABLA: ce_ex_contacto            */
/*********************************************/
if @i_tabla_fuente = 'ce_ex_contacto' or @i_tabla_fuente = ''
begin 
   --  CUADRE POR TOTAL GENERAL  --    
   SELECT @w_tabla_fuente   = 'ce_contacto',
          @w_campo_criterio = 9,
          @w_valor_criterio = '0',
          @w_valor          =  0      
  
   insert into cobis..etl_cuadre_extraccion_cobis
   select  ct_empresa, @i_fecha, @w_modulo, @w_tabla_fuente,
           @w_campo_criterio, @w_valor_criterio, isnull(count(1),0),
           @w_valor 
   FROM cob_comext..ce_ex_contacto
   group by ct_empresa
   
   IF @@error != 0
   BEGIN
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   END
end
  
/*********************************************/
/*          TABLA: ce_ex_linea_credito       */
/*********************************************/
if @i_tabla_fuente = 'ce_ex_linea_credito' or @i_tabla_fuente = ''
begin 
   --  CUADRE POR TOTAL GENERAL  --    
   SELECT @w_tabla_fuente   = 'ce_linea_credito',
          @w_campo_criterio = 9,
          @w_valor_criterio = '0',
          @w_valor          =  0
     
   insert into cobis..etl_cuadre_extraccion_cobis
   select  lc_empresa, @i_fecha, @w_modulo, @w_tabla_fuente,
           @w_campo_criterio, @w_valor_criterio, isnull(count(1),0),
           @w_valor 
   FROM cob_comext..ce_ex_linea_credito
   group by lc_empresa
   
   IF @@error != 0
   BEGIN
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   END
       
   --  CUADRE POR TOTAL MONEDA  --      
   SELECT @w_tabla_fuente   = 'ce_linea_credito',
          @w_campo_criterio = 1,
          @w_valor_criterio = '0',
          @w_valor          =  0,
          @w_empresa        =  0
   
   DECLARE crsr_tabla cursor
   FOR
      SELECT lc_empresa, isnull(count(1),0), isnull(convert(varchar,lc_moneda_lc),'0'), sum(lc_cupo_asignado)
        FROM cob_comext..ce_ex_linea_credito
       GROUP BY lc_empresa, lc_moneda_lc

    OPEN crsr_tabla
   FETCH crsr_tabla
    INTO @w_empresa, @w_numero_reg, @w_valor_criterio, @w_valor             
    
   WHILE (@@fetch_status = 0)   --sqlstatus: mig syb-sqls 11032016
   BEGIN /**** Inicio del While ****/   

      insert into cobis..etl_cuadre_extraccion_cobis             
	(cec_fecha_proceso,   cec_modulo,         cec_tabla_fuente,
	 cec_campo_criterio,  cec_valor_criterio, cec_num_reg,     
	 cec_valor,           cec_empresa)                         
      VALUES                                                     
	(@i_fecha,          @w_modulo,          @w_tabla_fuente, 
	 @w_campo_criterio,   @w_valor_criterio,  @w_numero_reg,   
	 @w_valor,            @w_empresa)                          

      IF @@error != 0
      BEGIN
         -- Concatenar la informacion a enviar al registro del log
         select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
         exec @w_return = cobis..sp_ba_error_log
                @i_sarta         = @i_sarta,
                @i_batch         = @i_batch,
                @i_secuencial    = @i_secuencial,
                @i_corrida       = @i_corrida,
                @i_intento       = @i_intento,
                @i_error         = 808070,
                @i_detalle       = @w_error_msg
      END
      
      FETCH crsr_tabla
      INTO @w_empresa, @w_numero_reg, @w_valor_criterio, @w_valor  
   
   END /**** Fin del While ****/ 
   
   CLOSE crsr_tabla
   deallocate crsr_tabla
end

/*********************************************/
/*      TABLA: ce_ex_parametro_contable      */
/*********************************************/
if @i_tabla_fuente = 'ce_ex_parametro_contable' or @i_tabla_fuente = ''
begin 
   --  CUADRE POR TOTAL GENERAL  -- 
   SELECT @w_tabla_fuente   = 'ce_parametro_contable',
          @w_campo_criterio = 9,
          @w_valor_criterio = '0',
          @w_valor          =  0   
  
   insert into cobis..etl_cuadre_extraccion_cobis
   select  pt_empresa, @i_fecha, @w_modulo, @w_tabla_fuente,
           @w_campo_criterio, @w_valor_criterio, isnull(count(1),0),
           @w_valor 
   FROM cob_comext..ce_ex_parametro_contable
   group by pt_empresa
   
   IF @@error != 0
   BEGIN
      -- Concatenar la informacion a enviar al registro del log
      select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
   END

   --  CUADRE POR ESTADO  --   
   SELECT @w_tabla_fuente   = 'ce_parametro_contable',
          @w_campo_criterio = 2,
          @w_valor_criterio = '0',
          @w_valor          =  0,
          @w_empresa        =  0
   
   DECLARE crsr_tabla cursor
   FOR
      SELECT pt_empresa, isnull(count(1),0), isnull(pt_estado,'')
        FROM cob_comext..ce_ex_parametro_contable
       GROUP BY pt_empresa, pt_estado
   
    OPEN crsr_tabla
   FETCH crsr_tabla
    INTO @w_empresa, @w_numero_reg, @w_valor_criterio
   
   WHILE (@@fetch_status = 0)   --sqlstatus: mig syb-sqls 11032016
   BEGIN /**** Inicio del While ****/   
        
      insert into cobis..etl_cuadre_extraccion_cobis                        
       (cec_fecha_proceso,   cec_modulo,         cec_tabla_fuente,           
        cec_campo_criterio,  cec_valor_criterio, cec_num_reg,                
        cec_valor,           cec_empresa)                                    
      VALUES                                                                
       (@i_fecha,          @w_modulo,          @w_tabla_fuente,            
        @w_campo_criterio,   @w_valor_criterio,  @w_numero_reg,              
        @w_valor,            @w_empresa)                                     
                                                                             
  
      IF @@error != 0
      BEGIN
         -- Concatenar la informacion a enviar al registro del log
         select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
         exec @w_return = cobis..sp_ba_error_log
                @i_sarta         = @i_sarta,
                @i_batch         = @i_batch,
                @i_secuencial    = @i_secuencial,
                @i_corrida       = @i_corrida,
                @i_intento       = @i_intento,
                @i_error         = 808070,
                @i_detalle       = @w_error_msg
      END           
            
      FETCH crsr_tabla
      INTO @w_empresa, @w_numero_reg, @w_valor_criterio
   
   END /**** Fin del While ****/ 
   
   CLOSE crsr_tabla
   deallocate crsr_tabla
end

/*********************************************/
/*          TABLA: ce_ex_tpago               */
/*********************************************/
if @i_tabla_fuente = 'ce_ex_tpago' or @i_tabla_fuente = ''
begin 
   --  CUADRE POR TOTAL GENERAL  -- 
   SELECT @w_tabla_fuente   = 'ce_tpago',
          @w_campo_criterio = 9,
          @w_valor_criterio = '0',
          @w_valor          =  0,
          @w_empresa        =  0
  
   SELECT @w_empresa    = tg_empresa,
          @w_numero_reg = isnull(count(1),0)
     FROM cob_comext..ce_ex_tpago
     
   if @@rowcount > 0
   begin   
      insert into cobis..etl_cuadre_extraccion_cobis                   
       (cec_fecha_proceso,   cec_modulo,         cec_tabla_fuente,      
	  cec_campo_criterio,  cec_valor_criterio, cec_num_reg,           
	  cec_valor,           cec_empresa)                               
      VALUES                                                           
	 (@i_fecha,          @w_modulo,          @w_tabla_fuente,       
	  @w_campo_criterio,   @w_valor_criterio,  @w_numero_reg,         
	  @w_valor,            @w_empresa)                                
   
      IF @@error != 0
      BEGIN
         -- Concatenar la informacion a enviar al registro del log
         select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
         exec @w_return = cobis..sp_ba_error_log
                @i_sarta         = @i_sarta,
                @i_batch         = @i_batch,
                @i_secuencial    = @i_secuencial,
                @i_corrida       = @i_corrida,
                @i_intento       = @i_intento,
                @i_error         = 808070,
                @i_detalle       = @w_error_msg
      END
   END   
        
   --  CUADRE POR ESTADO  --
   SELECT @w_tabla_fuente   = 'ce_tpago',
          @w_campo_criterio = 2,
          @w_valor_criterio = '0',
          @w_valor          =  0,
          @w_empresa        =  0
   
   DECLARE crsr_tabla cursor
   FOR
      SELECT tg_empresa, isnull(count(1),0),isnull(tg_estado,'')
        FROM cob_comext..ce_ex_tpago
       GROUP BY tg_empresa, tg_estado
   
    OPEN crsr_tabla
   FETCH crsr_tabla
    INTO @w_empresa, @w_numero_reg, @w_valor_criterio
   
   WHILE (@@fetch_status = 0)   --sqlstatus: mig syb-sqls 11032016
   BEGIN /**** Inicio del While ****/   
  
       insert into cobis..etl_cuadre_extraccion_cobis                   
       (cec_fecha_proceso,   cec_modulo,         cec_tabla_fuente,      
        cec_campo_criterio,  cec_valor_criterio, cec_num_reg,           
        cec_valor,           cec_empresa)                               
       VALUES                                                           
       (@i_fecha,          @w_modulo,          @w_tabla_fuente,       
        @w_campo_criterio,   @w_valor_criterio,  @w_numero_reg,         
        @w_valor,            @w_empresa)                                
    
      IF @@error != 0
      BEGIN
         -- Concatenar la informacion a enviar al registro del log
         select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
         exec @w_return = cobis..sp_ba_error_log
                @i_sarta         = @i_sarta,
                @i_batch         = @i_batch,
                @i_secuencial    = @i_secuencial,
                @i_corrida       = @i_corrida,
                @i_intento       = @i_intento,
                @i_error         = 808070,
                @i_detalle       = @w_error_msg
      END           

      FETCH crsr_tabla
      INTO @w_empresa, @w_numero_reg, @w_valor_criterio

   END /**** Fin del While ****/ 
     
   CLOSE crsr_tabla
   deallocate crsr_tabla
end

/*********************************************/
/*          TABLA: ce_ex_plazo               */
/*********************************************/
if @i_tabla_fuente = 'ce_ex_plazo' or @i_tabla_fuente = ''
begin 
   --  CUADRE POR TOTAL GENERAL  -- 
   SELECT @w_tabla_fuente   = 'ce_plazo',
          @w_campo_criterio = 9,
          @w_valor_criterio = '0',
          @w_valor          =  0,
          @w_empresa        =  0
  
   SELECT @w_empresa    = pl_empresa,
          @w_numero_reg = isnull(count(1),0)
     FROM cob_comext..ce_ex_plazo
     
   if @@rowcount > 0
   begin   
      insert into cobis..etl_cuadre_extraccion_cobis                   
     (cec_fecha_proceso,   cec_modulo,         cec_tabla_fuente,      
	  cec_campo_criterio,  cec_valor_criterio, cec_num_reg,           
	  cec_valor,           cec_empresa)                               
      VALUES                                                           
	 (@i_fecha,            @w_modulo,          @w_tabla_fuente,       
	  @w_campo_criterio,   @w_valor_criterio,  @w_numero_reg,         
	  @w_valor,            @w_empresa)                                
   
      IF @@error != 0
      BEGIN
         -- Concatenar la informacion a enviar al registro del log
         select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
         exec @w_return = cobis..sp_ba_error_log
                @i_sarta         = @i_sarta,
                @i_batch         = @i_batch,
                @i_secuencial    = @i_secuencial,
                @i_corrida       = @i_corrida,
                @i_intento       = @i_intento,
                @i_error         = 808070,
                @i_detalle       = @w_error_msg
      END
   END   
        
   --  CUADRE POR ESTADO  --
   SELECT @w_tabla_fuente   = 'ce_plazo',
          @w_campo_criterio = 2,
          @w_valor_criterio = '0',
          @w_valor          =  0,
          @w_empresa        =  0
   
   DECLARE crsr_tabla cursor
   FOR
      SELECT pl_empresa, isnull(count(1),0), isnull(pl_estado,'')
        FROM cob_comext..ce_ex_plazo
       GROUP BY pl_empresa, pl_estado
   
    OPEN crsr_tabla
   FETCH crsr_tabla
    INTO @w_empresa, @w_numero_reg, @w_valor_criterio
   
   WHILE (@@fetch_status = 0)   --sqlstatus: mig syb-sqls 11032016
   BEGIN /**** Inicio del While ****/   
  
       insert into cobis..etl_cuadre_extraccion_cobis                   
       (cec_fecha_proceso,   cec_modulo,         cec_tabla_fuente,      
        cec_campo_criterio,  cec_valor_criterio, cec_num_reg,           
        cec_valor,           cec_empresa)                               
       VALUES                                                           
       (@i_fecha,            @w_modulo,          @w_tabla_fuente,       
        @w_campo_criterio,   @w_valor_criterio,  @w_numero_reg,         
        @w_valor,            @w_empresa)                                
    
      IF @@error != 0
      BEGIN
         -- Concatenar la informacion a enviar al registro del log
         select @w_error_msg = @w_tabla_fuente +  '|' + convert(char(2),@w_campo_criterio) + '|' + @w_valor_criterio
         exec @w_return = cobis..sp_ba_error_log
                @i_sarta         = @i_sarta,
                @i_batch         = @i_batch,
                @i_secuencial    = @i_secuencial,
                @i_corrida       = @i_corrida,
                @i_intento       = @i_intento,
                @i_error         = 808070,
                @i_detalle       = @w_error_msg
      END           

      FETCH crsr_tabla
      INTO @w_empresa, @w_numero_reg, @w_valor_criterio

   END /**** Fin del While ****/ 
     
   CLOSE crsr_tabla
   deallocate crsr_tabla
end

--print 'FINALIZA sp_ad_cuadre ...'
return 0
go
