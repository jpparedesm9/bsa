/************************************************************************/
/*   Archivo:                   cu_carext.sp                            */
/*   Stored procedure:          sp_carga_saldo_ext                      */
/*   Base de datos:             cob_custodia                            */
/*   Producto:                  Custodia                                */
/*   Disenado por:              Monica Vidal                            */
/*   Fecha de escritura:        Marzo-2009                              */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "COBISCORP".                                                       */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBISCORP o su representante.             */
/************************************************************************/
/*                             PROPOSITO                                */
/*   Validar la consistencia de los datos ingresados en los saldos      */
/*   por Entidad Financiera para Colaterales.                           */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_carga_saldo_ext')
    drop proc sp_carga_saldo_ext
go
create proc sp_carga_saldo_ext
@i_fecha              datetime    = null,
@i_archivo            varchar(64) = null,
@i_simulacion         char(1)     = 'S'
as

declare
@w_error              int,           -- VALOR QUE RETORNA
@w_sp_name            varchar(32),   -- NOMBRE STORED PROC
@w_msg                varchar(255),  -- MENSAJE DE ERROR
@w_fecha_hora         datetime,      -- FECHA Y HORA DE CORRDIDA
@w_fecha              datetime,      -- FECHA EN QUE SE REPORTA EL VALOR DE COBERTURA
@w_path               varchar(250),
@w_s_app              varchar(250),
@w_cmd                varchar(250),
@w_bd                 varchar(250),
@w_tabla              varchar(250),
@w_fecha_arch         varchar(10),
@w_comando            varchar(500),
@w_destino            varchar(250),
@w_errores            varchar(250),
@w_ente               int,           -- ENTE COBIS CON EL QUE LA ENTIDAD TIENE LA OBLIGACION
@w_codigo             cuenta,        -- CODIGO/IDENTIFICADOR DE LA OBLIGACION
@w_cobertura          money,         -- VALOR DE COBERTURA (PORCENTAJE DE COBERTURA * SALDO)
@w_ente_char          varchar(10),
@w_max_fecha          datetime,
@w_ente_cobis         int,
@w_cont_error         int,
@w_min_saldo          money,
@w_max_mora           int,
@w_min_calif          catalogo,
@w_fecha_sal          datetime,
@w_ciudad_feriado     int,
@w_path_s_app         varchar(250),
@w_str_oficinas       varchar(500),
@w_str_toperaciones   varchar(500),
@w_oficinas_tmp       varchar(500),
@w_toperaciones_tmp   varchar(500),
@w_oficina            smallint,
@w_toperacion         catalogo,
@w_fecha_ant          datetime,
@w_orden              int,
@w_fecha_habil        datetime


select @w_fecha_hora = getdate()

select @w_max_fecha = max(cd_fecha_proc)
from   cu_colateral_det

if @i_fecha < @w_max_fecha begin
   select @w_msg = 'YA SE HAN CARGADO REGISTROS CON UNA FECHA POSTERIOR A LA INGRESADA'
   goto ERROR
end

select @w_path_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
   select @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
   goto ERROR
end

if exists(select 1
from   cu_colateral_det
where  cd_fecha_proc > @i_fecha) begin
   select @w_msg   = 'NO SE PUEDE CORRER EL PROCESO DE CUSTODIAS SI HAY UNA CORRIDA EN UNA FECHA POSTERIOR'
   goto ERROR
end

truncate table cu_sal_entidad_ext_tmp

/* HAGO EL BCP */
select
@w_s_app      = @w_path_s_app+'s_app',
@w_fecha_arch = convert(varchar, @i_fecha, 112)

select
@w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 19057


/* TABLA DE SALDOS A CUSTODIAR */
select
@w_cmd      = @w_s_app+' bcp -auto -login ',
@w_bd       = 'cob_custodia',
@w_tabla    = 'cu_sal_entidad_ext_tmp',
@i_archivo  = isnull(@i_archivo, @w_fecha_arch +'.txt')

select 
@w_destino  = @w_path + @i_archivo,
@w_errores  = @w_path + @i_archivo+'.err'

select
@w_comando = @w_cmd + @w_bd + '..' + @w_tabla + ' in ' + @w_destino + ' -b5000 -c -e'+@w_errores + ' -t"§" ' + '-config '+@w_s_app+'.ini'

print 'Comando BCP'
print @w_comando 

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO '+@w_destino+ ' '+ convert(varchar, @w_error)
   goto ERROR
end

/*************************************************************************************************************/
/* VALIDA DATOS CARGADOS EN EL BCP Y SI SON CONSISTENTES LO PASA A LA TABLA DE SALDOS POR ENDIDAD DEFINITIVA */
/*************************************************************************************************************/

delete cu_sal_entidad_ext
where se_fecha = @i_fecha

truncate table cu_ofi_entidad_ext


/*INICIALIZO EL CONTADOR DE ERRORES */
select @w_cont_error = 0

select distinct 
ente = se_ente,
fict = 'S'    --POR DEFECTO SUPONGO QUE SON CLIENTES FICTICIOS
into  #ficticio
from  cu_sal_entidad_ext_tmp

/* RECORRO LA TABLA TEMPORAL CARGADA VALIDANDO DATOS INCONSISTENTES */
declare cursor_op_pasivas cursor for select
se_fecha,     se_ente,      se_codigo,
se_cobertura, se_oficinas,  se_toperacion,
convert(varchar(10), se_ente)
from  cu_sal_entidad_ext_tmp

open  cursor_op_pasivas

fetch cursor_op_pasivas into
@w_fecha,     @w_ente,         @w_codigo,
@w_cobertura, @w_str_oficinas, @w_str_toperaciones,
@w_ente_char


while @@fetch_status = 0 begin

   if @@fetch_status = -1 begin
      select @w_msg   = 'ERROR EN EL CURSOR'
      goto ERROR
   end

   if @w_fecha <> @i_fecha begin
      select  @w_msg = 'LA FECHA DEL ARCHIVO NO CORRESPONDE A LA FECHA DE PROCESO INGRESADA'
      goto ERROR_CUR
   end

   if @w_str_oficinas = 'T' and  @i_simulacion = 'N' begin
      select @w_msg   = 'SI NO SE TRATA DE UNA SIMULACION, DEBE DEFINIR LAS OFICINAS ESPECIFICAS '
      goto ERROR_CUR
   end

   select @w_ente_cobis = en_ente
   from   cobis..cl_ente
   where  en_ente = @w_ente

   if @@rowcount = 0 and @i_simulacion = 'N' begin
      select @w_msg = 'SI NO ES SIMULACION LA ENTIDAD FINANCIERA DEBE EXISTIR EN COBIS'
      goto ERROR_CUR
   end

   if @w_ente_cobis = @w_ente begin
      update #ficticio set
      fict = 'N'
      where ente = @w_ente
   end 

   /* CARGA DE OFICINAS Y LINEAS DE CREDITO */
   if @w_str_oficinas = 'T' begin --TODAS
      insert into cu_ofi_entidad_ext(
      oe_fecha,   oe_ente,    oe_codigo,  
      oe_oficina, oe_orden)
      select 
      @w_fecha,   @w_ente,    @w_codigo,
      of_oficina, of_oficina
      from   cobis..cl_oficina
      where  of_bloqueada = 'N'
   
      if @@error <> 0 begin
         select @w_msg = 'ERROR AL INSERTAR EN TABLA DE TRABAJO'
         goto ERROR_CUR
      end
   
   end else begin
      --INSERTO EN LA TEMPORAL TODOS LAS OFICINAS QUE ME ENVIARON SEPARADAS POR ';'
      select @w_orden = 1
      while charindex(';', @w_str_oficinas) <> 0 begin
         select @w_oficinas_tmp = substring(@w_str_oficinas, charindex(';', @w_str_oficinas) + 1, datalength(@w_str_oficinas))
   
         select @w_oficina = convert(smallint, substring(@w_str_oficinas, 1, datalength(@w_str_oficinas) - datalength(@w_oficinas_tmp) - 1))

   
         if exists(select 1 
         from   cobis..cl_oficina
         where  of_oficina = @w_oficina) begin
            insert into cu_ofi_entidad_ext(
            oe_fecha,   oe_ente,    oe_codigo,  
            oe_oficina, oe_orden)
            values(
            @w_fecha,   @w_ente,    @w_codigo,
            @w_oficina, @w_orden)
   
            if @@error <> 0 begin
               select @w_msg = 'ERROR AL INSERTAR EN TABLA DE TRABAJO'
               goto ERROR_CUR
            end
         end else begin
            select @w_msg = 'ERROR, OFICINA NO EXISTE EN COBIS - '+convert(varchar, @w_oficina)
            goto ERROR_CUR
         end
         select @w_orden = @w_orden + 1
   
         select @w_str_oficinas = @w_oficinas_tmp
      end --WHILE
   
      insert into cu_ofi_entidad_ext(
      oe_fecha,   oe_ente,    oe_codigo,  
      oe_oficina, oe_orden)
      values(
      @w_fecha,   @w_ente,    @w_codigo,
      convert(smallint, @w_str_oficinas), @w_orden)
   
      if @@error <> 0 begin
         select @w_msg = 'ERROR AL INSERTAR EN TABLA DE TRABAJO'
         goto ERROR_CUR
      end
   
   end --OFICINAS ESPECIFICAS


   goto SIGUIENTE

   ERROR_CUR:
   exec @w_error = sp_errorlog
   @i_fecha_proc    = @w_fecha_hora,
   @i_tran          = 19057,
   @i_garantia      = @w_ente_char,
   @i_descripcion   = @w_msg

   if @w_error <> 0 return 1

   select @w_cont_error = @w_cont_error + 1

   SIGUIENTE:

   fetch cursor_op_pasivas into
   @w_fecha,     @w_ente,         @w_codigo,
   @w_cobertura, @w_str_oficinas, @w_str_toperaciones,
   @w_ente_char
   
end -- CURSOR_OP_PASIVAS

close cursor_op_pasivas
deallocate cursor_op_pasivas

/* SI NO HUBO INCONSISTENCIAS DE DATOS PASO LOS DATOS CARGADOS A LA TABLA DEFINITIVA */
if @w_cont_error <> 0 begin
   select @w_msg = 'HUBO ERRORES DE CONSISTENCIA DE DATOS AL CARGAR LOS DATOS PARA PROCESO DE CUSTODIA'
   goto ERROR
end

/* SI NO ES SIMULACION VERIFICO QUE UNA OFICINA NO TENGA CUSTODIAS CON 2 ENTIDADES */
if @i_simulacion = 'N' begin
   select 
   @w_oficina = oe_oficina
   from  cu_ofi_entidad_ext
   where oe_fecha = @w_fecha
   group by oe_oficina
   having count(*)>1 

   if @@rowcount > 0 begin
      select @w_msg = 'SI LA OFICINA NO ESTA LIBERADA NO SE PUEDE UTILIZAR PARA OTRA ENTIDAD - '+convert(varchar, @w_oficina)
      goto ERROR
   end
   
end

/* BORRO LOS DATOS INGRESADOS A LA FECHA PARA HACERLO REPROCESABLE */
delete cu_sal_entidad_ext
where se_fecha = @i_fecha

if @@error <> 0 begin
   select @w_msg = 'HUBO UN ERROR AL BORRAR LOS SALDOS EXISTENTES A LA FECHA'
   goto ERROR
end

insert into cu_sal_entidad_ext(
se_fecha,     se_ente,      se_codigo,
se_cobertura, se_ficticio)
select
se_fecha,     se_ente,      se_codigo,
se_cobertura, fict
from cu_sal_entidad_ext_tmp, #ficticio
where se_ente = ente

if @@error <> 0 begin
   select @w_msg = 'HUBO UN ERROR AL INSERTAR LOS DATOS CARGADOS EN LAS TABLAS DEFINITIVAS'
   goto ERROR
end

/***************************************************************/
/* CARGO EL UNIVERSO PARA COLATERALES CON LOS DATOS A LA FECHA */
/***************************************************************/
select @i_fecha = isnull(@i_fecha, fp_fecha)
from   cobis..ba_fecha_proceso

select @w_ciudad_feriado = pa_int
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'CIUN'


--TRAIGO EL PARAMETRO QUE CONTIENE EL MAXIMO NUMERO DE DIAS DE MORA QUE PUEDE TENER  LA OP. ACTIVA
select @w_max_mora = pa_int
from   cobis..cl_parametro
where  pa_producto = 'GAR'
and    pa_nemonico = 'DIAMCS'

if @w_max_mora is null begin
   select @w_msg   = 'PARAMETRO MAX DIAS MORA PARA COLATERALES - DIAMCS DE CARTERA NO DEFINIDO'
   goto ERROR
end

--TRAIGO EL PARAMETRO QUE CONTIENE EL MINIMO SALDO QUE PUEDE TENER  LA OP. ACTIVA
select @w_min_saldo = pa_money
from   cobis..cl_parametro
where  pa_producto = 'GAR'
and    pa_nemonico = 'SMINCS'

if @w_min_saldo is null begin
   select @w_msg   = 'PARAMETRO MAX SALDO PARA COLATERALES - SMINCS DE CARTERA NO DEFINIDO'
   goto ERROR
end

--TRAIGO EL PARAMETRO QUE CONTIENE LA CALIFICACION MINIMA QUE PUEDE TENER  LA OP. ACTIVA
select @w_min_calif = pa_char
from   cobis..cl_parametro
where  pa_producto = 'GAR'
and    pa_nemonico = 'CLMNCS'

if @w_min_calif is null begin
   select @w_msg   = 'PARAMETRO CALIFICACION MINIMA PARA COLATERALES - CLMNCS DE CARTERA NO DEFINIDO'
   goto ERROR
end

--Haya el siguiente dia habil 
 
exec cob_cartera..sp_dia_habil
           @i_fecha    = @i_fecha,
           @i_ciudad   = @w_ciudad_feriado,
           @i_real     = 'S',
           @o_fecha    = @w_fecha_habil out
           

/* SI NO ES SIMULACION TOMO LOS SALDOS AL ULTIMO DIA HABIL DEL MES ANTERIOR */
if @i_simulacion = 'S' or (@i_fecha = @w_fecha_habil)
begin
   select @w_fecha_sal = @i_fecha
end 
else
begin
   /* OBTENGO EL ULTIMO DIA HABIL DEL MES ANTERIOR RESTANDOLE EL DIA DEL MES A LA FECHA DE PROCESO */
     select @w_fecha_sal = dateadd(dd, -1* datepart(dd, @i_fecha), @i_fecha)
end

/* MIENTRAS ESTE EN LA TABLA DE FERIADOS BUSCO DIA ANTERIOR */
while exists(select 1 from cobis..cl_dias_feriados
             where df_ciudad = @w_ciudad_feriado
             and   df_real   = 'S'
             and   df_fecha  = @w_fecha_sal)
begin
   select @w_fecha_sal = dateadd(day,-1, @w_fecha_sal)
end


--BUSCO LA ULTIMA FECHA EN LA QUE SE CORRIO EL PROCESO DE COLATERALES
select @w_fecha_ant = max(cd_fecha_proc)
from   cu_colateral_det
where  cd_fecha_proc    < @i_fecha

truncate table cu_colateral_det_tmp

--SI NO ES SIMULACION VERIFICO QUE NO SE TENGA UNA CORRIDA POSTERIOR Y SI LA HAY ELIMINO LA CORRIDA
--QUE TENGA PARA LA FECHA DE PROCESO, DE MANERA QUE SE PUEDA REPROCESAR EN CASO DE ERROR
if @i_simulacion = 'N' begin

   delete cu_colateral_det
   where  cd_fecha_proc    = @i_fecha

   if @@error <> 0
   begin
      select @w_msg   = 'ERROR AL ELIMINAR REGISTROS PARA REPROCESO'
      goto ERROR
   end

end

--GUARDO LA INFORMACION QUE QUEDO GENERADA EN LA ULTIMA FECHA
insert into cu_colateral_det_tmp (
cdt_ente_pas,       cdt_codigo_pas,     
cdt_banco_act,      cdt_toperacion,     cdt_cliente,
cdt_oficina,        cdt_monto,          cdt_tasa,
cdt_calificacion,   cdt_fecha_ini,      cdt_fecha_fin,
cdt_saldo_cap,      cdt_saldo_int,      cdt_amor_cap,
cdt_amor_int,       cdt_fecha_proc,     cdt_accion)
select
cd_ente_pas,        cd_codigo_pas,      
cd_banco_act,       cd_toperacion,      cd_cliente,
cd_oficina,         cd_monto,           cd_tasa,
cd_calificacion,    cd_fecha_ini,       cd_fecha_fin,
cd_saldo_cap,       cd_saldo_int,       cd_amor_cap,
cd_amor_int,        @i_fecha,           'M'  --LAS OPERACIONES QUE HABIA ANTES, POR DEFECTO SE MANTIENEN
from   cu_colateral_det
where  cd_fecha_proc    = @w_fecha_ant

if @@error <> 0 begin
   select @w_msg   = 'ERROR AL INSERTAR VALORES ANTERIORES EN LA TABLA TEMPORAL'
   goto ERROR
end


truncate table cu_universo_pagares_col

select *
into #sb_dato_operacion
from cob_conta_super..sb_dato_operacion
where do_fecha          = @w_fecha_sal
  and do_fecha_prox_vto > @w_fecha_sal

/* CREO LA TABLA CON EL UNIVERSO DE OPERACIONES ACTIVAS A TENER EN CUENTA*/
insert into cu_universo_pagares_col(
un_banco,                  un_toperacion,             un_cliente,                
un_oficina,                un_monto,                  un_tasa,                   
un_calificacion,           un_fecha_ini,              un_fecha_fin,              
un_saldo_cap,              un_saldo_int,              un_ente_pas,               
un_codigo_pas,             un_estado,                 un_nueva,
un_orden,
un_amor_cap,               
un_amor_int)
select
do_banco,                  do_tipo_operacion,         do_codigo_cliente,         
do_oficina,                do_monto,                  do_tasa,                   
do_calificacion,           do_fecha_concesion,        do_fecha_vencimiento,      
do_saldo_cap,              do_saldo_int,              oe_ente,                         
oe_codigo,                 'D',  /*disponible*/       'S',  /*nuevas*/
oe_orden,
case 
when isnull(do_periodicidad_cuota, 30)/30 = 1  then 'M'
when isnull(do_periodicidad_cuota, 30)/30 = 2  then 'B'
when isnull(do_periodicidad_cuota, 30)/30 = 3  then 'T'
when isnull(do_periodicidad_cuota, 30)/30 = 6  then 'S'
when isnull(do_periodicidad_cuota, 30)/30 = 12 then 'A'
else 'O' end,
case 
when isnull(do_periodicidad_cuota, 30)/30 = 1  then 'M'
when isnull(do_periodicidad_cuota, 30)/30 = 2  then 'B'
when isnull(do_periodicidad_cuota, 30)/30 = 3  then 'T'
when isnull(do_periodicidad_cuota, 30)/30 = 6  then 'S'
when isnull(do_periodicidad_cuota, 30)/30 = 12 then 'A'
else 'O' end
from   #sb_dato_operacion, cu_ofi_entidad_ext
where  do_fecha                  = @w_fecha_sal
--and    isnull(do_estado_cartera, 1) not in (0, 3, 6, 99)
and    do_estado_cartera         = 1
and    do_saldo_cap             >= @w_min_saldo
and    do_edad_mora             <= @w_max_mora
and    do_calificacion          <= @w_min_calif
and    do_tipo_operacion        not in ('CUPOS', 'APROB', 'SLCCUPO', 'SOL_APRO')
and    do_oficina                = oe_oficina

if @@error <> 0 begin
   select @w_msg = 'ERROR AL CREAR UNIVERSO DE OBLIGACIONES PARA CUSTODIAS'
   goto ERROR
end

update cu_universo_pagares_col set
un_nueva  = 'N',
un_estado = 'A'
from   cu_colateral_det_tmp
where  cdt_banco_act = un_banco
and    cdt_ente_pas  = un_ente_pas

if @@error <> 0 begin
   select @w_msg = 'ERROR AL ACTUALIZAR ESTADO DE OBLIGACIONES CUSTODIADAS'
   goto ERROR
end

--ACTUALIZO LA INFORMACION DEL DETALLE DE COLATERALES CON SUS NUEVOS SALDOS Y OFICINAS
update cu_colateral_det_tmp set
cdt_oficina      = un_oficina,     
cdt_orden        = un_orden, 
cdt_monto        = un_monto,        
cdt_tasa         = un_tasa,         
cdt_calificacion = un_calificacion, 
cdt_fecha_fin    = un_fecha_fin,    
cdt_saldo_cap    = un_saldo_cap,    
cdt_saldo_int    = un_saldo_int,    
cdt_amor_cap     = un_amor_cap,     
cdt_amor_int     = un_amor_int     
from   cu_universo_pagares_col
where  un_banco = cdt_banco_act

if @@error <> 0 begin
   select @w_msg   = 'ERROR AL ACTUALIZAR SALDOS DE LA TABLA TEMPORAL'
   goto ERROR
end

return 0

ERROR:
   print @w_msg
   exec @w_error = sp_errorlog
   @i_fecha_proc    = @w_fecha_hora,
   @i_tran          = 19057,
   @i_garantia      = 'ERROR GENERAL',
   @i_descripcion   = @w_msg

   return 1900000

go
