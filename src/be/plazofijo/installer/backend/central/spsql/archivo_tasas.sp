/************************************************************************/
/*  Archivo               : archivo_tasas.sp                            */
/*  Stored procedure      : sp_archivo_tasas                            */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Oscar Saavedra                              */
/*  Fecha de documentacion: 04 de Octubre de 2016                       */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Este programa procesa la carga y mantenimiento de tasas normales y  */
/*  variables                                                           */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR              RAZON                             */
/*  01/Oct/2016    Oscar Saavedra     Emision Inicial DPF-H85256        */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_archivo_tasas')
   drop proc sp_archivo_tasas
go

create proc sp_archivo_tasas(
@s_ssn                    int             = null,
@s_user                   login           = null,
@s_term                   varchar(30)     = null,
@s_date                   datetime        = null,
@s_srv                    varchar(30)     = null,
@s_lsrv                   varchar(30)     = null,
@s_ofi                    smallint        = null,
@s_rol                    smallint        = null,
@t_debug                  char(1)         = 'N',
@t_file                   varchar(10)     = null,
@t_from                   varchar(32)     = null,
@t_trn                    smallint        = null,
@i_operacion              char(1),
@i_opcion                 char(1)         = null,
@i_sec                    int             = 0,
@i_hora_error             time            = '00:00:00',
@i_reproceso              char(1)         = 'N',
@i_truncado               char(1)         = 'S',
@i_archivo                varchar(50)     = null,
@i_registro               int             = null,
@i_observacion            varchar(255)    = null,
@i_fin                    char(1)         = 'N',
@i_cant_registros         int             = null,
@i_param1                 varchar(600)    = null,
@i_param2                 varchar(600)    = null,
@i_param3                 varchar(600)    = null,
@i_param4                 varchar(600)    = null,
@i_param5                 varchar(600)    = null,
@i_param6                 varchar(600)    = null,
@i_param7                 varchar(600)    = null,
@i_param8                 varchar(600)    = null,
@i_param9                 varchar(600)    = null,
@i_param10                varchar(600)    = null,
@i_param11                varchar(600)    = null,
@i_param12                varchar(600)    = null,
@i_param13                varchar(600)    = null,
@i_param14                varchar(600)    = null,
@i_param15                varchar(600)    = null,
@i_param16                varchar(600)    = null,
@i_param17                varchar(600)    = null,
@i_param18                varchar(600)    = null,
@i_param19                varchar(600)    = null,
@i_param20                varchar(600)    = null,
@i_param21                varchar(600)    = null,
@i_param22                varchar(600)    = null,
@i_param23                varchar(600)    = null,
@i_param24                varchar(600)    = null,
@i_param25                varchar(600)    = null,
@i_param26                varchar(600)    = null,
@i_param27                varchar(600)    = null,
@i_param28                varchar(600)    = null,
@i_param29                varchar(600)    = null,
@i_param30                varchar(600)    = null)
with encryption
as
declare
@w_return                 int,
@w_ssn                    int,
@w_sp_name                varchar(32),
@w_fecha_proceso          datetime,
@w_id                     int,
@w_error                  int,
@w_desc_error             varchar(132),
@w_param_aux              varchar(600),
@w_param_tmp              varchar(600),
@w_registro               varchar(600),
@w_posicion               int             = 0,
@w_posicion2              int             = 0,
@w_columna                tinyint         = 0,
@w_separador_columna      char(3),
@w_separador_registro     char(3),
@w_secuencial_archivo     int,
@w_archivo                varchar(50),
@w_estado_archivo         char(1),
@w_fecha_vigencia         datetime,
@w_cant_registros         int,
@w_usuario                varchar(16),
@w_siguiente_hist         int,
@w_observacion            varchar(255),
@w_fecha_registro         date,
@w_hora_registro          time(7),
@w_secuencial             int,
@w_tipo_tasa              varchar(25),
@w_tdeposito              int,
@w_tipo_deposito          varchar(10),
@w_momento                varchar(10),
@w_moneda                 smallint,
@w_tipo_plazo             varchar(10),
@w_tipo_plazo_tmp         varchar(10),
@w_plazo_min              smallint,
@w_plazo_max              smallint,
@w_tipo_monto             varchar(10),
@w_tipo_monto_tmp         varchar(10),
@w_monto_min              money,
@w_monto_max              money,
@w_tipo_segmento          varchar(10),
@w_segmento               varchar(20),
@w_tipo_ivc               varchar(10),
@w_ivc                    varchar(20),
@w_prorroga               varchar(10),
@w_prorroga_tmp           varchar(10),
@w_prorroga_min           smallint,
@w_prorroga_max           smallint,
@w_tasa_referencial       varchar(10),
@w_operador               char(1),
@w_spread                 float,
@w_modalidad              varchar(10),
@w_tasa_min               float,
@w_tasa_max               float,
@w_tasa_vigente           float,
@w_fecha_reg              datetime,
@w_estado_ingresado       char(1),
@w_estado_validado        char(1),
@w_estado_aprobado        char(1),
@w_estado_procesado       char(1),
@w_estado_rechazado       char(1),
@w_estado_cancelado       char(1),
@w_estado_errori          char(1),
@w_estado_errore          char(1),
@w_mes                    char(2),
@w_dia                    char(2),
@w_anio                   char(4),
@w_hora                   char(2),
@w_minutos                char(2),
@w_segundo                char(2),
@v_secuencial_archivo     int,
@v_archivo                varchar(50),
@v_estado_archivo         char(1),
@v_fecha_vigencia         datetime,
@v_cant_registros         int,
@w_sec_max                int,
@w_existe_error           char(1)

select
@w_sp_name                = 'sp_archivo_tasas',
@w_estado_ingresado       = 'I',
@w_estado_validado        = 'V',
@w_estado_aprobado        = 'A',
@w_estado_procesado       = 'P',
@w_estado_rechazado       = 'R',
@w_estado_cancelado       = 'C',
@w_estado_errori          = 'E',
@w_estado_errore          = 'X'

select @w_separador_columna = '''' + pa_char + ''''
from   cobis..cl_parametro
where  pa_nemonico = 'SCCT'

select @w_separador_registro = '''' + pa_char + ''''
from   cobis..cl_parametro
where  pa_nemonico = 'SRCT'

if @i_param30 is null
   select @i_reproceso = 'N'
else 
   select @i_reproceso = 'S'

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

if @i_operacion = 'I' begin

   if @t_trn <> 14173 begin
      select @w_error = 141040
	  goto ERROR2
   end

   select
   @w_mes     = substring(@i_archivo, 20, 2),
   @w_dia     = substring(@i_archivo, 18, 2),
   @w_anio    = substring(@i_archivo, 22, 4),
   @w_hora    = substring(@i_archivo, 27, 2),
   @w_minutos = substring(@i_archivo, 30, 2),
   @w_segundo = substring(@i_archivo, 33, 2)
   
   if @w_mes > 12 begin
      select @w_error = 101140
      goto ERROR2
   end
   
   if @w_dia > 31 begin
      select @w_error = 101140
      goto ERROR2
   end
   
   if @w_hora > 25 begin
      select @w_error = 101140
      goto ERROR2
   end   
   
   if @w_minutos > 59 begin
      select @w_error = 101140
      goto ERROR2
   end
      
   if @w_segundo > 59 begin
      select @w_error = 101140
      goto ERROR2
   end
   
   select @w_fecha_vigencia = @w_mes + '/' + @w_dia + '/' + @w_anio + ' ' + @w_hora + ':' + @w_minutos + ':' + @w_segundo
   
   if @@error <> 0 begin
      select @w_error = 101140
      goto ERROR2
   end
   
   select
   @w_fecha_registro = getdate(),
   @w_hora_registro  = getdate()
   
   if (@i_param1 is null or len(@i_param1) = 0) and @i_fin = 'N' begin
      select @w_error = 148034
      goto ERROR2
   end
   
   if exists(select 1 from cob_pfijo..pf_archivo_carga_tasas where cat_nombre_archivo = @i_archivo) and @i_fin = 'S' begin
      select @w_error = 148020
      goto ERROR2
   end

   select
   @v_secuencial_archivo = cat_secuencial_archivo,
   @v_archivo            = cat_nombre_archivo,
   @v_estado_archivo     = cat_estado,
   @v_fecha_vigencia     = cat_fecha_vigencia,
   @v_cant_registros     = cat_numero_registros
   from  cob_pfijo..pf_archivo_carga_tasas
   where cat_estado      = @w_estado_validado
   
   if @@rowcount > 0 begin
      select @w_error = 148039
      goto ERROR2
   end
   
   if convert(date,@w_fecha_vigencia) <= @s_date begin	  
      select @w_error = 148017
	  goto ERROR2
   end
   
   select
   @w_secuencial_archivo     = cat_secuencial_archivo,
   @w_archivo                = cat_nombre_archivo,
   @w_estado_archivo         = cat_estado,
   @w_fecha_vigencia         = cat_fecha_vigencia,
   @w_cant_registros         = cat_numero_registros
   from  cob_pfijo..pf_archivo_carga_tasas
   where cat_estado          = @w_estado_ingresado
   and   cat_nombre_archivo <> @i_archivo
   
   if @@rowcount > 0 begin   
      update cob_pfijo..pf_archivo_carga_tasas
      set    cat_estado = @w_estado_cancelado
      where  cat_nombre_archivo = @w_archivo
      
      if @@error <> 0 begin
         select @w_error = 148021
         goto ERROR2
      end
     
      insert into ts_archivo_carga_tasas(
      secuencial,         tipo_transaccion,              clase,                  fecha,           usuario,              terminal,
      srv,                lsrv,                          secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
      numero_registros,   observacion,                   fecha_crea,             fecha_mod,       ofi)
      values(
      @s_ssn,             14873,                         'U',                    @s_date,         @s_user,              @s_term,
      @s_srv,             @s_lsrv,                       @w_secuencial_archivo,  @i_archivo,      @w_estado_cancelado,  @w_fecha_vigencia,
      @i_cant_registros,  'CANCELADO POR NUEVO CARGUE',  @s_date,                @s_date,         @s_ofi)
      
      if @@error <> 0 begin
         select @w_error = 143005
         goto ERROR2
      end
   end
   
   if  @i_fin = 'S' begin
      exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'pf_carga_archivo_tasas',
      @o_siguiente = @w_secuencial_archivo out
      
      if @w_return <> 0
         return @w_return
      
      insert into cob_pfijo..pf_archivo_carga_tasas(
      cat_secuencial_archivo,  cat_nombre_archivo,   cat_estado,           cat_fecha_vigencia,
      cat_numero_registros,    cat_fecha_registros,  cat_hora_registros,   cat_fecha_modificacion,
      cat_usuario,             cat_terminal,         cat_observacion)
      values(
      @w_secuencial_archivo,   @i_archivo,           @w_estado_ingresado,  @w_fecha_vigencia,
      @i_cant_registros,       @w_fecha_registro,    @w_hora_registro,     getdate(),
      @s_user,                 @s_term,              @i_observacion)
      
      if @@error <> 0 begin
         select @w_error = 148014
         goto ERROR2
      end
      
      insert into ts_archivo_carga_tasas(
      secuencial,         tipo_transaccion,   clase,                  fecha,           usuario,              terminal,
      srv,                lsrv,               secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
      numero_registros,   observacion,        fecha_crea,             fecha_mod,       ofi)
      values(
      @s_ssn,             @t_trn,             'N',                    @s_date,         @s_user,              @s_term,
      @s_srv,             @s_lsrv,            @w_secuencial_archivo,  @i_archivo,      @w_estado_ingresado,  @w_fecha_vigencia,
      @i_cant_registros,  @i_observacion,     @s_date,                @s_date,         @s_ofi)
      
      if @@error <> 0 begin
         select @w_error = 143005
         goto ERROR2
      end
   end
   
   if @i_truncado = 'S' begin
      truncate table pf_tasas_masivas
      
      if @@error <> 0 begin
         select @w_error = 148018
         goto ERROR2
      end
      
      truncate table pf_tasas_masivas_tmp
      
      if @@error <> 0 begin
         select @w_error = 148019
         goto ERROR2
      end
      
      truncate table pf_tasas_error
      
      if @@error <> 0 begin
         select @w_error = 148019
         goto ERROR2
      end
   end

   if exists (select 1 from cob_pfijo..pf_tasas_error where te_secuencial_archivo = @w_secuencial_archivo or @w_secuencial_archivo is null) begin
      select @w_error = 148028
	  goto ERROR2
   end
      
   if OBJECT_ID(N'tempdb..#ParamTemporal', N'U') is not null
      drop table #ParamTemporal
   
   create table #ParamTemporal(
   pt_id      int,
   pt_cadena  varchar(600))
   
   if @i_param1 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (1, replace(@i_param1,'@|',';|'))
   
   if @i_param2 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (2, replace(@i_param2,'@|',';|'))
   
   if @i_param3 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (3, replace(@i_param3,'@|',';|'))
   
   if @i_param4 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (4, replace(@i_param4,'@|',';|'))
   
   if @i_param5 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (5, replace(@i_param5,'@|',';|'))
   
   if @i_param6 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (6, replace(@i_param6,'@|',';|'))
   
   if @i_param7 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (7, replace(@i_param7,'@|',';|'))
   
   if @i_param8 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (8, replace(@i_param8,'@|',';|'))
   
   if @i_param9 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (9, replace(@i_param9,'@|',';|'))
   
   if @i_param10 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (10, replace(@i_param10,'@|',';|'))
	  
   if @i_param11 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (11, replace(@i_param11,'@|',';|'))
   
   if @i_param12 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (12, replace(@i_param12,'@|',';|'))
   
   if @i_param13 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (13, replace(@i_param13,'@|',';|'))
   
   if @i_param14 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (14, replace(@i_param14,'@|',';|'))
   
   if @i_param15 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (15, replace(@i_param15,'@|',';|'))
   
   if @i_param16 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (16, replace(@i_param16,'@|',';|'))
   
   if @i_param17 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (17, replace(@i_param17,'@|',';|'))
   
   if @i_param18 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (18, replace(@i_param18,'@|',';|'))
   
   if @i_param19 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (19, replace(@i_param19,'@|',';|'))
   
   if @i_param20 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (20, replace(@i_param20,'@|',';|'))
	  
   if @i_param21 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (21, replace(@i_param21,'@|',';|'))
   
   if @i_param22 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (22, replace(@i_param22,'@|',';|'))
   
   if @i_param23 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (23, replace(@i_param23,'@|',';|'))
   
   if @i_param24 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (24, replace(@i_param24,'@|',';|'))
   
   if @i_param25 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (25, replace(@i_param25,'@|',';|'))
   
   if @i_param26 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (26, replace(@i_param26,'@|',';|'))
   
   if @i_param27 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (27, replace(@i_param27,'@|',';|'))
   
   if @i_param28 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (28, replace(@i_param28,'@|',';|'))
   
   if @i_param29 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (29, replace(@i_param29,'@|',';|'))
   
   if @i_param30 is not null
      insert into #ParamTemporal(pt_id, pt_cadena) values (30, replace(@i_param30,'@|',';|'))
     
   while 1 = 1 begin   
      select top 1
      @w_id        = pt_id,
      @w_param_aux = pt_cadena
      from #ParamTemporal
      order by pt_id
   
      if @@rowcount = 0
         break
   
      if @w_param_aux is not null begin
         select
         @w_posicion  = 1,
         @w_posicion2 = 1,
         @w_columna   = 1
      end
      	 
      if CHARINDEX('|', @w_param_aux) = 0 or CHARINDEX(';', @w_param_aux) = 0
	     goto ERROR
   
      while @w_posicion2 <> 0 begin
         select @w_posicion2 = CHARINDEX('|', @w_param_aux)
         select @w_param_tmp = LEFT(@w_param_aux, @w_posicion2 -1)
         select @w_param_aux = stuff(@w_param_aux, 1, @w_posicion2, null)

         while @w_posicion <> 0 begin
            select @w_posicion = CHARINDEX(';', @w_param_tmp)
            select @w_registro = LEFT(@w_param_tmp, @w_posicion -1)
         
            if len(@w_registro) = 0 or @w_registro = 'NULL'
               select @w_registro = NULL
           
            if @w_columna = 1
               select @w_tipo_deposito = @w_registro
           
            if @w_columna = 2
               select @w_momento = @w_registro
           
            if @w_columna = 3 begin
               if (isnumeric(@w_registro) <> 1 or @w_registro like '%.%') and @w_registro is not null or patindex ('%[ &''":!+=\/()<>]%', @w_registro) <> 0 or patindex ('%[a-zA-Z]%', @w_registro) <> 0
                  goto ERROR

               select @w_moneda = @w_registro
            end
           
            if @w_columna = 4 begin
               if (isnumeric(@w_registro) <> 1 or @w_registro like '%.%') and @w_registro is not null or (convert(int,@w_registro) < -32768 or convert(int,@w_registro) > 32768) or patindex ('%[ &''":!+=\/()<>]%', @w_registro) <> 0 or patindex ('%[a-zA-Z]%', @w_registro) <> 0
                  goto ERROR

               select @w_plazo_min = @w_registro
            end
           
            if @w_columna = 5 begin
               if (isnumeric(@w_registro) <> 1 or @w_registro like '%.%') and @w_registro is not null or (convert(int,@w_registro) < -32768 or convert(int,@w_registro) > 32768) or patindex ('%[ &''":!+=\/()<>]%', @w_registro) <> 0 or patindex ('%[a-zA-Z]%', @w_registro) <> 0
                  goto ERROR

               select @w_plazo_max = @w_registro
            end
           
            if @w_columna = 6 begin
               if isnumeric(@w_registro) <> 1 and @w_registro is not null or patindex ('%[ &''":!+=\/()<>]%', @w_registro) <> 0 or patindex ('%[a-zA-Z]%', @w_registro) <> 0
                  goto ERROR

               select @w_monto_min = @w_registro
            end
           
            if @w_columna = 7 begin
               if isnumeric(@w_registro) <> 1 and @w_registro is not null or patindex ('%[ &''":!+=\/()<>]%', @w_registro) <> 0 or patindex ('%[a-zA-Z]%', @w_registro) <> 0
                  goto ERROR

               select @w_monto_max = @w_registro
            end
			
            if @w_columna = 8 begin
			   if isnumeric(@w_registro) = 1 and @w_registro is not null begin
			      if @w_registro < 10 and substring(@w_registro,1,1) <> 0
			         select @w_registro = '0' + @w_registro
                  
                  select @w_tipo_segmento = @w_registro
			   end

			   if (isnumeric(@w_registro) <> 1 or @w_registro like '%.%') and @w_registro is not null begin
			      goto ERROR
			   end
            end
           
            if @w_columna = 9
               select @w_segmento = @w_registro
           
            if @w_columna = 10
               select @w_tipo_ivc = @w_registro
			   
            if @w_columna = 11
               select @w_ivc = @w_registro
           
            if @w_columna = 12 begin
               if (isnumeric(@w_registro) <> 1 or @w_registro like '%.%') and @w_registro is not null or (convert(int,@w_registro) < -32768 or convert(int,@w_registro) > 32768) or patindex ('%[ &''":!+=\/()<>]%', @w_registro) <> 0 or patindex ('%[a-zA-Z]%', @w_registro) <> 0
                  goto ERROR

               select @w_prorroga_min = @w_registro
            end
           
            if @w_columna = 13 begin
               if (isnumeric(@w_registro) <> 1 or @w_registro like '%.%') and @w_registro is not null or (convert(int,@w_registro) < -32768 or convert(int,@w_registro) > 32768) or patindex ('%[ &''":!+=\/()<>]%', @w_registro) <> 0 or patindex ('%[a-zA-Z]%', @w_registro) <> 0
                  goto ERROR

               select @w_prorroga_max = @w_registro
            end
           
            if @w_columna = 14
               select @w_tasa_referencial = @w_registro
           
            if @w_columna = 15
               select @w_operador = @w_registro
           
            if @w_columna = 16 begin
               if isnumeric(@w_registro) <> 1 and @w_registro is not null or patindex ('%[ &''":!+=\/()<>]%', @w_registro) <> 0 or patindex ('%[a-zA-Z]%', @w_registro) <> 0
                  goto ERROR

               select @w_spread = @w_registro
            end
           
            if @w_columna = 17 begin
               if isnumeric(@w_registro) <> 1 and @w_registro is not null or patindex ('%[ &''":!+=\/()<>]%', @w_registro) <> 0 or patindex ('%[a-zA-Z]%', @w_registro) <> 0
                  goto ERROR

               select @w_tasa_min = @w_registro
            end
			
            if @w_columna = 18 begin
               if isnumeric(@w_registro) <> 1 and @w_registro is not null or patindex ('%[ &''":!+=\/()<>]%', @w_registro) <> 0 or patindex ('%[a-zA-Z]%', @w_registro) <> 0
                  goto ERROR

               select @w_tasa_vigente = @w_registro
            end
           
            if @w_columna = 19 begin
               if isnumeric(@w_registro) <> 1 and @w_registro is not null or patindex ('%[ &''":!+=\/()<>]%', @w_registro) <> 0 or patindex ('%[a-zA-Z]%', @w_registro) <> 0
                  goto ERROR

               select @w_tasa_max = @w_registro
            end
           
            select @w_param_tmp = stuff(@w_param_tmp, 1, @w_posicion, null)
            select @w_posicion  = CHARINDEX(';', @w_param_tmp)
            select @w_columna   = @w_columna + 1
         end
   
         insert into pf_tasas_masivas_tmp(
         tmt_tipo_deposito,                  tmt_momento,                     tmt_moneda,                   tmt_plazo_min,
         tmt_plazo_max,                      tmt_monto_min,                   tmt_monto_max,                tmt_tipo_segmento,
         tmt_segmento,                       tmt_tipo_ivc,                    tmt_ivc,                      tmt_prorroga_min,
         tmt_prorroga_max,                   tmt_tasa_referencial,            tmt_operador,                 tmt_spread,
         tmt_tasa_min,                       tmt_tasa_vigente, tmt_tasa_max)		 
         values(
         @w_tipo_deposito,                   @w_momento,                      convert(smallint,@w_moneda),  convert(smallint,@w_plazo_min),
		 convert(smallint,@w_plazo_max),     convert(money,@w_monto_min),     convert(money,@w_monto_max),  @w_tipo_segmento, 
		 @w_segmento,                        @w_tipo_ivc,                     @w_ivc,                       convert(smallint,@w_prorroga_min),
		 convert(smallint,@w_prorroga_max),  @w_tasa_referencial,             @w_operador,                  convert(float,@w_spread),
		 convert(float,@w_tasa_min),         convert(float,@w_tasa_vigente),  convert(float,@w_tasa_max))
       
         if @@error <> 0 begin
            select @w_error      = 148028         
            select @w_desc_error = mensaje
            from   cobis..cl_errores
            where  numero = @w_error

            update cob_pfijo..pf_archivo_carga_tasas
            set    cat_estado = @w_estado_errore
            where  cat_secuencial_archivo = @w_secuencial_archivo
         
            insert into ts_archivo_carga_tasas(
            secuencial,         tipo_transaccion,  clase,                  fecha,           usuario,              terminal,
            srv,                lsrv,              secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
            numero_registros,   observacion,       fecha_crea,             fecha_mod,       ofi)
            values(
            @s_ssn,             14873,             'U',                    @s_date,         @s_user,              @s_term,
            @s_srv,             @s_lsrv,           @w_secuencial_archivo,  @i_archivo,      @w_estado_cancelado,  @w_fecha_vigencia,
            @i_cant_registros,  @w_desc_error,     @s_date,                @s_date,         @s_ofi)
         
            if @@error <> 0 begin
               select @w_error = 143005
               goto ERROR2
            end

            insert into pf_tasas_error(
            te_secuencial_archivo,  te_secuencial,        te_fecha,                          te_hora,                            te_codigo_error,
            te_desc_error,          te_numero_registros,  te_nombre_campo,                   te_valor_campo)
            values(
            @w_secuencial_archivo,  null,                 getdate(),                         getdate(),                          @w_error,
            @w_desc_error,          null,                 'ERROR EN ESTRUCTURA DE ARCHIVO',  convert(varchar(23),@w_tipo_tasa) + ' - ' + convert(varchar(23),@w_tipo_deposito) + ' - ' + convert(varchar(23),@w_momento))
         
            if @@error <> 0  begin
               select @w_error = 203042
               goto ERROR2
            end
          
            exec cobis..sp_cerror
            select @w_error = 148015
            goto ERROR2
         end
		 
         select
         @w_tipo_deposito    = null,
         @w_momento          = null,
         @w_moneda           = null,
         @w_plazo_min        = null,
         @w_plazo_max        = null,
         @w_monto_min        = null,
         @w_monto_max        = null,
		 @w_tipo_segmento    = null,
         @w_segmento         = null,
		 @w_tipo_deposito    = null,
         @w_ivc              = null,
         @w_prorroga         = null,
         @w_prorroga_min     = null,
         @w_prorroga_max     = null,
         @w_tasa_referencial = null,
         @w_operador         = null,
         @w_spread           = null,
         @w_tasa_min         = null,
         @w_tasa_vigente     = null,
		 @w_tasa_max         = null
   
         select @w_posicion  = 1
         select @w_columna   = 1
         select @w_posicion2 = CHARINDEX('|', @w_param_aux) 
      end   
      delete
      from  #ParamTemporal
      where pt_id = @w_id
   end
   
   if OBJECT_ID(N'tempdb..#ParamTemporal', N'U') is not null
      drop table #ParamTemporal
	  
   if exists (select 1 from cob_pfijo..pf_tasas_error where te_secuencial_archivo = @w_secuencial_archivo or @w_secuencial_archivo is null)
      select @w_existe_error = 'S'
   else
      select @w_existe_error = 'N'
     
   if @i_fin = 'S' and @w_existe_error = 'N' begin
      insert into cob_pfijo..pf_tasas_masivas(
      tm_secuencial_archivo,  tm_tipo_deposito,   tm_momento,            tm_moneda,
      tm_plazo_min,           tm_plazo_max,       tm_monto_min,          tm_monto_max,
      tm_tipo_segmento,       tm_segmento,        tm_tipo_ivc,           tm_ivc,
      tm_prorroga_min,        tm_prorroga_max,    tm_tasa_referencial,   tm_operador,
      tm_spread,              tm_tasa_min,        tm_tasa_max,           tm_tasa_vigente,
      tm_fecha_registro,      tm_estado,          tm_secuencial)
      select
      @w_secuencial_archivo,  tmt_tipo_deposito,  tmt_momento,           tmt_moneda,
      tmt_plazo_min,          tmt_plazo_max,      tmt_monto_min,         tmt_monto_max,
      tmt_tipo_segmento,      tmt_segmento,       tmt_tipo_ivc,          tmt_ivc,
      tmt_prorroga_min,       tmt_prorroga_max,   tmt_tasa_referencial,  tmt_operador,
      tmt_spread,             tmt_tasa_min,       tmt_tasa_max,          tmt_tasa_vigente,
	  @s_date,                'I',                row_number() over(order by tmt_tipo_deposito) as tmt_secuencial
      from cob_pfijo..pf_tasas_masivas_tmp
      
      if @@error <> 0 begin
         update cob_pfijo..pf_archivo_carga_tasas
         set    cat_estado = @w_estado_errore
         where  cat_secuencial_archivo = @w_secuencial_archivo
        
         insert into ts_archivo_carga_tasas(
         secuencial,         tipo_transaccion,            clase,                  fecha,           usuario,              terminal,
         srv,                lsrv,                        secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
         numero_registros,   observacion,                 fecha_crea,             fecha_mod,       ofi)
         values(
         @s_ssn,             14873,                       'U',                    @s_date,         @s_user,              @s_term,
         @s_srv,             @s_lsrv,                     @w_secuencial_archivo,  @i_archivo,      @w_estado_cancelado,  @w_fecha_vigencia,
         @i_cant_registros,  'CANCELADO POR ESTRUCTURA',  @s_date,                @s_date,         @s_ofi)
         
         if @@error <> 0 begin
            select @w_error = 143005
            goto ERROR2
         end
            
         select @w_error = 148016
         goto ERROR2
      end
   end
end

if @i_operacion = 'V' begin
   if @t_trn <> 14273 begin
      select @w_error = 141040
      goto ERROR2
   end

   select
   @w_secuencial_archivo = cat_secuencial_archivo,
   @w_archivo            = cat_nombre_archivo,
   @w_estado_archivo     = cat_estado,
   @w_fecha_vigencia     = cat_fecha_vigencia,
   @w_cant_registros     = cat_numero_registros
   from  cob_pfijo..pf_archivo_carga_tasas
   where cat_estado      = @w_estado_ingresado
   order by cat_fecha_modificacion desc
   
   if @@rowcount = 0 begin
      select @w_error = 148013
      goto ERROR2
   end

   truncate table pf_tasas_error
   
   if @@error <> 0 begin
      select @w_error = 148019
      goto ERROR2
   end   
   
   if not exists (select 1 from cob_pfijo..pf_tasas_masivas) begin
      select @w_error = 148013
      goto ERROR2
   end
   else begin   
      while 1 = 1 begin
         select top 1
         @w_secuencial_archivo  = tm_secuencial_archivo,
         @w_secuencial          = tm_secuencial,
         @w_tipo_deposito       = tm_tipo_deposito,
         @w_momento             = tm_momento,
         @w_moneda              = tm_moneda,
         @w_plazo_min           = tm_plazo_min,
         @w_plazo_max           = tm_plazo_max,
         @w_monto_min           = tm_monto_min,
         @w_monto_max           = tm_monto_max,
		 @w_tipo_segmento       = tm_tipo_segmento,
         @w_segmento            = tm_segmento,
		 @w_tipo_ivc            = tm_tipo_ivc,
         @w_ivc                 = tm_ivc,
         @w_prorroga_min        = tm_prorroga_min,
         @w_prorroga_max        = tm_prorroga_max,
         @w_tasa_referencial    = rtrim(ltrim(tm_tasa_referencial)),
         @w_operador            = tm_operador,
         @w_spread              = tm_spread,
         @w_tasa_min            = tm_tasa_min,
         @w_tasa_vigente        = tm_tasa_vigente,
         @w_tasa_max            = tm_tasa_max,
         @w_fecha_reg           = tm_fecha_registro
         from  pf_tasas_masivas
         where tm_estado = 'I'
         order by tm_secuencial
       
         if @@rowcount = 0
            break
       
         if not exists (select 1 from cob_pfijo..pf_tipo_deposito where td_mnemonico = @w_tipo_deposito) begin       
            select @w_error      = 141115         
            select @w_desc_error = mensaje
            from   cobis..cl_errores
            where  numero = @w_error
         
            insert into pf_tasas_error(
            te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
            te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
            values(
            @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
            @w_desc_error,          @w_secuencial,        'TIPO PRODUCTO',  convert(varchar(140),@w_tipo_deposito))
         
            if @@error <> 0  begin
               select @w_error = 203042
               goto ERROR2
            end
         end
		 else begin
		    select
			@w_tdeposito = td_tipo_deposito,
			@w_tipo_tasa = td_tasa_variable
			from   cob_pfijo..pf_tipo_deposito
			where  td_mnemonico = @w_tipo_deposito
			
            if @@error <> 0  begin
               select @w_error = 141115
               goto ERROR2
            end
		 end
       
         if not exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = @w_momento and t.tabla = 'pf_momento') begin       
            select @w_error      = 148023         
            select @w_desc_error = mensaje
            from   cobis..cl_errores
            where  numero = @w_error
         
            insert into pf_tasas_error(
            te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
            te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
            values(
            @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
            @w_desc_error,          @w_secuencial,        'MOMENTO',        convert(varchar(140),@w_momento))
         
            if @@error <> 0  begin
               select @w_error = 203042
               goto ERROR2
            end
         end
       
         if not exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = @w_moneda and t.tabla = 'cl_moneda') begin       
            select @w_error      = 141013         
            select @w_desc_error = mensaje
            from   cobis..cl_errores
            where  numero = @w_error
         
            insert into pf_tasas_error(
            te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
            te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
            values(
            @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
            @w_desc_error,          @w_secuencial,        'MONEDA',        convert(varchar(140),@w_moneda))
         
            if @@error <> 0  begin
               select @w_error = 203042
               goto ERROR2
            end
         end
       
         if not exists (select 1 from cob_pfijo..pf_plazo, cob_pfijo..pf_auxiliar_tip where at_valor = pl_mnemonico and at_tipo_deposito = @w_tdeposito and pl_plazo_min = @w_plazo_min and pl_plazo_max = @w_plazo_max and at_tipo = 'PLA' and at_moneda = @w_moneda) begin       
            select @w_error      = 141054         
            select @w_desc_error = mensaje
            from   cobis..cl_errores
            where  numero = @w_error
         
            insert into pf_tasas_error(
            te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
            te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
            values(
            @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
            @w_desc_error,          @w_secuencial,        'TIPO DE PLAZO',  'PLAZO MIN = ' + convert(varchar(12),@w_plazo_min) + '| PLAZO MAX = ' + convert(varchar(12),@w_plazo_max))
         
            if @@error <> 0  begin
               select @w_error = 203042
               goto ERROR2
            end
         end
         else begin
            select @w_tipo_plazo_tmp = pl_mnemonico
            from   cob_pfijo..pf_plazo, cob_pfijo..pf_auxiliar_tip
            where  at_valor          = pl_mnemonico
            and    at_tipo_deposito  = @w_tdeposito
            and    pl_plazo_min      = @w_plazo_min
            and    pl_plazo_max      = @w_plazo_max
            and    at_tipo           = 'PLA'
            and    at_moneda         = @w_moneda
			
            update pf_tasas_masivas
            set    tm_tipo_plazo         = @w_tipo_plazo_tmp
            where  tm_secuencial_archivo = @w_secuencial_archivo
            and    tm_secuencial         = @w_secuencial
            
            if @@error <> 0  begin
               select @w_error = 145014
               goto ERROR2
            end    
		 end
	  
	     if not exists (select 1 from cob_pfijo..pf_monto, cob_pfijo..pf_auxiliar_tip where at_valor = mo_mnemonico and at_tipo_deposito = @w_tdeposito and mo_monto_min = @w_monto_min and mo_monto_max = @w_monto_max and at_tipo = 'MOT' and at_moneda = @w_moneda) begin       
            select @w_error      = 141053         
            select @w_desc_error = mensaje
            from   cobis..cl_errores
            where  numero = @w_error
            
            insert into pf_tasas_error(
            te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
            te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
            values(
            @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
            @w_desc_error,          @w_secuencial,        'TIPO DE MONTO',  'MONTO MIN = ' + convert(varchar(23),@w_monto_min) + '| MONTO MAX = ' + convert(varchar(23),@w_monto_max))
            
            if @@error <> 0  begin
               select @w_error = 203042
               goto ERROR2
            end
         end
         else begin		 
            select @w_tipo_monto_tmp = mo_mnemonico
            from   cob_pfijo..pf_monto, cob_pfijo..pf_auxiliar_tip
            where  at_valor          = mo_mnemonico
            and    at_tipo_deposito  = @w_tdeposito
            and    mo_monto_min      = @w_monto_min
            and    mo_monto_max      = @w_monto_max
            and    at_tipo           = 'MOT'
            and    at_moneda         = @w_moneda
               
            update pf_tasas_masivas
            set    tm_tipo_monto         = @w_tipo_monto_tmp
            where  tm_secuencial_archivo = @w_secuencial_archivo
            and    tm_secuencial         = @w_secuencial
            
            if @@error <> 0  begin
               select @w_error = 145012
               goto ERROR2
            end            
         end
	     
	     if @w_tipo_segmento is not null begin
            if not exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = @w_tipo_segmento and t.tabla = 'pf_segmento' ) begin       
               select @w_error      = 148024         
               select @w_desc_error = mensaje
               from   cobis..cl_errores
               where  numero = @w_error
               
               insert into pf_tasas_error(
               te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
               te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
               values(
               @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
               @w_desc_error,          @w_secuencial,        'SEGMENTO',       convert(varchar(140),@w_tipo_segmento))
               
               if @@error <> 0  begin
                  select @w_error = 203042
                  goto ERROR2
               end
            end
         end
          
         if @w_tipo_ivc is not null begin
            if not exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = @w_tipo_ivc and t.tabla = 'pf_ivc') begin       
               select @w_error      = 148025         
               select @w_desc_error = mensaje
               from   cobis..cl_errores
               where  numero = @w_error
            
               insert into pf_tasas_error(
               te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
               te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
               values(
               @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
               @w_desc_error,          @w_secuencial,        'IVC',            convert(varchar(140),@w_tipo_ivc))
            
               if @@error <> 0  begin
                  select @w_error = 203042
                  goto ERROR2
               end
            end
         end
          
         if @w_momento = 'P' begin
            if not exists (select 1 from   cob_pfijo..pf_rango_prorroga, cob_pfijo..pf_auxiliar_tip where at_valor = rp_mnemonico and at_tipo_deposito = @w_tdeposito and rp_prorroga_min = @w_prorroga_min and rp_prorroga_max = @w_prorroga_max and at_tipo = 'PRO' and at_moneda = @w_moneda) begin       
               select @w_error      = 148033         
               select @w_desc_error = mensaje
               from   cobis..cl_errores
               where  numero = @w_error
               
               insert into pf_tasas_error(
               te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
               te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
               values(
               @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
               @w_desc_error,          @w_secuencial,        'PRORROGA',       'PRORROGA MIN = ' + convert(varchar(12),@w_prorroga_min) + '| PRORROGA MAX = ' + + convert(varchar(12),@w_prorroga_max))
               
               if @@error <> 0  begin
                  select @w_error = 203042
                  goto ERROR2
               end
            end
			else begin
               select @w_prorroga_tmp  = rp_mnemonico
               from   cob_pfijo..pf_rango_prorroga, cob_pfijo..pf_auxiliar_tip
               where  at_valor         = rp_mnemonico
               and    at_tipo_deposito = @w_tdeposito
               and    rp_prorroga_min  = @w_prorroga_min
               and    rp_prorroga_max  = @w_prorroga_max
               and    at_tipo          = 'PRO'
               and    at_moneda        = @w_moneda
			   
               update pf_tasas_masivas
               set    tm_prorroga           = @w_prorroga_tmp
               where  tm_secuencial_archivo = @w_secuencial_archivo
               and    tm_secuencial         = @w_secuencial
               
               if @@error <> 0  begin
                  select @w_error = 145012
                  goto ERROR2
               end    
			end
         end
		 
         if @w_tasa_min is null or @w_tasa_max is null or @w_tasa_min >= 100 or @w_tasa_max >= 100 begin       
            select @w_error      = 148035         
            select @w_desc_error = mensaje
            from   cobis..cl_errores
            where  numero = @w_error
            
            insert into pf_tasas_error(
            te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
            te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
            values(
            @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
            @w_desc_error,          @w_secuencial,        'TASA',           'TASA MIN = ' + convert(varchar(12),@w_tasa_min) + ' | TASA MAX = ' + convert(varchar(12),@w_tasa_max))
            
            if @@error <> 0  begin
               select @w_error = 203042
               goto ERROR2
            end
         end
          
         if @w_tipo_tasa = 'S' begin
            if not exists (select 1 from cobis..te_ttasas_referenciales where rtrim(ltrim(tr_tasa)) = @w_tasa_referencial) begin       
               select @w_error      = 141159         
               select @w_desc_error = mensaje
               from   cobis..cl_errores
               where  numero = @w_error
               
               insert into pf_tasas_error(
               te_secuencial_archivo,  te_secuencial,        te_fecha,           te_hora,                                 te_codigo_error,
               te_desc_error,          te_numero_registros,  te_nombre_campo,    te_valor_campo)
               values(
               @w_secuencial_archivo,  @w_secuencial,        getdate(),          getdate(),                               @w_error,
               @w_desc_error,          @w_secuencial,        'TASA REFERENCIA',  convert(varchar(140),@w_tasa_referencial))
            
               if @@error <> 0  begin
                  select @w_error = 203042
                  goto ERROR2
               end
            end
			
			if @w_operador not in ('+', '-') or @w_operador is null begin
               select @w_error      = 148029         
               select @w_desc_error = mensaje
               from   cobis..cl_errores
               where  numero = @w_error
               
               insert into pf_tasas_error(
               te_secuencial_archivo,  te_secuencial,        te_fecha,           te_hora,                                 te_codigo_error,
               te_desc_error,          te_numero_registros,  te_nombre_campo,    te_valor_campo)
               values(
               @w_secuencial_archivo,  @w_secuencial,        getdate(),          getdate(),                               @w_error,
               @w_desc_error,          @w_secuencial,        'OPERADOR',         convert(varchar(140),@w_operador))
               
               if @@error <> 0  begin
                  select @w_error = 203042
                  goto ERROR2
               end
            end
			
			if @w_spread is null or isnumeric(@w_spread) <> 1 or @w_spread >= 100 begin
               select @w_error      = 149065         
               select @w_desc_error = mensaje
               from   cobis..cl_errores
               where  numero = @w_error
               
               insert into pf_tasas_error(
               te_secuencial_archivo,  te_secuencial,        te_fecha,           te_hora,                                 te_codigo_error,
               te_desc_error,          te_numero_registros,  te_nombre_campo,    te_valor_campo)
               values(
               @w_secuencial_archivo,  @w_secuencial,        getdate(),          getdate(),                               @w_error,
               @w_desc_error,          @w_secuencial,        'SPREAD',           convert(varchar(140),@w_spread))
               
               if @@error <> 0  begin
                  select @w_error = 203042
                  goto ERROR2
               end
            end			
			
            if @w_tasa_min > @w_tasa_max begin       
               select @w_error      = 148026         
               select @w_desc_error = mensaje
               from   cobis..cl_errores
               where  numero = @w_error
               
               insert into pf_tasas_error(
               te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
               te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
               values(
               @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
               @w_desc_error,          @w_secuencial,        'TASA VARIABLE',  'TASA MIN = ' + convert(varchar(12),@w_tasa_min) + ' | TASA MAX = ' + convert(varchar(12),@w_tasa_max))
               
               if @@error <> 0  begin
                  select @w_error = 203042
                  goto ERROR2
               end
            end
         end
	  
         if @w_tipo_tasa = 'N' begin
            if @w_tasa_min > @w_tasa_max begin       
               select @w_error      = 148026         
               select @w_desc_error = mensaje
               from   cobis..cl_errores
               where  numero = @w_error
               
               insert into pf_tasas_error(
               te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
               te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
               values(
               @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
               @w_desc_error,          @w_secuencial,        'TASA FIJA',      'TASA MIN = ' + convert(varchar(12),@w_tasa_min) + ' | TASA MAX = ' + convert(varchar(12),@w_tasa_max))
               
               if @@error <> 0  begin
                  select @w_error = 203042
                  goto ERROR2
               end
            end
            if (@w_tasa_vigente < @w_tasa_min and @w_tasa_vigente > @w_tasa_max) or @w_tasa_vigente is null or @w_tasa_vigente >= 100 begin
               select @w_error      = 148027         
               select @w_desc_error = mensaje
               from   cobis..cl_errores
               where  numero = @w_error
               
               insert into pf_tasas_error(
               te_secuencial_archivo,  te_secuencial,        te_fecha,         te_hora,                                 te_codigo_error,
               te_desc_error,          te_numero_registros,  te_nombre_campo,  te_valor_campo)
               values(
               @w_secuencial_archivo,  @w_secuencial,        getdate(),        getdate(),                               @w_error,
               @w_desc_error,          @w_secuencial,        'TASA VIGENTE',   convert(varchar(12),@w_tasa_vigente))
			   
               if @@error <> 0  begin
                  select @w_error = 203042
                  goto ERROR2
               end
            end
         end
		 
		 if exists (select 1
		 from   pf_tasas_masivas
		 where  tm_secuencial_archivo = @w_secuencial_archivo
		 and    tm_tipo_deposito      = @w_tipo_deposito
		 and    tm_momento            = @w_momento
		 and    tm_moneda             = @w_moneda
		 and    tm_plazo_min          = @w_plazo_min
		 and    tm_plazo_max          = @w_plazo_max
		 and    tm_monto_min          = @w_monto_min
		 and    tm_monto_max          = @w_monto_max
		 and   (tm_tipo_segmento      = @w_tipo_segmento    or @w_tipo_segmento    is null)
		 and   (tm_tipo_ivc           = @w_tipo_ivc         or @w_tipo_ivc         is null)
		 and   (tm_prorroga_min       = @w_prorroga_min     or @w_prorroga_min     is null)
		 and   (tm_prorroga_max       = @w_prorroga_max     or @w_prorroga_max     is null)
		 and    tm_secuencial        <> @w_secuencial) begin
            select @w_error      = 148040         
            select @w_desc_error = mensaje
            from   cobis..cl_errores
            where  numero = @w_error
         
            insert into pf_tasas_error(
            te_secuencial_archivo,  te_secuencial,        te_fecha,              te_hora,                                 te_codigo_error,
            te_desc_error,          te_numero_registros,  te_nombre_campo,       te_valor_campo)
            values(
            @w_secuencial_archivo,  @w_secuencial,        getdate(),             getdate(),                               @w_error,
            @w_desc_error,          @w_secuencial,        'REGISTRO DUPLICADO',  'SECUENCIAL DE REGISTRO = ' + convert(varchar(140),@w_secuencial))
         
            if @@error <> 0  begin
               select @w_error = 203042
               goto ERROR2
            end
		 end
		 
         update pf_tasas_masivas
         set    tm_estado = 'P'
         where  tm_secuencial_archivo = @w_secuencial_archivo
         and    tm_secuencial         = @w_secuencial
         
         if @@error <> 0 begin
            select @w_error = 148030
            goto ERROR2
         end       
      end
   end

   if exists (select 1 from pf_tasas_error where te_secuencial_archivo = @w_secuencial_archivo) begin
      update cob_pfijo..pf_archivo_carga_tasas
      set    cat_estado = @w_estado_errori
      where  cat_secuencial_archivo = @w_secuencial_archivo
	  
      insert into ts_archivo_carga_tasas(
      secuencial,         tipo_transaccion,        clase,                  fecha,           usuario,              terminal,
      srv,                lsrv,                    secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
      numero_registros,   observacion,             fecha_crea,             fecha_mod,       ofi)
      values(
      @s_ssn,             14873,                   'U',                    @s_date,         @s_user,              @s_term,
      @s_srv,             @s_lsrv,                 @w_secuencial_archivo,  @w_archivo,      @w_estado_errori,     @w_fecha_vigencia,
      @w_cant_registros,  'ERROR EN INFORMACION',  @s_date,                @s_date,         @s_ofi)         
   end
   else begin     
      update cob_pfijo..pf_archivo_carga_tasas
      set    cat_estado = @w_estado_validado
      where  cat_secuencial_archivo = @w_secuencial_archivo
	  
      insert into ts_archivo_carga_tasas(
      secuencial,         tipo_transaccion,        clase,                  fecha,           usuario,              terminal,
      srv,                lsrv,                    secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
      numero_registros,   observacion,             fecha_crea,             fecha_mod,       ofi)
      values(
      @s_ssn,             @t_trn,                  'U',                    @s_date,         @s_user,              @s_term,
      @s_srv,             @s_lsrv,                 @w_secuencial_archivo,  @w_archivo,      @w_estado_validado,   @w_fecha_vigencia,
      @w_cant_registros,  'ARCHIVO VALIDADO OK',   @s_date,                @s_date,         @s_ofi)        
   end
end

if @i_operacion = 'S' begin
   if @t_trn <> 14573 begin
      select @w_error = 141040
      goto ERROR2
   end
   
   select top 1
   @w_secuencial_archivo     = cat_secuencial_archivo,
   @w_archivo                = cat_nombre_archivo,
   @w_estado_archivo         = cat_estado,
   @w_fecha_vigencia         = cat_fecha_vigencia,
   @w_cant_registros         = cat_numero_registros
   from   cob_pfijo..pf_archivo_carga_tasas
   where  cat_nombre_archivo = @i_archivo
   
   if @i_opcion = 'C' begin
      select distinct
      'NOMBRE ARCHIVO'     = cat_nombre_archivo,
      'N.REGISTROS'        = cat_numero_registros,
      'FECHA VIGENCIA'     = convert(varchar(23), convert(date,cat_fecha_vigencia), 103),
      'FECHA MODIFICACION' = convert(varchar(23),cat_fecha_modificacion, 103) + ' ' + convert(varchar(23),cat_fecha_modificacion, 114),
      'USUARIO'            = cat_usuario,
      'ESTADO'             = cat_estado + ' - ' + (select distinct c.valor from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = cat_estado and t.tabla = 'pf_carga_archivo_tasas')
      from  cob_pfijo..pf_archivo_carga_tasas
      where cat_nombre_archivo = @i_archivo   
   end
   
   if @i_opcion = 'H' begin   
      select
      'NOMBRE ARCHIVO'     = cat_nombre_archivo,
      'N.REGISTROS'        = cat_numero_registros,
      'FECHA VIGENCIA'     = convert(varchar(23), convert(date,cat_fecha_vigencia), 103),
      'FECHA MODIFICACION' = convert(varchar(23),cat_fecha_modificacion, 103) + ' ' + convert(varchar(23),cat_fecha_modificacion, 114),
      'USUARIO'            = cat_usuario,
      'ESTADO'             = cat_estado + ' - ' + (select distinct c.valor from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = cat_estado and t.tabla = 'pf_carga_archivo_tasas')
      from  cob_pfijo..pf_archivo_carga_tasas
      order by cat_fecha_modificacion desc
   end
   
   if @i_opcion = 'D' begin   
      set rowcount 600
      select distinct
      'N. REGISTRO'      = tm_secuencial,
      'TIPO DE DEPOSITO' = tm_tipo_deposito,
      'MOMENTO'          = tm_momento,
      'MONEDA'           = tm_moneda,
      'PLAZO MIN'        = tm_plazo_min,
      'PLAZO MAX'        = tm_plazo_max,
      'MONTO MIN'        = tm_monto_min,
      'MONTO MAX'        = tm_monto_max,
      'SEGMENTO'         = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = tm_tipo_segmento and t.tabla = 'pf_segmento'),
      'IVC'              = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = tm_tipo_ivc and t.tabla = 'pf_ivc'),
      'PRORROGA MIN'     = tm_prorroga_min,
      'PRORROGA MX'      = tm_prorroga_max,
      'TASA REFERENCIA'  = tm_tasa_referencial,
      'OPERADOR'         = tm_operador,
      'SPREAD'           = tm_spread,
      'TASA MIN'         = tm_tasa_min,
	  'TASA VIGENTE'     = tm_tasa_vigente,
      'TASA MAX'         = tm_tasa_max
      from  cob_pfijo..pf_tasas_masivas
      where tm_secuencial_archivo = @w_secuencial_archivo
      and   tm_secuencial > @i_sec
      order by tm_secuencial
	  
      if @@rowcount = 0 begin
         select @w_error = 148013
         goto ERROR2
      end
	  
	  set rowcount 0		 
   end
   
   if @i_opcion = 'E' begin      
      set rowcount 600
      select distinct
      'N. REGISTRO'                   = isnull(te_secuencial,0),
      'FECHA'                         = te_fecha,
      'HORA'                          = te_hora,
      'CODIGO ERROR'                  = te_codigo_error,
      'DESC. ERROR'                   = te_desc_error,
      'CAMPO'                         = te_nombre_campo,
      'VALOR'                         = te_valor_campo
      from   cob_pfijo..pf_tasas_error
      where (te_secuencial_archivo    = @w_secuencial_archivo or @w_secuencial_archivo is null)
      and    isnull(te_secuencial,0) >= @i_sec
      and    te_hora                  > @i_hora_error
	  order by isnull(te_secuencial,0), te_hora
	  
      if @@rowcount = 0 and @i_hora_error <> '00:00:00' and @i_sec > 0 begin
         select @w_error = 148013
         goto ERROR2
      end
	  set rowcount 0
   end
   
   if @i_opcion = 'B' begin
      select distinct
      'N. REGISTRO'               = te_secuencial,
      'FECHA'                     = te_fecha,
      'HORA'                      = te_hora,
      'CODIGO ERROR'              = te_codigo_error,
      'DESC. ERROR'               = te_desc_error,
      'CAMPO'                     = te_nombre_campo,
      'VALOR'                     = te_valor_campo
      from  cob_pfijo..pf_tasas_error
      where te_secuencial         = @i_registro
	  and   te_secuencial_archivo = @w_secuencial_archivo
      order by te_secuencial
   end
end

if @i_operacion = 'Q' begin
   if @t_trn <> 14473 begin
      select @w_error = 141040
      goto ERROR2
   end
   
   select top 1
   @w_secuencial_archivo     = cat_secuencial_archivo,
   @w_archivo                = cat_nombre_archivo,
   @w_estado_archivo         = cat_estado,
   @w_fecha_vigencia         = cat_fecha_vigencia,
   @w_cant_registros         = cat_numero_registros
   from   cob_pfijo..pf_archivo_carga_tasas
   where  cat_estado         = @w_estado_validado
   order by cat_fecha_modificacion desc
   
   if @i_opcion = 'C' begin
      select
      'NOMBRE ARCHIVO'     = cat_nombre_archivo,
      'N.REGISTROS'        = cat_numero_registros,
      'FECHA VIGENCIA'     = convert(varchar(23), convert(date,cat_fecha_vigencia), 103),
      'FECHA MODIFICACION' = convert(varchar(23),cat_fecha_modificacion, 103) + ' ' + convert(varchar(23),cat_fecha_modificacion, 114),
      'USUARIO'            = cat_usuario,
      'ESTADO'             = cat_estado + ' - ' + (select distinct c.valor from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = cat_estado and t.tabla = 'pf_carga_archivo_tasas')
      from  cob_pfijo..pf_archivo_carga_tasas
      where cat_nombre_archivo = @w_archivo
      
      if @@rowcount = 0 begin
         select @w_error = 148013
         goto ERROR2
      end
   end
  
   if @i_opcion = 'D' begin
      set rowcount 600
      select distinct
      'N. REGISTRO'      = tm_secuencial,
      'TIPO DE DEPOSITO' = tm_tipo_deposito,
      'MOMENTO'          = tm_momento,
      'MONEDA'           = tm_moneda,
      'PLAZO MIN'        = tm_plazo_min,
      'PLAZO MAX'        = tm_plazo_max,
      'MONTO MIN'        = tm_monto_min,
      'MONTO MAX'        = tm_monto_max,
      'SEGMENTO'         = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = tm_tipo_segmento and t.tabla = 'pf_segmento'),
      'IVC'              = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo as c where t.codigo = c.tabla and c.codigo = tm_tipo_ivc and t.tabla = 'pf_ivc'),
      'PRORROGA MIN'     = tm_prorroga_min,
      'PRORROGA MX'      = tm_prorroga_max,
      'TASA REFERENCIA'  = tm_tasa_referencial,
      'OPERADOR'         = tm_operador,
      'SPREAD'           = tm_spread,
      'TASA MIN'         = tm_tasa_min,
	  'TASA VIGENTE'     = tm_tasa_vigente,
      'TASA MAX'         = tm_tasa_max
      from  cob_pfijo..pf_tasas_masivas
      where tm_secuencial_archivo = @w_secuencial_archivo
      and   tm_secuencial > @i_sec
      order by tm_secuencial
      
      if @@rowcount = 0 begin
         select @w_error = 148013
         goto ERROR2
      end
	  set rowcount 0
   end
   
   if @i_opcion = 'E' begin
      set rowcount 600
      select distinct
      'N. REGISTRO'                  = isnull(te_secuencial,0),
      'FECHA'                        = te_fecha,
      'HORA'                         = te_hora,
      'CODIGO ERROR'                 = isnull(te_codigo_error,0),
      'DESC. ERROR'                  = te_desc_error,
      'CAMPO'                        = te_nombre_campo,
      'VALOR'                        = te_valor_campo
      from   cob_pfijo..pf_tasas_error
      where (te_secuencial_archivo   = @w_secuencial_archivo   or @w_secuencial_archivo is null)
      and    isnull(te_secuencial,0)>= @i_sec
      and    te_hora                 > @i_hora_error
      order by isnull(te_secuencial,0), te_hora
	  
      if @@rowcount = 0 and @i_hora_error <> '00:00:00' and @i_sec > 0 begin
         select @w_error = 148013
         goto ERROR2
      end
	  set rowcount 0
   end
   
   if @i_opcion = 'B' begin
      select distinct
      'N. REGISTRO'               = te_secuencial,
      'FECHA'                     = te_fecha,
      'HORA'                      = te_hora,
      'CODIGO ERROR'              = te_codigo_error,
      'DESC. ERROR'               = te_desc_error,
      'CAMPO'                     = te_nombre_campo,
      'VALOR'                     = te_valor_campo
      from  cob_pfijo..pf_tasas_error
      where te_secuencial         = @i_registro
	  and   te_secuencial_archivo = @w_secuencial_archivo
      order by te_secuencial
   end
end

if @i_operacion = 'A' begin
   if @t_trn <> 14373 begin
      select @w_error = 141040
      goto ERROR2
   end
   
   select top 1
   @w_secuencial_archivo     = cat_secuencial_archivo,
   @w_archivo                = cat_nombre_archivo,
   @w_estado_archivo         = cat_estado,
   @w_fecha_vigencia         = cat_fecha_vigencia,
   @w_cant_registros         = cat_numero_registros
   from  cob_pfijo..pf_archivo_carga_tasas
   where cat_estado          = @w_estado_validado
   order by cat_fecha_modificacion desc

   if @@rowcount = 0 begin
      select @w_error = 148013
      goto ERROR2
   end
   
   select
   @v_secuencial_archivo     = cat_secuencial_archivo,
   @v_archivo                = cat_nombre_archivo,
   @v_estado_archivo         = cat_estado,
   @v_fecha_vigencia         = cat_fecha_vigencia,
   @v_cant_registros         = cat_numero_registros
   from  cob_pfijo..pf_archivo_carga_tasas
   where cat_estado          = @w_estado_validado
   and   cat_nombre_archivo <> @w_archivo
   
   if @@rowcount > 0 begin   
      update cob_pfijo..pf_archivo_carga_tasas
      set    cat_estado = @w_estado_cancelado
      where  cat_nombre_archivo = @v_archivo
      
      if @@error <> 0 begin
         select @w_error = 148021
         goto ERROR2
      end
     
      insert into ts_archivo_carga_tasas(
      secuencial,         tipo_transaccion,              clase,                  fecha,           usuario,              terminal,
      srv,                lsrv,                          secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
      numero_registros,   observacion,                   fecha_crea,             fecha_mod,       ofi)
      values(
      @s_ssn,             14873,                         'U',                    @s_date,         @s_user,              @s_term,
      @s_srv,             @s_lsrv,                       @v_secuencial_archivo,  @v_archivo,      @w_estado_cancelado,  @v_fecha_vigencia,
      @v_cant_registros,  'CANCELADO POR NUEVO CARGUE',  @s_date,                @s_date,         @s_ofi)
      
      if @@error <> 0 begin
         select @w_error = 143005
         goto ERROR2
      end
   end
   
   update cob_pfijo..pf_archivo_carga_tasas
   set    cat_estado             = @w_estado_aprobado,
          cat_fecha_modificacion = getdate(),
          cat_usuario            = @s_user,
          cat_terminal           = @s_term,
          cat_observacion        = @i_observacion
   where  cat_nombre_archivo     = @w_archivo
   
   if @@error <> 0 begin
      select @w_error = 148021
      goto ERROR2
   end
   
   insert into ts_archivo_carga_tasas(
   secuencial,         tipo_transaccion,  clase,                  fecha,           usuario,              terminal,
   srv,                lsrv,              secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
   numero_registros,   observacion,       fecha_crea,             fecha_mod,       ofi)
   values(
   @s_ssn,             @t_trn,            'A',                    @s_date,         @s_user,              @s_term,
   @s_srv,             @s_lsrv,           @w_secuencial_archivo,  @w_archivo,      @w_estado_aprobado,   @w_fecha_vigencia,
   @i_cant_registros,  @i_observacion,    @s_date,                @s_date,         @s_ofi)
   
   if @@error <> 0 begin
      select @w_error = 143005
      goto ERROR2
   end
   
   update pf_tasas_masivas
   set    tm_estado = @w_estado_aprobado
   where  tm_secuencial_archivo = @w_secuencial_archivo
   
   if @@error <> 0 begin
      select @w_error = 148030
      goto ERROR2
   end
end

if @i_operacion = 'R' begin
   if @t_trn <> 14673 begin
      select @w_error = 141040
      goto ERROR2
   end
   
   select top 1
   @w_secuencial_archivo     = cat_secuencial_archivo,
   @w_archivo                = cat_nombre_archivo,
   @w_estado_archivo         = cat_estado,
   @w_fecha_vigencia         = cat_fecha_vigencia,
   @w_cant_registros         = cat_numero_registros
   from  cob_pfijo..pf_archivo_carga_tasas
   where cat_estado          = @w_estado_validado
   order by cat_fecha_modificacion desc
   
   if @@rowcount = 0 begin
      select @w_error = 148013
      goto ERROR2
   end
   
   update cob_pfijo..pf_archivo_carga_tasas
   set    cat_estado             = @w_estado_rechazado,
          cat_fecha_modificacion = getdate(),
          cat_usuario            = @s_user,
          cat_terminal           = @s_term,
          cat_observacion        = @i_observacion
   where  cat_nombre_archivo     = @w_archivo
   
   if @@error <> 0 begin
      select @w_error = 148021
      goto ERROR2
   end
   
   insert into ts_archivo_carga_tasas(
   secuencial,         tipo_transaccion,  clase,                  fecha,           usuario,              terminal,
   srv,                lsrv,              secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
   numero_registros,   observacion,       fecha_crea,             fecha_mod,       ofi)
   values(
   @s_ssn,             @t_trn,            'R',                    @s_date,         @s_user,              @s_term,
   @s_srv,             @s_lsrv,           @w_secuencial_archivo,  @w_archivo,      @w_estado_rechazado,  @w_fecha_vigencia,
   @i_cant_registros,  @i_observacion,    @s_date,                @s_date,         @s_ofi)
   
   if @@error <> 0 begin
      select @w_error = 143005
      goto ERROR2
   end
end

if @i_operacion = 'J' begin
   select
   @w_secuencial_archivo = cat_secuencial_archivo,
   @w_archivo            = cat_nombre_archivo,
   @w_fecha_vigencia     = cat_fecha_vigencia,
   @w_cant_registros     = cat_numero_registros,
   @w_usuario            = cat_usuario,
   @w_observacion        = cat_observacion
   from  cob_pfijo..pf_archivo_carga_tasas
   where cat_estado      = @w_estado_aprobado
   order by cat_fecha_modificacion desc
   
   if @@rowcount = 0 begin
      select @w_error = 148013
      goto ERROR2
   end
      
   exec @w_return = cobis..sp_cseqnos
   @t_debug       = @t_debug,
   @t_file        = @t_file,
   @t_from        = @w_sp_name,
   @i_tabla       = 'pf_hist_tasa',
   @o_siguiente   = @w_siguiente_hist out
   
   update cob_pfijo..pf_archivo_carga_tasas
   set    cat_estado             = @w_estado_procesado,
          cat_fecha_modificacion = getdate()
   where  cat_nombre_archivo     = @w_archivo
   
   if @@error <> 0 begin
      select @w_error = 148021
      goto ERROR2
   end
   
   select @w_ssn = convert(int,substring(replace(convert(varchar(12),getdate(),14), ':', ''),4,6))
   
   insert into ts_archivo_carga_tasas(
   secuencial,         tipo_transaccion,  clase,                  fecha,           usuario,              terminal,
   srv,                lsrv,              secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
   numero_registros,   observacion,       fecha_crea,             fecha_mod,       ofi)
   values(
   @w_ssn,             14873,             'P',                    getdate(),       'sa',                 'TERMINAL',
   'KERNELPROD',       'KERNELPROD',      @w_secuencial_archivo,  @w_usuario,      @w_estado_procesado,  @w_fecha_vigencia,
   @w_cant_registros,  @w_observacion,    getdate(),              getdate(),       1)
   
   if @@error <> 0 begin
      select @w_error = 143005
      goto ERROR2
   end
   
   begin tran
   
   insert into cob_pfijo..pf_hist_tasa(
   ht_secuencial,                                                     ht_tipo_deposito,  ht_moneda,      ht_tipo_monto,    ht_tipo_plazo,
   ht_tasa_min,                                                       ht_tasa_max,       ht_vigente,     ht_tasa_min_ant,  ht_tasa_max_ant,
   ht_vigente_ant,                                                    ht_estado,         ht_fecha_crea,  ht_usuario,       ht_usuario_ant,
   ht_fecha_crea_ant,                                                 ht_segmento,       ht_ivc,         ht_prorroga,      ht_momento,
   ht_tipo)
   select 
   @w_siguiente_hist + row_number() over(order by ta_tipo_deposito),  ta_tipo_deposito,  ta_moneda,      ta_tipo_monto,    ta_tipo_plazo,
   ta_tasa_min,                                                       ta_tasa_max,       ta_vigente,     null,             null,
   null,                                                              'E',               ta_fecha_crea,  ta_usuario,       null,
   null,                                                              ta_segmento,       ta_ivc,         ta_prorroga,      ta_momento,
   'N'
   from cob_pfijo..pf_tasa
   
   if @@error <> 0 begin
      while @@trancount > 0
         rollback tran
		 
      select @w_error = 143057
      goto ERROR2
   end
   
   select @w_sec_max = max(ht_secuencial)
   from   pf_hist_tasa
   
   update cobis..cl_seqnos
   set    siguiente = @w_sec_max
   where  tabla     = 'pf_hist_tasa'
   
   exec @w_return = cobis..sp_cseqnos
   @t_debug       = @t_debug,
   @t_file        = @t_file,
   @t_from        = @w_sp_name,
   @i_tabla       = 'pf_hist_tasa_variable',
   @o_siguiente   = @w_siguiente_hist out
   
   insert into cob_pfijo..pf_hist_tasa_variable(
   hv_secuencial,                                                  hv_moneda,          hv_tipo_monto,      hv_tipo_plazo,         hv_tasa_min,
   hv_tasa_max,                                                    hv_spread_min,      hv_spread_max,      hv_spread_vigente,     hv_tasa_min_ant,
   hv_tasa_max_ant,                                                hv_spread_min_ant,  hv_spread_max_ant,  hv_spread_vigente_ant, hv_estado,
   hv_operador,                                                    hv_fecha_crea,      hv_mnemonico_prod,  hv_mnemonico_tasa,     hv_usuario,
   hv_usuario_ant,                                                 hv_fecha_crea_ant,  hv_prorroga,        hv_momento,            hv_segmento,
   hv_ivc)
   select
   @w_siguiente_hist + row_number() over(order by tv_tipo_monto),  tv_moneda,          tv_tipo_monto,      tv_tipo_plazo,         tv_tasa_min,
   tv_tasa_max,                                                    tv_spread_min,      tv_spread_max,      tv_spread_vigente,     null,
   null,                                                           null,               null,               null,                  'E',
   tv_operador,                                                    tv_fecha_crea,      tv_mnemonico_prod,  tv_mnemonico_tasa,     tv_usuario,
   null,                                                           null,               tv_prorroga,        tv_momento,            tv_segmento,
   tv_ivc
   from cob_pfijo..pf_tasa_variable
   
   if @@error <> 0 begin
      while @@trancount > 0
         rollback tran
		 
      select @w_error = 143058
      goto ERROR2
   end
   
   select @w_sec_max = max(hv_secuencial)
   from   pf_hist_tasa_variable
   
   update cobis..cl_seqnos
   set    siguiente = @w_sec_max
   where  tabla     = 'pf_hist_tasa_variable'
   
   truncate table cob_pfijo..pf_tasa
   
   if @@error <> 0 begin
      while @@trancount > 0
         rollback tran
		 
      select @w_error = 147010
      goto ERROR2
   end
   
   truncate table cob_pfijo..pf_tasa_variable
   
   if @@error <> 0 begin
      while @@trancount > 0
         rollback tran
		 
      select @w_error = 147010
      goto ERROR2
   end
   
   insert into pf_tasa(
   ta_tipo_deposito,                       ta_moneda,          ta_tipo_monto,                       ta_tipo_plazo,                       ta_tasa_min,
   ta_tasa_max,                            ta_vigente,         ta_fecha_crea,                       ta_fecha_mod,                        ta_tasa_mer,
   ta_usuario,                             ta_segmento,        ta_momento,                          ta_ivc,                              ta_prorroga,
   ta_tipo)
   select
   convert(varchar(5), tm_tipo_deposito),  tm_moneda,          tm_tipo_monto,                       tm_tipo_plazo,                       tm_tasa_min,
   tm_tasa_max,                            tm_tasa_vigente,    convert(varchar(16),getdate(),101),  convert(varchar(16),getdate(),101),  tm_tasa_vigente,
   @w_usuario,                             tm_tipo_segmento,   tm_momento,                          tm_tipo_ivc,                         tm_prorroga,
   'N'
   from  cob_pfijo..pf_tasas_masivas, cob_pfijo..pf_tipo_deposito
   where tm_tipo_deposito = td_mnemonico
   and   td_tasa_variable = 'N'
   and   tm_estado        = @w_estado_aprobado
   
   if @@error <> 0 begin
      while @@trancount > 0
         rollback tran
		 
      select @w_error = 143010
      goto ERROR2
   end
   
   insert into pf_tasa_variable(
   tv_mnemonico_prod,                      tv_mnemonico_tasa,    tv_tipo_monto,     tv_tipo_plazo,  tv_spread_max,
   tv_spread_min,                          tv_spread_vigente,    tv_moneda,         tv_estado,      tv_fecha_crea,
   tv_fecha_mod,                           tv_operador,          tv_tasa_max,       tv_tasa_min,    tv_usuario,
   tv_prorroga,                            tv_momento,           tv_segmento,       tv_ivc)
   select 
   convert(varchar(5), tm_tipo_deposito),  tm_tasa_referencial,  tm_tipo_monto,     tm_tipo_plazo,  tm_spread,
   tm_spread,                              tm_spread,            tm_moneda,         'E',            convert(varchar(16),getdate(),101),
   convert(varchar(16),getdate(),101),     tm_operador,          tm_tasa_max,       tm_tasa_min,    @w_usuario,
   tm_prorroga,                            tm_momento,           tm_tipo_segmento,  tm_tipo_ivc
   from  cob_pfijo..pf_tasas_masivas, cob_pfijo..pf_tipo_deposito
   where tm_tipo_deposito = td_mnemonico
   and   td_tasa_variable = 'S'
   and   tm_estado        = @w_estado_aprobado
   
   if @@error <> 0 begin
      while @@trancount > 0
         rollback tran
		 
      select @w_error = 143047
      goto ERROR2
   end
   
   while @@trancount > 0
      commit tran
end

return 0

ERROR:
select @w_error      = 148028
select @w_desc_error = mensaje
from   cobis..cl_errores
where  numero = @w_error

update cob_pfijo..pf_archivo_carga_tasas
set    cat_estado = @w_estado_errore
where  cat_secuencial_archivo = @w_secuencial_archivo

insert into ts_archivo_carga_tasas(
secuencial,         tipo_transaccion,  clase,                  fecha,           usuario,              terminal,
srv,                lsrv,              secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
numero_registros,   observacion,       fecha_crea,             fecha_mod,       ofi)
values(
@s_ssn,             14873,             'U',                    @s_date,         @s_user,              @s_term,
@s_srv,             @s_lsrv,           @w_secuencial_archivo,  @i_archivo,      @w_estado_cancelado,  @w_fecha_vigencia,
@i_cant_registros,  @w_desc_error,     @s_date,                @s_date,         @s_ofi)

if @@error <> 0  begin
   select @w_error = 143005
   goto ERROR2
end

insert into pf_tasas_error(
te_secuencial_archivo,  te_secuencial,        te_fecha,                          te_hora,                            te_codigo_error,
te_desc_error,          te_numero_registros,  te_nombre_campo,                   te_valor_campo)
values(
@w_secuencial_archivo,  null,                 getdate(),                         getdate(),                          @w_error,
@w_desc_error,          null,                 'ERROR EN ESTRUCTURA DE ARCHIVO',  'COLUMNA = ' + convert(varchar(23),isnull(@w_columna,'VALOR NULO')) + '| VALOR CAMPO = ' + convert(varchar(23),isnull(@w_registro,'VALOR NULO')) + ' | TIPO DE DEPOSITO = ' + convert(varchar(23),isnull(@w_tipo_deposito,'VALOR NULO')) + ' | MOMENTO = ' + convert(varchar(23),isnull(@w_momento,'VALOR NULO')))

if @@error <> 0  begin
   select @w_error = 203042
   goto ERROR2
end

return @w_error

ERROR2:

if @i_operacion = 'J' begin
   update cob_pfijo..pf_archivo_carga_tasas
   set    cat_estado             = @w_estado_errori,
          cat_fecha_modificacion = getdate()
   where  cat_nombre_archivo     = @w_archivo
   
   if @@error <> 0 begin
      select @w_error = 148021
      goto ERROR2
   end
   
   select @w_ssn = convert(int,substring(replace(convert(varchar(12),getdate(),14), ':', ''),4,6))
   
   insert into ts_archivo_carga_tasas(
   secuencial,         tipo_transaccion,  clase,                  fecha,           usuario,              terminal,
   srv,                lsrv,              secuencial_archivo,     nombre_archivo,  estado,               fecha_vigencia,
   numero_registros,   observacion,       fecha_crea,             fecha_mod,       ofi)
   values(
   @w_ssn,             14873,             'P',                    getdate(),       'sa',                 'TERMINAL',
   'KERNELPROD',       'KERNELPROD',      @w_secuencial_archivo,  @w_usuario,      @w_estado_errori,     @w_fecha_vigencia,
   @w_cant_registros,  @w_observacion,    getdate(),              getdate(),       1)
   
   if @@error <> 0 begin
      select @w_error = 143005
      goto ERROR2
   end
end

if @w_error in (101140, 148017, 148020, 148034) begin
   truncate table pf_tasas_error
   
   if @@error <> 0 begin
      select @w_error = 148019
      goto ERROR2
   end
end 

exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file,
@t_from  = @w_sp_name,
@i_num   = @w_error
return @w_error
go
