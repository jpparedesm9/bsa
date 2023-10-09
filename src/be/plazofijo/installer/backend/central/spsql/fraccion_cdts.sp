/************************************************************************/
/*  Archivo:            fraccion_cdts.sp                                */
/*  Stored procedure:   sp_fraccion_cdts                                */
/*  Base de datos:      cob_pfijo                                       */
/*  Disenado por:       Andres Muñoz                                    */
/*  Fecha de escritura: 23-Ago-2012                                     */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCORP'.                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                             PROPOSITO                                */
/*  Este stored procedure genera un archivo plano de los CDTS que han   */
/*  sido fraccionados en el periodo julio de 2011 a julio de 2012.      */
/*                           MODIFICACIONES                             */
/*  FECHA          AUTOR            RAZON                               */
/*  23-Ago-2012    A. Muñoz       Emision Inicial                       */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_fraccion_cdts')
   drop proc sp_fraccion_cdts
go

create proc sp_fraccion_cdts
with encryption
as
declare 
@w_s_app        varchar(255),
@w_path         varchar(255),
@w_nombre       varchar(255),
@w_nombre_cab   varchar(255),
@w_destino      varchar(2500),
@w_errores      varchar(1500),
@w_error        int,
@w_comando      varchar(3500),
@w_nombre_plano varchar(2500),
@w_msg          varchar(255),
@w_col_id       int,
@w_columna      varchar(100),
@w_cabecera     varchar(2500),
@w_nom_tabla    varchar(100),
@w_sp_name      varchar(20),
@w_sec          int, 
@w_opera_h      int, 
@w_opera_p      int,
@w_benef        int,
@w_beneficiario int,
@w_cedula       varchar(20),
@w_nombre_ben   varchar(255),
@w_gmf          money,
@w_tiene        money



set nocount on

select	
'SECUENCIAL'      = convert(varchar(12),fu_operacion)  + convert(varchar(12),fu_secuencial),
'OP_PADRE'        = fu_operacion,
'CDT_PADRE'       = (select op_num_banco from pf_operacion where op_operacion = fu_operacion),
'GMF'             = convert(money, NULL),
'FECHA_FRACCION'  = convert(varchar(11),fu_fecha_crea,106),
'BENEF_PADRE1'    = convert(int, NULL),
'NOMBRE_PADRE1'   = convert(varchar(100), NULL),
'DOC_PADRE1'      = convert(varchar(20), NULL),
'BENEF_PADRE2'    = convert(int, NULL),
'NOMBRE_PADRE2'   = convert(varchar(100), NULL),
'DOC_PADRE2'      = convert(varchar(20), NULL),
'BENEF_PADRE3'    = convert(int, NULL),
'NOMBRE_PADRE3'   = convert(varchar(100), NULL),
'DOC_PADRE3'      = convert(varchar(20), NULL),
'MONTO_PADRE'     = (select op_monto  from pf_operacion where op_operacion = fu_operacion), 
'OP_HIJO'         = fu_operacion_new,
'CDT_HIJO'        = (select op_num_banco from pf_operacion where op_operacion = fu_operacion_new), 
'MONTO_HIJO'      = fu_monto_fusionar
into	#frafu
from	pf_fusfra
where   fu_fecha_crea between '07/01/2011' and '07/01/2012'
order by fu_operacion, fu_secuencial

select *, 'BENEF_HIJO1' = convert(int, NULL), 'BENEF_HIJO2' = convert(int, NULL), 'BENEF_HIJO3' = convert(int, NULL),
'NOMBRE_HIJO1' = convert(varchar(50), NULL), 'DOC_HIJO1' = convert(varchar(20), NULL), 
'NOMBRE_HIJO2' = convert(varchar(50), NULL), 'DOC_HIJO2' = convert(varchar(20), NULL), 
'NOMBRE_HIJO3' = convert(varchar(50), NULL), 'DOC_HIJO3' = convert(varchar(20), NULL) 
into #final
from #frafu

select convert(int, be_ente) as be_ente, 'en_ced_ruc' = convert(varchar(20), NULL), 'en_nomlar' = convert(varchar(50), NULL)
into #benef
from pf_beneficiario 
where 1 = 2

while 1 = 1 begin

   select top 1 
   @w_sec     = SECUENCIAL, 
   @w_opera_h = OP_HIJO,
   @w_opera_p = OP_PADRE
   from	#frafu
   order by SECUENCIAL asc

   if @@rowcount = 0
      break
   
   insert into #benef   
   select be_ente, en_ced_ruc, en_nomlar
   from pf_beneficiario, cobis..cl_ente
   where   be_operacion = @w_opera_p
   and     be_ente = en_ente
   and     be_estado_xren = 'N'
   and     be_estado = 'I'
   and     be_tipo = 'T'
   order by be_ente 
   
   select @w_benef = 0

   /* ACTUALIZA BENEFICIARIOS PADRE */
   while 1 = 1 begin

      select top 1 
      @w_beneficiario = convert(int, be_ente),
      @w_cedula       = convert(varchar(20), en_ced_ruc),
      @w_nombre_ben   = convert(varchar(100), en_nomlar)
      from #benef 
      order by be_ente
      
      if @@rowcount = 0
         break

      select @w_benef = @w_benef + 1

      if @w_benef = 1 begin
         update #final set 
         BENEF_PADRE1   = convert(int, @w_beneficiario),
         DOC_PADRE1     = convert(varchar(20), @w_cedula),
         NOMBRE_PADRE1  = convert(varchar(100), @w_nombre_ben)
         where OP_PADRE = @w_opera_p
      end

      if @w_benef = 2 begin
         update #final set 
         BENEF_PADRE2   = convert(int, @w_beneficiario),
         DOC_PADRE2     = convert(varchar(20), @w_cedula),
         NOMBRE_PADRE2  = convert(varchar(100), @w_nombre_ben)
         where OP_PADRE = @w_opera_p
      end

      if @w_benef = 3 begin
         update #final set 
         BENEF_PADRE3   = convert(int, @w_beneficiario),
         DOC_PADRE3     = convert(varchar(20), @w_cedula),
         NOMBRE_PADRE3  = convert(varchar(100), @w_nombre_ben)
         where OP_PADRE = @w_opera_p
      end
       
      delete from #benef where be_ente = @w_beneficiario
   end --Fin actualizacion padre

   insert into #benef
   select be_ente, en_ced_ruc, en_nomlar
   from   pf_beneficiario, cobis..cl_ente
   where  be_operacion = @w_opera_h
   and    be_ente = en_ente
   and    be_estado_xren = 'N'
   and    be_estado = 'I'
   and    be_tipo = 'T'
   order by be_ente 

   select @w_benef = 0

   /* ACTUALIZA BENEFICIARIOS HIJOS */
   while 1 = 1 begin

      select top 1 
      @w_beneficiario = convert(int, be_ente),
      @w_cedula       = convert(varchar(20), en_ced_ruc),
      @w_nombre_ben   = convert(varchar(100), en_nomlar)
      from #benef 
      order by be_ente
      
      if @@rowcount = 0
         break

      select @w_benef = @w_benef + 1

      if @w_benef = 1 begin
         update #final set 
         BENEF_HIJO1  = convert(int, @w_beneficiario),
         NOMBRE_HIJO1 = convert(varchar(100), @w_nombre_ben),
         DOC_HIJO1    = convert(varchar(20), @w_cedula) 
         where OP_HIJO = @w_opera_h
      end

      if @w_benef = 2 begin
         update #final set 
         BENEF_HIJO2  = convert(int, @w_beneficiario),
         NOMBRE_HIJO2 = convert(varchar(100), @w_nombre_ben),
         DOC_HIJO2    = convert(varchar(20), @w_cedula)
         where OP_HIJO = @w_opera_h
      end

      if @w_benef = 3 begin
         update #final set 
         BENEF_HIJO3 = convert(int, @w_beneficiario),
         NOMBRE_HIJO3 = convert(varchar(100), @w_nombre_ben),
         DOC_HIJO3    = convert(varchar(20), @w_cedula)
         where OP_HIJO = @w_opera_h
      end
       
      delete from #benef where be_ente = @w_beneficiario
   end -- Fin actualizacion hijos
   
   /** ACTUALIZACION GMF PADRE **/
   SELECT @w_gmf = td_monto 
   FROM   pf_transaccion, 
          pf_transaccion_det
   where  tr_operacion = td_operacion
   and  tr_secuencial = td_secuencial
   and  tr_tipo_trn = 'CAN'
   and  tr_tran = 14903
   and  td_concepto = 'GMF'
   and  tr_operacion = @w_opera_p

   select @w_tiene = GMF from #final where OP_PADRE = @w_opera_p and GMF = @w_gmf
 
   /* VALIDA QUE LA OPERACION NO TENGA GMF */
   if @w_tiene is null
   begin
      update #final set 
      GMF = convert(money, @w_gmf)
      where OP_PADRE = @w_opera_p
      and SECUENCIAL = @w_sec
   end
   
   delete from #frafu where SECUENCIAL = @w_sec
   select @w_tiene = null
 
end -- Fin While

if exists (select 1 from sysobjects where name = 'pf_fraccion_cdt' and type = 'U')
   drop table pf_fraccion_cdt 

select 
CDT_PADRE,    GMF,           FECHA_FRACCION, 
BENEF_PADRE1, NOMBRE_PADRE1, DOC_PADRE1, 
BENEF_PADRE2, NOMBRE_PADRE2, DOC_PADRE2, 
BENEF_PADRE3, NOMBRE_PADRE3, DOC_PADRE3, 
MONTO_PADRE,  CDT_HIJO,      MONTO_HIJO, 
BENEF_HIJO1,  NOMBRE_HIJO1,  DOC_HIJO1, 
BENEF_HIJO2,  NOMBRE_HIJO2,  DOC_HIJO2, 
BENEF_HIJO3,  NOMBRE_HIJO3,  DOC_HIJO3 
into pf_fraccion_cdt
from #final

/*** GENERAR BCP ***/

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 14

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select 
@w_nombre       = 'Fraccion_CDTS',
@w_nom_tabla    = 'pf_fraccion_cdt',
@w_col_id       = 0,
@w_columna      = '',
@w_cabecera     = convert(varchar(2000), ''),
@w_nombre_cab   = @w_nombre

select 
@w_nombre_plano = @w_path + @w_nombre_cab + '_' + convert(varchar(2), datepart(dd,getdate())) + '_' + convert(varchar(2), datepart(mm,getdate())) + '_' + convert(varchar(4), datepart(yyyy, getdate())) + '.txt'

while 1 = 1 
begin
   set rowcount 1
   select 
   @w_columna = c.name,
   @w_col_id  = c.colid
   from cob_pfijo..sysobjects o, cob_pfijo..syscolumns c
   where o.id    = c.id
   and   o.name  = @w_nom_tabla
   and   c.colid > @w_col_id
   order by c.colid

   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   select @w_cabecera = @w_cabecera + @w_columna + '^|'
end

select @w_cabecera = left(@w_cabecera, datalength(@w_cabecera) - 2)

--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end

--Ejecucion para Generar Archivo Datos
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_pfijo..pf_fraccion_cdt out '

select 
@w_destino  = @w_path + 'Fraccion_CDTS.txt',
@w_errores  = @w_path + 'Fraccion_CDTS.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error Generando Archivo Fraccion_CDTS' 
end

----------------------------------------
--Union de archivos (cab) y (dat)
----------------------------------------

select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + 'Fraccion_CDTS.txt' + ' ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end

return 0

ERRORFIN: 
   print @w_msg
go