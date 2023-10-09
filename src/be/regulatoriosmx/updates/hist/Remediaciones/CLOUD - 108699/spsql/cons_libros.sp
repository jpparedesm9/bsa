/************************************************************************/
/*  Archivo:               cons_libros.sp                               */
/*  Stored procedure:      sp_consulta_libros                           */
/*  Base de datos:         cob_conta                                    */
/*  Producto:              Contabilidad                                 */
/*  Disenado por:          Andres Muñoz                                 */
/*  Fecha de escritura:    Febrero de 2012                              */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                        PROPOSITO                                     */
/*                                                                      */
/*                       MODIFICACIONES                                 */
/*  FECHA                 AUTOR            RAZON                        */
/************************************************************************/

use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_consulta_libros')
   drop proc sp_consulta_libros
go

create proc sp_consulta_libros(
@s_user              login     = null,
@i_operacion        char(1)    = null,
@i_fecha_ini        datetime   = null,
@i_fecha_fin        datetime   = null,
@i_empresa          tinyint    = 1,
@i_modo             smallint   = null,
@i_siguiente        varchar(15)= null,
@t_trn              smallint   = null
)

as 
declare

@w_error            int,
@w_return           int,
@w_msg              descripcion,
@w_sp_name          varchar(255),
@w_fecha_tran       datetime,
@w_cuenta           int,
@w_nombre_cta       varchar(255),
@w_debito           money,
@w_credito     	    money,
@w_fecha_hoy        datetime,
@w_oficina          smallint,
@w_saldo            money,
@w_saldo_me         money,
@w_debito_me        money,
@w_credito_me       money,
@w_saldo_ant        money,
@s_date             datetime,
@w_secuencial       int,
@w_fecha_ini        varchar(10),
@w_fecha_fin        varchar(10),
@w_siguiente        int


select 
@w_fecha_hoy = getdate(),
@w_sp_name   = 'sp_consulta_libros',
@w_secuencial = 0

select @w_fecha_ini = convert(varchar(10), @i_fecha_ini, 101),
       @w_fecha_fin = convert(varchar(10), @i_fecha_fin, 101)

/* CONSULTA LIBROS DIARIOS */
if @i_operacion = 'D' 
begin
   exec @w_return = sp_extramov_dia
        @i_param1 = @w_fecha_ini,
        @i_param2 = @w_fecha_fin,
        @i_param3 = @i_empresa
   
   if @w_return != 0
   begin
      select @w_error = @w_return
      goto ERROR_FIN 
   end
   
   if @i_modo = 0 begin

      set rowcount 20

      select 
      'SECUENCIAL'          = ld_secuencia,
      'FECHA TRANSACCION'   = convert (varchar(10), ld_fecha_tran,101),
      'CODIGO'              = ld_cuenta,    
      'NOMBRE DE LA CUENTA' = ld_nombre_cta,
      'DEBITOS DIA'         = ld_debito,
      'CREDITOS DIA'        = ld_credito    
      from cb_libromov_dia
      where ld_fecha_tran between @i_fecha_ini and @i_fecha_fin
      and ld_secuencia > @i_siguiente
      order by ld_secuencia, ld_fecha_tran, ld_cuenta
      
      if @@rowcount = 0 begin
         select 
         @w_error = 100000,
         @w_msg = 'No hay datos en el libro diario con esas fechas'
         set rowcount 0 
         goto ERROR_FIN
      end 
      
      set rowcount 0
      
      return 0
      
   end 
   
end -- operacion D
 
/* CONSULTA LIBRO MAYOR */ 
if @i_operacion = 'M' begin
   select @w_fecha_tran = convert(datetime, (@i_fecha_ini - 31))
   select @w_fecha_hoy = convert(datetime, @i_fecha_ini)
   
   set rowcount 500
   select @w_siguiente = isnull(convert(int,@i_siguiente),0)
   
   if @i_modo = 0 begin
	  
      select 
      'REGISTRO'         = lm_secuencial,
      'OFICINA'          = lm_oficina,
	  'AREA'             = lm_area,
      'CUENTA'           = lm_cuenta,
      'NOMBRE CUENTA'    = lm_nombre,
      'SALDO INICIAL'    = lm_saldo_ini,
	  'SALDO INICIAL ME' = lm_saldo_ini_me,
      'DEBITO'           = lm_debito,
      'DEBITO ME'        = lm_debito_me,
      'CREDITO'          = lm_credito,
      'CREDITO ME'       = lm_credito_me,
      'SALDO FINAL'      = lm_saldo_fin,
	  'SALDO FINAL ME'   = lm_saldo_fin_me,
      'SALDO PROMEDIO'   = lm_saldo_pro,
	  'SALDO PROMEDIO ME'= lm_saldo_pro_me	  
      from cb_libromov_mayba
      where lm_secuencial > @w_siguiente
      and lm_user        = @s_user
      order by lm_secuencial
      
      return 0
      
   end
   
end -- operacion M

if @i_operacion = 'N' begin
   SELECT convert(varchar(2), nc_nivel_cuenta) + '-'+ substring(nc_descripcion, 1, 12)
   from cob_conta..cb_nivel_cuenta with(nolock)
   where nc_empresa = @i_empresa
   
   if @@rowcount = 0 begin
      select 
      @w_error = 100000,
      @w_msg = 'No existen niveles de cuenta para la empresa'
      set rowcount 0 
      goto ERROR_FIN
   end

end

return 0

ERROR_FIN:

exec cobis..sp_cerror
@t_from  = @w_sp_name,
@i_num   = @w_error,
@i_msg   = @w_msg

return @w_error



GO