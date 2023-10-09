
use cob_cartera
go

/************************************************************************/
/*      Archivo:                commora.sp                              */
/*      Stored procedure:       sp_generar_commora                      */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Javier calderon                         */
/*      Fecha de escritura:     27/06/2017                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.							                            */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                         PROPOSITO                                    */
/*      Tiene como propósito cargar la comision por mora en las         */
/*      operaciones grupales vencidas                                   */
/************************************************************************/  
/*                          MODIFICACIONES                              */
/*  FECHA        AUTOR             RAZON                                */
/*  17/Sep/2019  ACHP/LGU          Se cambia el cursor por while por    */
/*                                 error en el batch                    */
/*  20/Sep/2019  SMO               Se modifica la forma de obtener los  */
/*                                   dias de gracia                     */
/*  02/May/2022  DCU               Caso #180898                         */
/*  02/NOv/2022  DCU               Ajuste dia feriado olvidado          */
/************************************************************************/
  

if exists(select 1 from sysobjects where name = 'sp_generar_commora')
   drop proc sp_generar_commora
go

create proc sp_generar_commora
@i_param1              datetime    = null

as

declare
@w_sp_name        VARCHAR(30),
@w_error          INT,
@w_est_vencido    int,
@w_moneda         TINYINT,
@w_num_dec        int,
@w_commora        catalogo,
@w_commora_ref    catalogo,
@w_tasa_commora   FLOAT,
@w_fecha_proceso  DATETIME,
@w_di_dividendo   int,
@w_tg_grupo       int, 
@w_tg_referencia_grupal VARCHAR(15),
@w_cuota_grupal   MONEY,
@w_tot_commora    MONEY,
@w_total_vencido  MONEY,
@w_banco          VARCHAR(15),
@w_op_operacionca INT,
@w_cuota          MONEY,
@w_valor_commora  MONEY,
@w_descripcion    VARCHAR(60),
@w_commit         CHAR(1),
@w_toperacion     catalogo,
@i_fecha_proceso  DATETIME,
@i_oficina        int,
@w_oficina        smallint,
@w_fecha_ini      datetime,
@w_ciudad_nacional  int,
@w_gracia_mora  int,
@w_tipo_mora    char(1),
@w_fecha_fin    datetime,
@w_num_reg      int,
@w_cont_commora int, 
@w_acum_commora money,
@w_fecha_feriado_inc datetime,
@w_dias_compensa     int,
@w_contador_dias     int,
@w_fecha_nueva       datetime

select 
@w_sp_name    = 'sp_generar_commora',
@w_moneda     = 0, -- Moneda Local
@w_commora    = 'COMMORA',
@w_commit     = 'N',
@w_toperacion = 'GRUPAL'

select @w_fecha_proceso = fc_fecha_cierre 
from cobis..ba_fecha_cierre
where fc_producto = 7

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

select @w_fecha_feriado_inc = pa_datetime
from   cobis..cl_parametro
where  pa_nemonico = 'FEOLFE'
and    pa_producto = 'ADM'

select @w_dias_compensa = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'NDICOM'
and    pa_producto = 'ADM'
/* ESTADOS DE LA CARTERA */
exec @w_error   = sp_estados_cca
@o_est_vencido   = @w_est_vencido   out

if @w_error <> 0
begin 
SELECT @w_descripcion = 'Error !:No exite estado vencido'
goto ERRORFIN
end

--- NUMERO DE DECIMALES 
exec @w_error = sp_decimales
@i_moneda      = @w_moneda ,
@o_decimales   = @w_num_dec out

if @w_error <> 0
begin 
SELECT @w_descripcion = 'Error !:No existe parametro para número de decimales'
goto ERRORFIN
end


/*NUMERO DE DIAS COMMORA*/
/*select @w_gracia_mora = pa_int
from cobis..cl_parametro
where pa_nemonico = 'NCMORA'
and   pa_producto = 'CCA'

if @@rowcount = 0 begin
   select @w_descripcion = 'Error !:No exite parametro general',
          @w_error = 70175
   goto ERRORFIN
end
*/
/*CLASE DE VALOR RUBRO COMMORA*/
select @w_tipo_mora = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CCMORA'
and   pa_producto = 'CCA'

if @@rowcount = 0 begin
   select @w_descripcion = 'Error !:No exite parametro general', 
          @w_error = 70175
   goto ERRORFIN
end

/*DETERMINAR TASA DEL COMMORA */
select
@w_commora_ref   = ru_referencial
from   ca_rubro
where  ru_toperacion = @w_toperacion
and    ru_moneda     = @w_moneda
and    ru_concepto   = @w_commora

if @@rowcount = 0 begin
   select 
   @w_descripcion = 'NO ESTA PARAMETRIZADO EL RUBRO COMMORA PARA ESTE TIPO DE OPERACION',
   @w_error = 701178
   goto ERRORFIN
end

/* DETERMINAR LA TASA DE LA COMISION DE MORA */
select 
@w_tasa_commora  = vd_valor_default 
from   ca_valor, ca_valor_det
where  va_tipo   = @w_commora_ref
and    vd_tipo   = @w_commora_ref
and    vd_sector = 1 /* sector comercial */

if @@rowcount = 0 begin
    select 
	@w_descripcion = 'NO EXISTE TASA REFERENCIAL: '+@w_commora_ref,
	@w_error = 701085
    goto ERRORFIN
end


create table #cargar_commora 
(
 op_banco      cuenta, 
 op_operacion  int,
 op_oficina    int,
 op_cuota      money
)

create table #grupos(
	tg_grupo  int,
	tg_referencia_grupal   varchar(100),
	di_dividendo           int,
	op_margen_redescuento  int,
	di_fecha_ven           datetime,
	di_fecha_ini           datetime,
	di_fecha_fin           datetime
)



--CONDICION DE SALIDA EN CASO DE DOBLE CIERRE POR FIN DE MES NO SE DEBE EJECUTAR
if exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_proceso )
          return 0    

create table #gracia(
   gracia_mora int,
   fecha_ini datetime,
   fecha_fin datetime
)

insert into #gracia
select distinct(op_margen_redescuento),null,null from cob_cartera..ca_operacion,
cob_cartera..ca_estado
where op_toperacion = 'GRUPAL'
and op_estado = es_codigo
and es_procesa = 'S'

select @w_gracia_mora = -1

select @w_fecha_nueva = dateadd(dd,@w_dias_compensa,@w_fecha_feriado_inc)
while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_nueva)
    select @w_fecha_nueva = dateadd(dd,1,@w_fecha_nueva)

--select * from #gracia
while 1=1
begin
   select top 1 @w_gracia_mora =  gracia_mora
   from #gracia 
   where  gracia_mora>@w_gracia_mora
   order by gracia_mora
   
   if @@rowcount = 0
      break
      
   --HASTA ENCONTRAR EL HABIL ANTERIOR
   select  @w_fecha_ini  = dateadd(dd,-1,@w_fecha_proceso)
   
   while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_ini ) 
   select @w_fecha_ini = dateadd(dd,-1,@w_fecha_ini)
   
   select @w_fecha_fin = dateadd (dd,(@w_gracia_mora)*-1,@w_fecha_proceso)
   select @w_fecha_ini = dateadd (dd,(@w_gracia_mora)*-1,@w_fecha_ini)
   
   update #gracia
   set fecha_ini=@w_fecha_ini,
   fecha_fin=@w_fecha_fin
   where gracia_mora =  @w_gracia_mora
end

/*DETERMINAR EL UNIVERSO DE GRUPOS A CARGAR LA COMISION DE MORA*/
insert into #grupos
select distinct tg_grupo, tg_referencia_grupal, di_dividendo,op_margen_redescuento,di_fecha_ven,null,null
from ca_operacion ,cob_credito..cr_tramite_grupal,  ca_dividendo
where op_operacion         = tg_operacion
and   op_operacion         = di_operacion
and   di_estado            = @w_est_vencido
and   op_fecha_ult_proceso = @w_fecha_proceso
--and   di_fecha_ven         between @w_fecha_ini and @w_fecha_fin 
ORDER BY tg_grupo

if @@error <> 0 begin
    select 
	@w_descripcion = 'ERROR AL CREAR UNIVERSO DE GRUPOS A PROCESAR',
	@w_error = 710001
    goto ERRORFIN
END

------------------------------------------------------------------------------------------
--Ajuste por olvido de parametrizar feriado
------------------------------------------------------------------------------------------
if exists(select 1 from #grupos where di_fecha_ven = @w_fecha_feriado_inc)
begin
   update #grupos set
   di_fecha_ven = @w_fecha_nueva 
   where di_fecha_ven = @w_fecha_feriado_inc
end 
------------------------------------------------------------------------------------------

update #grupos
set di_fecha_ini = fecha_ini,
di_fecha_fin     = fecha_fin
from #gracia
where op_margen_redescuento = gracia_mora


delete from #grupos
where di_fecha_ven not between di_fecha_ini and di_fecha_fin
   
declare cursor_grupos cursor for 
SELECT tg_grupo,  tg_referencia_grupal, di_dividendo
FROM #grupos
--for read only

OPEN cursor_grupos

fetch cursor_grupos into @w_tg_grupo, @w_tg_referencia_grupal , @w_di_dividendo

while @@fetch_status = 0  begin
  
   /* CONTROL PARA EVITAR REPROCESAR UN GRUPO YA CARGADO CON COMMORA*/
   if exists (
   select 1 from ca_amortizacion 
   where am_dividendo  = @w_di_dividendo 
   and   am_concepto   = @w_commora
   and   am_operacion in (select tg_operacion 
                          from cob_credito..cr_tramite_grupal 
                          where tg_referencia_grupal = @w_tg_referencia_grupal))
   begin
    goto SIGUIENTE
   end


   /* DETERMINAR EL VALOR DE LA CUOTA GRUPAL */
   select @w_cuota_grupal = sum(am_cuota)
   from ca_amortizacion, ca_operacion
   where op_operacion = am_operacion
   and   am_dividendo = @w_di_dividendo
   and   op_operacion  in (select tg_operacion 
                           from cob_credito..cr_tramite_grupal 
                           where tg_referencia_grupal = @w_tg_referencia_grupal)

   
   /*CALCU:AR EL VALOR DE LA COMISION POR MORA Y SU RESPECTIVO IVA */
   if @w_tipo_mora = 'P'
      select @w_tot_commora   =  round(@w_cuota_grupal * (@w_tasa_commora/100) , @w_num_dec)
   else  
      select @w_tot_commora = @w_tasa_commora
	  
   /*DETERMINAR EL TOTAL VENCIDO */
   select @w_total_vencido = sum(am_cuota)      
   from ca_amortizacion, ca_operacion, ca_dividendo
   where op_operacion = am_operacion
   and   op_operacion = di_operacion
   and   di_dividendo = am_dividendo
   and   am_dividendo = @w_di_dividendo
   and   op_operacion in (select tg_operacion from cob_credito..cr_tramite_grupal 
                          where tg_referencia_grupal = @w_tg_referencia_grupal)
   and   di_estado    = @w_est_vencido
   and   am_concepto  = 'CAP'
  
	
   truncate table #cargar_commora	
	
   insert into #cargar_commora
   select
   op_banco,   
   op_operacion,
   op_oficina,
   op_cuota = sum(am_cuota)       
   from ca_amortizacion, ca_operacion, ca_dividendo
   where op_operacion = am_operacion
   AND   op_operacion = di_operacion
   and   am_dividendo = @w_di_dividendo
   and   am_dividendo = di_dividendo 
   and   am_concepto  = 'CAP'
   and   op_operacion in (select tg_operacion from cob_credito..cr_tramite_grupal 
                          where tg_referencia_grupal = @w_tg_referencia_grupal)
   and   di_estado    = @w_est_vencido
   group by op_banco, op_operacion, op_oficina
   having sum(am_cuota) > 0	
   
   select @w_num_reg = count(1) from #cargar_commora
   
   select @w_cont_commora = 0, @w_acum_commora = 0
    
   if @@trancount = 0 begin
      select @w_commit = 'S'
      begin TRAN ---------------------****************
   END


   /* CURSOR CARGA EN LOS PRESTAMOS VENCIDOS LA COMISION POR MORA */
/*   declare cursor_cargar_commora cursor for
   select
   op_banco,   
   op_operacion,
   op_oficina,
   op_cuota
   from #cargar_commora
   
  -- for read only

   OPEN cursor_cargar_commora
      
   fetch cursor_cargar_commora into @w_banco, @w_op_operacionca, @w_oficina, @w_cuota
*/
   SELECT @w_op_operacionca = 0
   while 1=1 ------*
   begin
      
      select @w_cont_commora = @w_cont_commora + 1
       
	   SELECT TOP 1
		   @w_banco          = op_banco,
		   @w_op_operacionca = op_operacion,
		   @w_oficina        = op_oficina,
		   @w_cuota          = op_cuota
	   from #cargar_commora
	   WHERE op_operacion > @w_op_operacionca
	   ORDER BY op_operacion ASC
      
	   IF @@ROWCOUNT = 0 BREAK
	  
      select @w_valor_commora = round((convert(float, @w_cuota)/convert(float, @w_total_vencido)) * convert(float, @w_tot_commora), @w_num_dec)
	  
		if @w_cont_commora < @w_num_reg 
			select @w_acum_commora = @w_acum_commora + @w_valor_commora
		else 
			select @w_valor_commora = round(@w_tot_commora - @w_acum_commora, @w_num_dec)
                      
      exec @w_error     = sp_otros_cargos
      @s_date           = @w_fecha_proceso,
      @s_user           = 'usrbatch',
      @s_term           = 'consola',
      @s_ofi            = @w_oficina,
      @i_banco          = @w_banco,
      @i_moneda         = @w_moneda, 
      @i_operacion      = 'I',
      @i_toperacion     = @w_toperacion,
      @i_desde_batch    = 'N',   
      @i_en_linea       = 'N',
      @i_tipo_rubro     = 'O',
      @i_concepto       = @w_commora ,
      @i_monto          = @w_valor_commora,      
      @i_div_desde      = @w_di_dividendo,      
      @i_div_hasta      = @w_di_dividendo,
      @i_comentario     = 'GENERADO POR: sp_generar_commora'      
            
      if @w_error != 0  begin
         select @w_descripcion = 'Error ejecutando sp_otros_cargos por batch insertar COMMORA a la operación : ' + @w_banco 
         goto ERROR    
      end
    
      GOTO SIGUIENTEOP
    
      ERROR:
      exec sp_errorlog 
      @i_fecha       = @i_param1,
      @i_error       = @w_error,
      @i_usuario     = 'usrbatch',
      @i_tran        = 7999,
      @i_tran_name   = @w_sp_name,
      @i_cuenta      = @w_banco,
      @i_descripcion = @w_descripcion, 
      @i_rollback  = 'S'
                              
      SIGUIENTEOP:
      -----***********fetch  cursor_cargar_commora into  @w_banco, @w_op_operacionca,@w_oficina, @w_cuota
      
   end --WHILE CURSOR  CARGA COMISION
   
   --close cursor_cargar_commora   		-------------*********
   --deallocate cursor_cargar_commora  -------------*********

   if @w_commit = 'S' begin
      select @w_commit = 'N'
      commit tran
   end

   
   SIGUIENTE:
   fetch  cursor_grupos into @w_tg_grupo, @w_tg_referencia_grupal , @w_di_dividendo
  

end --WHILE CURSOR GRUPOS



close cursor_grupos
deallocate cursor_grupos

return 0

ERRORFIN:

if @w_commit = 'S' begin
   select @w_commit = 'N'
   rollback tran
end

exec sp_errorlog 
@i_fecha       = @w_fecha_proceso,
@i_error       = @w_error,
@i_usuario     = 'usrbatch',
@i_tran        = 7999,
@i_tran_name   = @w_sp_name,
@i_cuenta      = @w_banco,
@i_descripcion = @w_descripcion, 
@i_rollback  = 'S'

return @w_error

go